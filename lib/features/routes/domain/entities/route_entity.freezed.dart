// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RouteEntity {

 String get id; String get name; String? get region; String? get difficulty; double? get distanceKm; int? get elevationM; String? get description; String? get gpxUrl; String? get coverUrl; bool get isOfficial; String? get gpxLocalPath;
/// Create a copy of RouteEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RouteEntityCopyWith<RouteEntity> get copyWith => _$RouteEntityCopyWithImpl<RouteEntity>(this as RouteEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RouteEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.region, region) || other.region == region)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.elevationM, elevationM) || other.elevationM == elevationM)&&(identical(other.description, description) || other.description == description)&&(identical(other.gpxUrl, gpxUrl) || other.gpxUrl == gpxUrl)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.isOfficial, isOfficial) || other.isOfficial == isOfficial)&&(identical(other.gpxLocalPath, gpxLocalPath) || other.gpxLocalPath == gpxLocalPath));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,region,difficulty,distanceKm,elevationM,description,gpxUrl,coverUrl,isOfficial,gpxLocalPath);

@override
String toString() {
  return 'RouteEntity(id: $id, name: $name, region: $region, difficulty: $difficulty, distanceKm: $distanceKm, elevationM: $elevationM, description: $description, gpxUrl: $gpxUrl, coverUrl: $coverUrl, isOfficial: $isOfficial, gpxLocalPath: $gpxLocalPath)';
}


}

/// @nodoc
abstract mixin class $RouteEntityCopyWith<$Res>  {
  factory $RouteEntityCopyWith(RouteEntity value, $Res Function(RouteEntity) _then) = _$RouteEntityCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? region, String? difficulty, double? distanceKm, int? elevationM, String? description, String? gpxUrl, String? coverUrl, bool isOfficial, String? gpxLocalPath
});




}
/// @nodoc
class _$RouteEntityCopyWithImpl<$Res>
    implements $RouteEntityCopyWith<$Res> {
  _$RouteEntityCopyWithImpl(this._self, this._then);

  final RouteEntity _self;
  final $Res Function(RouteEntity) _then;

/// Create a copy of RouteEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? region = freezed,Object? difficulty = freezed,Object? distanceKm = freezed,Object? elevationM = freezed,Object? description = freezed,Object? gpxUrl = freezed,Object? coverUrl = freezed,Object? isOfficial = null,Object? gpxLocalPath = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String?,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,elevationM: freezed == elevationM ? _self.elevationM : elevationM // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,gpxUrl: freezed == gpxUrl ? _self.gpxUrl : gpxUrl // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,isOfficial: null == isOfficial ? _self.isOfficial : isOfficial // ignore: cast_nullable_to_non_nullable
as bool,gpxLocalPath: freezed == gpxLocalPath ? _self.gpxLocalPath : gpxLocalPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RouteEntity].
extension RouteEntityPatterns on RouteEntity {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RouteEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RouteEntity() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RouteEntity value)  $default,){
final _that = this;
switch (_that) {
case _RouteEntity():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RouteEntity value)?  $default,){
final _that = this;
switch (_that) {
case _RouteEntity() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? region,  String? difficulty,  double? distanceKm,  int? elevationM,  String? description,  String? gpxUrl,  String? coverUrl,  bool isOfficial,  String? gpxLocalPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RouteEntity() when $default != null:
return $default(_that.id,_that.name,_that.region,_that.difficulty,_that.distanceKm,_that.elevationM,_that.description,_that.gpxUrl,_that.coverUrl,_that.isOfficial,_that.gpxLocalPath);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? region,  String? difficulty,  double? distanceKm,  int? elevationM,  String? description,  String? gpxUrl,  String? coverUrl,  bool isOfficial,  String? gpxLocalPath)  $default,) {final _that = this;
switch (_that) {
case _RouteEntity():
return $default(_that.id,_that.name,_that.region,_that.difficulty,_that.distanceKm,_that.elevationM,_that.description,_that.gpxUrl,_that.coverUrl,_that.isOfficial,_that.gpxLocalPath);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? region,  String? difficulty,  double? distanceKm,  int? elevationM,  String? description,  String? gpxUrl,  String? coverUrl,  bool isOfficial,  String? gpxLocalPath)?  $default,) {final _that = this;
switch (_that) {
case _RouteEntity() when $default != null:
return $default(_that.id,_that.name,_that.region,_that.difficulty,_that.distanceKm,_that.elevationM,_that.description,_that.gpxUrl,_that.coverUrl,_that.isOfficial,_that.gpxLocalPath);case _:
  return null;

}
}

}

