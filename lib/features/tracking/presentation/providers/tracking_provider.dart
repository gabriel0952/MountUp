import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gpx/gpx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/geo_utils.dart';
import '../../domain/entities/track_point.dart';
import '../../domain/entities/tracking_session_state.dart';

part 'tracking_provider.g.dart';

// ── Foreground Task ───────────────────────────────────────────

@pragma('vm:entry-point')
void trackingTaskCallback() {
  FlutterForegroundTask.setTaskHandler(_TrackingTaskHandler());
}

class _TrackingTaskHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {}
  @override
  void onRepeatEvent(DateTime timestamp) {}
  @override
  Future<void> onDestroy(DateTime timestamp) async {}
}

// ── Notifier ──────────────────────────────────────────────────

@Riverpod(keepAlive: true)
class TrackingNotifier extends _$TrackingNotifier {
  StreamSubscription<Position>? _positionSub;
  Timer? _timer;

  static const _accuracyThreshold = 20.0; // 公尺
  static const _smoothingWindow = 5;       // 移動平均視窗

  @override
  TrackingSessionState build() => const TrackingSessionState();

  // ── 定位權限 ──────────────────────────────────────────────

  Future<bool> requestPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) return false;
    var p = await Geolocator.checkPermission();
    if (p == LocationPermission.denied) {
      p = await Geolocator.requestPermission();
    }
    return p == LocationPermission.always || p == LocationPermission.whileInUse;
  }

  // ── 開始追蹤 ──────────────────────────────────────────────

  Future<bool> startTracking() async {
    if (!await requestPermission()) return false;

    state = TrackingSessionState(
      status: TrackingStatus.active,
      referenceRoute: state.referenceRoute, // 保留已匯入的 GPX 路線
    );

    await _startForegroundService();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.status == TrackingStatus.active) {
        state = state.copyWith(elapsedSeconds: state.elapsedSeconds + 1);
      }
    });

    final LocationSettings locationSettings;
    if (Platform.isAndroid) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 3,
        forceLocationManager: true, // 繞過 FusedLocationProvider，確保 GPS 提供 altitude
      );
    } else {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 3,
        activityType: ActivityType.fitness,
      );
    }

    _positionSub = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen(_onPosition);

    return true;
  }

  // ── GPS 點位處理（精度過濾 + 移動平均平滑）────────────────

  void _onPosition(Position position) {
    if (position.accuracy > _accuracyThreshold) return;

    final raw = TrackPoint(
      lat: position.latitude,
      lng: position.longitude,
      elevation: position.altitude,
      accuracy: position.accuracy,
      timestamp: DateTime.now(),
    );

    final smoothed = _applyMovingAverage(raw, state.trackPoints);
    final points = [...state.trackPoints, smoothed];

    // 累積距離
    double distance = state.distanceKm;
    if (points.length >= 2) {
      final prev = points[points.length - 2];
      distance += GeoUtils.haversineDistance(
            prev.lat, prev.lng, smoothed.lat, smoothed.lng) /
          1000;
    }

    // 累積爬升（正增量 > 1m 才計）
    double elevGain = state.elevationGainM;
    if (points.length >= 2 && smoothed.elevation != null) {
      final prev = points[points.length - 2];
      if (prev.elevation != null) {
        final diff = smoothed.elevation! - prev.elevation!;
        if (diff > 1.0) elevGain += diff;
      }
    }

    state = state.copyWith(
      trackPoints: points,
      distanceKm: distance,
      elevationGainM: elevGain,
      currentSpeedMs: position.speed < 0 ? 0 : position.speed,
    );
  }

  /// 移動平均平滑：對最近 [_smoothingWindow] 個點取平均（lat/lng/elevation）
  TrackPoint _applyMovingAverage(TrackPoint newPt, List<TrackPoint> history) {
    if (history.length < 2) return newPt;
    final take = min(_smoothingWindow - 1, history.length);
    final window = [...history.sublist(history.length - take), newPt];
    final avgLat = window.map((p) => p.lat).reduce((a, b) => a + b) / window.length;
    final avgLng = window.map((p) => p.lng).reduce((a, b) => a + b) / window.length;
    final eleWindow = window.where((p) => p.elevation != null).toList();
    final avgEle = eleWindow.isEmpty
        ? newPt.elevation
        : eleWindow.map((p) => p.elevation!).reduce((a, b) => a + b) / eleWindow.length;
    return newPt.copyWith(lat: avgLat, lng: avgLng, elevation: avgEle);
  }

  // ── 結束追蹤 ──────────────────────────────────────────────

  Future<void> stopTracking() async {
    await _positionSub?.cancel();
    _positionSub = null;
    _timer?.cancel();
    _timer = null;
    await FlutterForegroundTask.stopService();
    state = state.copyWith(status: TrackingStatus.stopped);
  }

  void reset() => state = const TrackingSessionState();

  // ── GPX 路線匯入 ──────────────────────────────────────────

  /// 從 String 載入 GPX（路線資料庫直接傳入）
  void loadGpxFromString(String content) {
    final gpxData = GpxReader().fromString(content);
    final points = gpxData.trks
        .expand((trk) => trk.trksegs)
        .expand((seg) => seg.trkpts)
        .where((pt) => pt.lat != null && pt.lon != null)
        .map((pt) => TrackPoint(
              lat: pt.lat!,
              lng: pt.lon!,
              elevation: pt.ele,
              accuracy: 0,
              timestamp: pt.time ?? DateTime.now(),
            ))
        .toList();
    if (points.isNotEmpty) {
      state = state.copyWith(referenceRoute: points);
    }
  }

  /// 選取 .gpx 檔案並解析為參考路線，疊加到地圖
  Future<bool> importGpxRoute() async {
    // iOS 不支援 GPX 為自訂 UTI，改用 FileType.any 後驗證副檔名
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result == null || result.files.single.path == null) return false;

    final path = result.files.single.path!;
    if (!path.toLowerCase().endsWith('.gpx')) return false;

    final content = await File(path).readAsString();
    final gpxData = GpxReader().fromString(content);

    final points = gpxData.trks
        .expand((trk) => trk.trksegs)
        .expand((seg) => seg.trkpts)
        .where((pt) => pt.lat != null && pt.lon != null)
        .map((pt) => TrackPoint(
              lat: pt.lat!,
              lng: pt.lon!,
              elevation: pt.ele,
              accuracy: 0,
              timestamp: pt.time ?? DateTime.now(),
            ))
        .toList();

    if (points.isEmpty) return false;
    state = state.copyWith(referenceRoute: points);
    return true;
  }

  void clearReferenceRoute() =>
      state = state.copyWith(referenceRoute: const []);

  // ── 前景 Service ──────────────────────────────────────────

  Future<void> _startForegroundService() async {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'mountup_tracking',
        channelName: '健行追蹤',
        channelDescription: 'MountUp GPS 追蹤中',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(10000),
        autoRunOnBoot: false,
        allowWakeLock: true,
      ),
    );

    await FlutterForegroundTask.startService(
      serviceId: 1001,
      notificationTitle: 'MountUp 追蹤中',
      notificationText: '健行進行中，點擊返回 APP',
      callback: trackingTaskCallback,
    );
  }
}
