import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:go_router/go_router.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_radius.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../domain/entities/track_point.dart';
import '../../domain/entities/tracking_session_state.dart';
import '../providers/tracking_provider.dart';
import '../widgets/tracking_stats_overlay.dart';
import '../widgets/tracking_summary_sheet.dart';

class TrackingPage extends ConsumerStatefulWidget {
  const TrackingPage({super.key});

  @override
  ConsumerState<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends ConsumerState<TrackingPage> {
  MapboxMap? _mapboxMap;
  PolylineAnnotationManager? _trackManager;
  PolylineAnnotationManager? _refManager;

  bool _mapUpdating = false;
  bool _refUpdating = false;

  // 追蹤結束時的最終狀態快照，確保摘要資料正確
  TrackingSessionState? _stoppedState;

  // ── Map 初始化 ────────────────────────────────────────────

  Future<void> _onMapCreated(MapboxMap map) async {
    _mapboxMap = map;
    _refManager = await map.annotations.createPolylineAnnotationManager();
    _trackManager = await map.annotations.createPolylineAnnotationManager();

    try {
      final pos = await geo.Geolocator.getCurrentPosition(
        locationSettings: const geo.LocationSettings(
          accuracy: geo.LocationAccuracy.high,
        ),
      );
      await map.flyTo(
        CameraOptions(
          center: Point(coordinates: Position(pos.longitude, pos.latitude)),
          zoom: 14.0,
        ),
        MapAnimationOptions(duration: 1200),
      );
    } catch (_) {
      await map.setCamera(
        CameraOptions(
          center: Point(coordinates: Position(121.0, 23.7)),
          zoom: 7.0,
        ),
      );
    }

    final refRoute = ref.read(trackingProvider).referenceRoute;
    if (refRoute.isNotEmpty) _updateRefRoute(refRoute);
  }

  // ── 地圖更新 ──────────────────────────────────────────────

  Future<void> _updateTrack(List<TrackPoint> points) async {
    if (_mapUpdating || _trackManager == null || points.length < 2) return;
    _mapUpdating = true;
    try {
      await _trackManager!.deleteAll();
      await _trackManager!.create(
        PolylineAnnotationOptions(
          geometry: LineString(
              coordinates: points.map((p) => Position(p.lng, p.lat)).toList()),
          lineColor: const Color(0xFF4CAF82).toARGB32(),
          lineWidth: 3.5,
          lineJoin: LineJoin.ROUND,
        ),
      );
      final last = points.last;
      await _mapboxMap?.setCamera(CameraOptions(
        center: Point(coordinates: Position(last.lng, last.lat)),
      ));
    } finally {
      _mapUpdating = false;
    }
  }

  Future<void> _updateRefRoute(List<TrackPoint> points) async {
    if (_refUpdating || _refManager == null) return;
    _refUpdating = true;
    try {
      await _refManager!.deleteAll();
      if (points.length < 2) return;
      await _refManager!.create(
        PolylineAnnotationOptions(
          geometry: LineString(
              coordinates: points.map((p) => Position(p.lng, p.lat)).toList()),
          lineColor: const Color(0xFF42A5F5).toARGB32(),
          lineWidth: 2.5,
          lineJoin: LineJoin.ROUND,
        ),
      );
      final first = points.first;
      await _mapboxMap?.flyTo(
        CameraOptions(
          center: Point(coordinates: Position(first.lng, first.lat)),
          zoom: 13.0,
        ),
        MapAnimationOptions(duration: 1000),
      );
    } finally {
      _refUpdating = false;
    }
  }

  // ── 操作 ──────────────────────────────────────────────────

  Future<void> _handleStart() async {
    final ok = await ref.read(trackingProvider.notifier).startTracking();
    if (!ok && mounted) _showPermissionDialog();
  }

  Future<void> _handleImportGpx() async {
    final ok = await ref.read(trackingProvider.notifier).importGpxRoute();
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('請選取 .gpx 檔案')),
      );
    }
  }

  void _handleBack(TrackingStatus status) {
    if (status == TrackingStatus.active) {
      _showExitDialog();
    } else {
      context.go('/activities');
    }
  }

  void _showPermissionDialog() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('需要定位權限'),
        content: const Text('請至設定開啟「位置」權限，MountUp 才能記錄 GPS 軌跡。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              geo.Geolocator.openAppSettings();
            },
            child: const Text('前往設定'),
          ),
        ],
      ),
    );
  }

  void _showExitDialog() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('確定要離開？'),
        content: const Text('追蹤仍在進行中，離開後可從首頁返回繼續追蹤。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('繼續追蹤'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.go('/activities');
            },
            child: const Text('離開'),
          ),
        ],
      ),
    );
  }

  void _showSummarySheet(TrackingSessionState state) {
    // 用 addPostFrameCallback 確保在 build 完成後才開啟 sheet
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      showModalBottomSheet<void>(
        context: context,
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
        ),
        builder: (_) => TrackingSummarySheet(
          state: state,
          onSave: (title) async {
            Navigator.pop(context);
            ref.read(trackingProvider.notifier).reset();
            context.go('/activities');
          },
          onDiscard: () {
            Navigator.pop(context);
            ref.read(trackingProvider.notifier).reset();
            context.go('/activities');
          },
        ),
      );
    });
  }

  // ── Build ─────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = isDark ? AppColors.darkPrimary : AppColors.lightPrimary;

    ref.listen<TrackingSessionState>(trackingProvider, (prev, next) {
      if (next.trackPoints.length != (prev?.trackPoints.length ?? 0)) {
        _updateTrack(next.trackPoints);
      }
      if (next.referenceRoute.length != (prev?.referenceRoute.length ?? 0)) {
        _updateRefRoute(next.referenceRoute);
      }
      // 追蹤結束：快照最終狀態，再顯示摘要
      if (prev?.status != TrackingStatus.stopped &&
          next.status == TrackingStatus.stopped) {
        _stoppedState = next;
        _showSummarySheet(_stoppedState!);
      }
    });

    final state = ref.watch(trackingProvider);
    final isActive = state.status == TrackingStatus.active;
    final isIdle = state.status == TrackingStatus.idle;

    return Scaffold(
      body: Stack(
        children: [
          // ── 地圖（全螢幕）────────────────────────────────
          MapWidget(
            onMapCreated: _onMapCreated,
            styleUri: MapboxStyles.OUTDOORS,
          ),

          // ── 追蹤中 HUD（頂部）────────────────────────────
          if (isActive)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: TrackingStatsOverlay(state: state),
            ),

          // ── 待機：頂部按鈕列（返回 + GPX）────────────────
          if (isIdle)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s12,
                    vertical: AppSpacing.s8,
                  ),
                  child: Row(
                    children: [
                      _MapButton(
                        icon: Icons.arrow_back_rounded,
                        onTap: () => _handleBack(state.status),
                      ),
                      const Spacer(),
                      if (state.referenceRoute.isNotEmpty) ...[
                        _MapButton(
                          icon: Icons.layers_clear_rounded,
                          tooltip: '清除路線',
                          onTap: () => ref
                              .read(trackingProvider.notifier)
                              .clearReferenceRoute(),
                        ),
                        const SizedBox(width: AppSpacing.s8),
                      ],
                      _MapButton(
                        icon: Icons.file_open_rounded,
                        tooltip: '匯入 GPX 路線',
                        onTap: _handleImportGpx,
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // ── 待機：底部「開始追蹤」按鈕 ───────────────────
          if (isIdle)
            Positioned(
              bottom: AppSpacing.s48,
              left: 0,
              right: 0,
              child: Center(
                child: _PillButton(
                  label: '開始追蹤',
                  icon: Icons.play_arrow_rounded,
                  color: primary,
                  onTap: _handleStart,
                ),
              ),
            ),

          // ── 追蹤中：底部操作列（返回 ← ⏹ 結束）─────────
          if (isActive)
            Positioned(
              bottom: AppSpacing.s32,
              left: AppSpacing.s16,
              right: AppSpacing.s16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _MapButton(
                    icon: Icons.arrow_back_rounded,
                    onTap: () => _handleBack(state.status),
                  ),
                  _PillButton(
                    label: '結束追蹤',
                    icon: Icons.stop_rounded,
                    color: AppColors.darkError,
                    onTap: () =>
                        ref.read(trackingProvider.notifier).stopTracking(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ── 地圖圓形按鈕（白底陰影）──────────────────────────────────

class _MapButton extends StatelessWidget {
  const _MapButton({
    required this.icon,
    required this.onTap,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final btn = Material(
      color: Colors.white,
      borderRadius: AppRadius.fullBorder,
      elevation: 3,
      shadowColor: Colors.black38,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.fullBorder,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s12),
          child: Icon(icon, color: Colors.black87, size: 22),
        ),
      ),
    );
    if (tooltip != null) return Tooltip(message: tooltip!, child: btn);
    return btn;
  }
}

// ── 膠囊形主要按鈕 ────────────────────────────────────────────

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: AppRadius.fullBorder,
      elevation: 4,
      shadowColor: Colors.black38,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.fullBorder,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s24,
            vertical: AppSpacing.s16,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 22),
              const SizedBox(width: AppSpacing.s8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
