// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tracking_session_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TrackingSessionState {

 TrackingStatus get status; List<TrackPoint> get trackPoints; double get distanceKm; double get elevationGainM; double get currentSpeedMs; int get elapsedSeconds;/// 匯入的 GPX 參考路線（地圖藍線疊加）
 List<TrackPoint> get referenceRoute;
/// Create a copy of TrackingSessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackingSessionStateCopyWith<TrackingSessionState> get copyWith => _$TrackingSessionStateCopyWithImpl<TrackingSessionState>(this as TrackingSessionState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrackingSessionState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.trackPoints, trackPoints)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.elevationGainM, elevationGainM) || other.elevationGainM == elevationGainM)&&(identical(other.currentSpeedMs, currentSpeedMs) || other.currentSpeedMs == currentSpeedMs)&&(identical(other.elapsedSeconds, elapsedSeconds) || other.elapsedSeconds == elapsedSeconds)&&const DeepCollectionEquality().equals(other.referenceRoute, referenceRoute));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(trackPoints),distanceKm,elevationGainM,currentSpeedMs,elapsedSeconds,const DeepCollectionEquality().hash(referenceRoute));

@override
String toString() {
  return 'TrackingSessionState(status: $status, trackPoints: $trackPoints, distanceKm: $distanceKm, elevationGainM: $elevationGainM, currentSpeedMs: $currentSpeedMs, elapsedSeconds: $elapsedSeconds, referenceRoute: $referenceRoute)';
}


}

/// @nodoc
abstract mixin class $TrackingSessionStateCopyWith<$Res>  {
  factory $TrackingSessionStateCopyWith(TrackingSessionState value, $Res Function(TrackingSessionState) _then) = _$TrackingSessionStateCopyWithImpl;
@useResult
$Res call({
 TrackingStatus status, List<TrackPoint> trackPoints, double distanceKm, double elevationGainM, double currentSpeedMs, int elapsedSeconds, List<TrackPoint> referenceRoute
});




}
/// @nodoc
class _$TrackingSessionStateCopyWithImpl<$Res>
    implements $TrackingSessionStateCopyWith<$Res> {
  _$TrackingSessionStateCopyWithImpl(this._self, this._then);

  final TrackingSessionState _self;
  final $Res Function(TrackingSessionState) _then;

/// Create a copy of TrackingSessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? trackPoints = null,Object? distanceKm = null,Object? elevationGainM = null,Object? currentSpeedMs = null,Object? elapsedSeconds = null,Object? referenceRoute = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TrackingStatus,trackPoints: null == trackPoints ? _self.trackPoints : trackPoints // ignore: cast_nullable_to_non_nullable
as List<TrackPoint>,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,elevationGainM: null == elevationGainM ? _self.elevationGainM : elevationGainM // ignore: cast_nullable_to_non_nullable
as double,currentSpeedMs: null == currentSpeedMs ? _self.currentSpeedMs : currentSpeedMs // ignore: cast_nullable_to_non_nullable
as double,elapsedSeconds: null == elapsedSeconds ? _self.elapsedSeconds : elapsedSeconds // ignore: cast_nullable_to_non_nullable
as int,referenceRoute: null == referenceRoute ? _self.referenceRoute : referenceRoute // ignore: cast_nullable_to_non_nullable
as List<TrackPoint>,
  ));
}

}


/// Adds pattern-matching-related methods to [TrackingSessionState].
extension TrackingSessionStatePatterns on TrackingSessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrackingSessionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrackingSessionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrackingSessionState value)  $default,){
final _that = this;
switch (_that) {
case _TrackingSessionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrackingSessionState value)?  $default,){
final _that = this;
switch (_that) {
case _TrackingSessionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TrackingStatus status,  List<TrackPoint> trackPoints,  double distanceKm,  double elevationGainM,  double currentSpeedMs,  int elapsedSeconds,  List<TrackPoint> referenceRoute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrackingSessionState() when $default != null:
return $default(_that.status,_that.trackPoints,_that.distanceKm,_that.elevationGainM,_that.currentSpeedMs,_that.elapsedSeconds,_that.referenceRoute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TrackingStatus status,  List<TrackPoint> trackPoints,  double distanceKm,  double elevationGainM,  double currentSpeedMs,  int elapsedSeconds,  List<TrackPoint> referenceRoute)  $default,) {final _that = this;
switch (_that) {
case _TrackingSessionState():
return $default(_that.status,_that.trackPoints,_that.distanceKm,_that.elevationGainM,_that.currentSpeedMs,_that.elapsedSeconds,_that.referenceRoute);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TrackingStatus status,  List<TrackPoint> trackPoints,  double distanceKm,  double elevationGainM,  double currentSpeedMs,  int elapsedSeconds,  List<TrackPoint> referenceRoute)?  $default,) {final _that = this;
switch (_that) {
case _TrackingSessionState() when $default != null:
return $default(_that.status,_that.trackPoints,_that.distanceKm,_that.elevationGainM,_that.currentSpeedMs,_that.elapsedSeconds,_that.referenceRoute);case _:
  return null;

}
}

}