/// @nodoc


class _RouteEntity implements RouteEntity {
  const _RouteEntity({required this.id, required this.name, this.region, this.difficulty, this.distanceKm, this.elevationM, this.description, this.gpxUrl, this.coverUrl, this.isOfficial = true, this.gpxLocalPath});
  

@override final  String id;
@override final  String name;
@override final  String? region;
@override final  String? difficulty;
@override final  double? distanceKm;
@override final  int? elevationM;
@override final  String? description;
@override final  String? gpxUrl;
@override final  String? coverUrl;
@override@JsonKey() final  bool isOfficial;
@override final  String? gpxLocalPath;

/// Create a copy of RouteEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RouteEntityCopyWith<_RouteEntity> get copyWith => __$RouteEntityCopyWithImpl<_RouteEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RouteEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.region, region) || other.region == region)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.elevationM, elevationM) || other.elevationM == elevationM)&&(identical(other.description, description) || other.description == description)&&(identical(other.gpxUrl, gpxUrl) || other.gpxUrl == gpxUrl)&&(identical(other.coverUrl, coverUrl) || other.coverUrl == coverUrl)&&(identical(other.isOfficial, isOfficial) || other.isOfficial == isOfficial)&&(identical(other.gpxLocalPath, gpxLocalPath) || other.gpxLocalPath == gpxLocalPath));
}


@override
int get hashCode => Object.hash(runtimeType,id,name,region,difficulty,distanceKm,elevationM,description,gpxUrl,coverUrl,isOfficial,gpxLocalPath);

@override
String toString() {
  return 'RouteEntity(id: $id, name: $name, region: $region, difficulty: $difficulty, distanceKm: $distanceKm, elevationM: $elevationM, description: $description, gpxUrl: $gpxUrl, coverUrl: $coverUrl, isOfficial: $isOfficial, gpxLocalPath: $gpxLocalPath)';
}


}

/// @nodoc
abstract mixin class _$RouteEntityCopyWith<$Res> implements $RouteEntityCopyWith<$Res> {
  factory _$RouteEntityCopyWith(_RouteEntity value, $Res Function(_RouteEntity) _then) = __$RouteEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? region, String? difficulty, double? distanceKm, int? elevationM, String? description, String? gpxUrl, String? coverUrl, bool isOfficial, String? gpxLocalPath
});




}
/// @nodoc
class __$RouteEntityCopyWithImpl<$Res>
    implements _$RouteEntityCopyWith<$Res> {
  __$RouteEntityCopyWithImpl(this._self, this._then);

  final _RouteEntity _self;
  final $Res Function(_RouteEntity) _then;

/// Create a copy of RouteEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? region = freezed,Object? difficulty = freezed,Object? distanceKm = freezed,Object? elevationM = freezed,Object? description = freezed,Object? gpxUrl = freezed,Object? coverUrl = freezed,Object? isOfficial = null,Object? gpxLocalPath = freezed,}) {
  return _then(_RouteEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,difficulty: freezed == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as String?,distanceKm: freezed == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double?,elevationM: freezed == elevationM ? _self.elevationM : elevationM // ignore: cast_nullable_to_non_nullable
as int?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,gpxUrl: freezed == gpxUrl ? _self.gpxUrl : gpxUrl // ignore: cast_nullable_to_non_nullable
as String?,coverUrl: freezed == coverUrl ? _self.coverUrl : coverUrl // ignore: cast_nullable_to_non_nullable
as String?,isOfficial: null == isOfficial ? _self.isOfficial : isOfficial // ignore: cast_nullable_to_non_nullable
as bool,gpxLocalPath: freezed == gpxLocalPath ? _self.gpxLocalPath : gpxLocalPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
