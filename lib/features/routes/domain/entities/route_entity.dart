import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_entity.freezed.dart';

@freezed
abstract class RouteEntity with _$RouteEntity {
  const factory RouteEntity({
    required String id,
    required String name,
    String? region,
    String? difficulty,
    double? distanceKm,
    int? elevationM,
    String? description,
    String? gpxUrl,
    String? coverUrl,
    @Default(true) bool isOfficial,
    String? gpxLocalPath,
  }) = _RouteEntity;
}