/// @nodoc


class _TrackingSessionState implements TrackingSessionState {
  const _TrackingSessionState({this.status = TrackingStatus.idle, final  List<TrackPoint> trackPoints = const [], this.distanceKm = 0.0, this.elevationGainM = 0.0, this.currentSpeedMs = 0.0, this.elapsedSeconds = 0, final  List<TrackPoint> referenceRoute = const []}): _trackPoints = trackPoints,_referenceRoute = referenceRoute;
  

@override@JsonKey() final  TrackingStatus status;
 final  List<TrackPoint> _trackPoints;
@override@JsonKey() List<TrackPoint> get trackPoints {
  if (_trackPoints is EqualUnmodifiableListView) return _trackPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trackPoints);
}

@override@JsonKey() final  double distanceKm;
@override@JsonKey() final  double elevationGainM;
@override@JsonKey() final  double currentSpeedMs;
@override@JsonKey() final  int elapsedSeconds;
/// 匯入的 GPX 參考路線（地圖藍線疊加）
 final  List<TrackPoint> _referenceRoute;
/// 匯入的 GPX 參考路線（地圖藍線疊加）
@override@JsonKey() List<TrackPoint> get referenceRoute {
  if (_referenceRoute is EqualUnmodifiableListView) return _referenceRoute;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_referenceRoute);
}


/// Create a copy of TrackingSessionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackingSessionStateCopyWith<_TrackingSessionState> get copyWith => __$TrackingSessionStateCopyWithImpl<_TrackingSessionState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrackingSessionState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._trackPoints, _trackPoints)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.elevationGainM, elevationGainM) || other.elevationGainM == elevationGainM)&&(identical(other.currentSpeedMs, currentSpeedMs) || other.currentSpeedMs == currentSpeedMs)&&(identical(other.elapsedSeconds, elapsedSeconds) || other.elapsedSeconds == elapsedSeconds)&&const DeepCollectionEquality().equals(other._referenceRoute, _referenceRoute));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_trackPoints),distanceKm,elevationGainM,currentSpeedMs,elapsedSeconds,const DeepCollectionEquality().hash(_referenceRoute));

@override
String toString() {
  return 'TrackingSessionState(status: $status, trackPoints: $trackPoints, distanceKm: $distanceKm, elevationGainM: $elevationGainM, currentSpeedMs: $currentSpeedMs, elapsedSeconds: $elapsedSeconds, referenceRoute: $referenceRoute)';
}


}

/// @nodoc
abstract mixin class _$TrackingSessionStateCopyWith<$Res> implements $TrackingSessionStateCopyWith<$Res> {
  factory _$TrackingSessionStateCopyWith(_TrackingSessionState value, $Res Function(_TrackingSessionState) _then) = __$TrackingSessionStateCopyWithImpl;
@override @useResult
$Res call({
 TrackingStatus status, List<TrackPoint> trackPoints, double distanceKm, double elevationGainM, double currentSpeedMs, int elapsedSeconds, List<TrackPoint> referenceRoute
});




}
/// @nodoc
class __$TrackingSessionStateCopyWithImpl<$Res>
    implements _$TrackingSessionStateCopyWith<$Res> {
  __$TrackingSessionStateCopyWithImpl(this._self, this._then);

  final _TrackingSessionState _self;
  final $Res Function(_TrackingSessionState) _then;

/// Create a copy of TrackingSessionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? trackPoints = null,Object? distanceKm = null,Object? elevationGainM = null,Object? currentSpeedMs = null,Object? elapsedSeconds = null,Object? referenceRoute = null,}) {
  return _then(_TrackingSessionState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TrackingStatus,trackPoints: null == trackPoints ? _self._trackPoints : trackPoints // ignore: cast_nullable_to_non_nullable
as List<TrackPoint>,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,elevationGainM: null == elevationGainM ? _self.elevationGainM : elevationGainM // ignore: cast_nullable_to_non_nullable
as double,currentSpeedMs: null == currentSpeedMs ? _self.currentSpeedMs : currentSpeedMs // ignore: cast_nullable_to_non_nullable
as double,elapsedSeconds: null == elapsedSeconds ? _self.elapsedSeconds : elapsedSeconds // ignore: cast_nullable_to_non_nullable
as int,referenceRoute: null == referenceRoute ? _self._referenceRoute : referenceRoute // ignore: cast_nullable_to_non_nullable
as List<TrackPoint>,
  ));
}


}

// dart format on
