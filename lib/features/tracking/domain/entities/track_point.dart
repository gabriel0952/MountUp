import 'package:freezed_annotation/freezed_annotation.dart';

part 'track_point.freezed.dart';
part 'track_point.g.dart';

@freezed
abstract class TrackPoint with _$TrackPoint {
  const factory TrackPoint({
    required double lat,
    required double lng,
    double? elevation,
    required double accuracy,
    required DateTime timestamp,
  }) = _TrackPoint;

  factory TrackPoint.fromJson(Map<String, dynamic> json) =>
      _$TrackPointFromJson(json);
}
