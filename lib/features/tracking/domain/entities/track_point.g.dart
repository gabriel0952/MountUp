// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrackPoint _$TrackPointFromJson(Map<String, dynamic> json) => _TrackPoint(
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
  elevation: (json['elevation'] as num?)?.toDouble(),
  accuracy: (json['accuracy'] as num).toDouble(),
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$TrackPointToJson(_TrackPoint instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'elevation': instance.elevation,
      'accuracy': instance.accuracy,
      'timestamp': instance.timestamp.toIso8601String(),
    };
