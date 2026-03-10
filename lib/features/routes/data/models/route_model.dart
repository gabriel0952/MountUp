import '../../domain/entities/route_entity.dart';

class RouteModel {
  const RouteModel({
    required this.id,
    required this.name,
    this.region,
    this.difficulty,
    this.distanceKm,
    this.elevationM,
    this.description,
    this.gpxUrl,
    this.coverUrl,
    this.isOfficial = true,
    this.gpxLocalPath,
  });

  final String id;
  final String name;
  final String? region;
  final String? difficulty;
  final double? distanceKm;
  final int? elevationM;
  final String? description;
  final String? gpxUrl;
  final String? coverUrl;
  final bool isOfficial;
  final String? gpxLocalPath;

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
        id: json['id'] as String,
        name: json['name'] as String,
        region: json['region'] as String?,
        difficulty: json['difficulty'] as String?,
        distanceKm: (json['distance_km'] as num?)?.toDouble(),
        elevationM: json['elevation_m'] as int?,
        description: json['description'] as String?,
        gpxUrl: json['gpx_url'] as String?,
        coverUrl: json['cover_url'] as String?,
        isOfficial: (json['is_official'] as bool?) ?? true,
      );

  RouteEntity toEntity() => RouteEntity(
        id: id,
        name: name,
        region: region,
        difficulty: difficulty,
        distanceKm: distanceKm,
        elevationM: elevationM,
        description: description,
        gpxUrl: gpxUrl,
        coverUrl: coverUrl,
        isOfficial: isOfficial,
        gpxLocalPath: gpxLocalPath,
      );
}
