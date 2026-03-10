import 'package:freezed_annotation/freezed_annotation.dart';
import 'track_point.dart';

part 'tracking_session_state.freezed.dart';

enum TrackingStatus { idle, active, stopped }

@freezed
abstract class TrackingSessionState with _$TrackingSessionState {
  const factory TrackingSessionState({
    @Default(TrackingStatus.idle) TrackingStatus status,
    @Default([]) List<TrackPoint> trackPoints,
    @Default(0.0) double distanceKm,
    @Default(0.0) double elevationGainM,
    @Default(0.0) double currentSpeedMs,
    @Default(0) int elapsedSeconds,
    /// 匯入的 GPX 參考路線（地圖藍線疊加）
    @Default([]) List<TrackPoint> referenceRoute,
  }) = _TrackingSessionState;
}
