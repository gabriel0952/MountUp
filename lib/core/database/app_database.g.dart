// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ActivitiesTable extends Activities
    with TableInfo<$ActivitiesTable, Activity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _uuid(),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _distanceKmMeta = const VerificationMeta(
    'distanceKm',
  );
  @override
  late final GeneratedColumn<double> distanceKm = GeneratedColumn<double>(
    'distance_km',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _elevationMMeta = const VerificationMeta(
    'elevationM',
  );
  @override
  late final GeneratedColumn<int> elevationM = GeneratedColumn<int>(
    'elevation_m',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationSMeta = const VerificationMeta(
    'durationS',
  );
  @override
  late final GeneratedColumn<int> durationS = GeneratedColumn<int>(
    'duration_s',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('completed'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _trackJsonMeta = const VerificationMeta(
    'trackJson',
  );
  @override
  late final GeneratedColumn<String> trackJson = GeneratedColumn<String>(
    'track_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _routeIdMeta = const VerificationMeta(
    'routeId',
  );
  @override
  late final GeneratedColumn<String> routeId = GeneratedColumn<String>(
    'route_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    date,
    distanceKm,
    elevationM,
    durationS,
    status,
    notes,
    trackJson,
    routeId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activities';
  @override
  VerificationContext validateIntegrity(
    Insertable<Activity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('distance_km')) {
      context.handle(
        _distanceKmMeta,
        distanceKm.isAcceptableOrUnknown(data['distance_km']!, _distanceKmMeta),
      );
    }
    if (data.containsKey('elevation_m')) {
      context.handle(
        _elevationMMeta,
        elevationM.isAcceptableOrUnknown(data['elevation_m']!, _elevationMMeta),
      );
    }
    if (data.containsKey('duration_s')) {
      context.handle(
        _durationSMeta,
        durationS.isAcceptableOrUnknown(data['duration_s']!, _durationSMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('track_json')) {
      context.handle(
        _trackJsonMeta,
        trackJson.isAcceptableOrUnknown(data['track_json']!, _trackJsonMeta),
      );
    }
    if (data.containsKey('route_id')) {
      context.handle(
        _routeIdMeta,
        routeId.isAcceptableOrUnknown(data['route_id']!, _routeIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Activity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Activity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      distanceKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_km'],
      ),
      elevationM: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elevation_m'],
      ),
      durationS: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_s'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      trackJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}track_json'],
      ),
      routeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}route_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ActivitiesTable createAlias(String alias) {
    return $ActivitiesTable(attachedDatabase, alias);
  }
}

class Activity extends DataClass implements Insertable<Activity> {
  final String id;
  final String title;
  final DateTime date;
  final double? distanceKm;
  final int? elevationM;
  final int? durationS;
  final String status;
  final String? notes;
  final String? trackJson;
  final String? routeId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Activity({
    required this.id,
    required this.title,
    required this.date,
    this.distanceKm,
    this.elevationM,
    this.durationS,
    required this.status,
    this.notes,
    this.trackJson,
    this.routeId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || distanceKm != null) {
      map['distance_km'] = Variable<double>(distanceKm);
    }
    if (!nullToAbsent || elevationM != null) {
      map['elevation_m'] = Variable<int>(elevationM);
    }
    if (!nullToAbsent || durationS != null) {
      map['duration_s'] = Variable<int>(durationS);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || trackJson != null) {
      map['track_json'] = Variable<String>(trackJson);
    }
    if (!nullToAbsent || routeId != null) {
      map['route_id'] = Variable<String>(routeId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ActivitiesCompanion toCompanion(bool nullToAbsent) {
    return ActivitiesCompanion(
      id: Value(id),
      title: Value(title),
      date: Value(date),
      distanceKm: distanceKm == null && nullToAbsent
          ? const Value.absent()
          : Value(distanceKm),
      elevationM: elevationM == null && nullToAbsent
          ? const Value.absent()
          : Value(elevationM),
      durationS: durationS == null && nullToAbsent
          ? const Value.absent()
          : Value(durationS),
      status: Value(status),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      trackJson: trackJson == null && nullToAbsent
          ? const Value.absent()
          : Value(trackJson),
      routeId: routeId == null && nullToAbsent
          ? const Value.absent()
          : Value(routeId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Activity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Activity(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      date: serializer.fromJson<DateTime>(json['date']),
      distanceKm: serializer.fromJson<double?>(json['distanceKm']),
      elevationM: serializer.fromJson<int?>(json['elevationM']),
      durationS: serializer.fromJson<int?>(json['durationS']),
      status: serializer.fromJson<String>(json['status']),
      notes: serializer.fromJson<String?>(json['notes']),
      trackJson: serializer.fromJson<String?>(json['trackJson']),
      routeId: serializer.fromJson<String?>(json['routeId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'date': serializer.toJson<DateTime>(date),
      'distanceKm': serializer.toJson<double?>(distanceKm),
      'elevationM': serializer.toJson<int?>(elevationM),
      'durationS': serializer.toJson<int?>(durationS),
      'status': serializer.toJson<String>(status),
      'notes': serializer.toJson<String?>(notes),
      'trackJson': serializer.toJson<String?>(trackJson),
      'routeId': serializer.toJson<String?>(routeId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Activity copyWith({
    String? id,
    String? title,
    DateTime? date,
    Value<double?> distanceKm = const Value.absent(),
    Value<int?> elevationM = const Value.absent(),
    Value<int?> durationS = const Value.absent(),
    String? status,
    Value<String?> notes = const Value.absent(),
    Value<String?> trackJson = const Value.absent(),
    Value<String?> routeId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Activity(
    id: id ?? this.id,
    title: title ?? this.title,
    date: date ?? this.date,
    distanceKm: distanceKm.present ? distanceKm.value : this.distanceKm,
    elevationM: elevationM.present ? elevationM.value : this.elevationM,
    durationS: durationS.present ? durationS.value : this.durationS,
    status: status ?? this.status,
    notes: notes.present ? notes.value : this.notes,
    trackJson: trackJson.present ? trackJson.value : this.trackJson,
    routeId: routeId.present ? routeId.value : this.routeId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Activity copyWithCompanion(ActivitiesCompanion data) {
    return Activity(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      date: data.date.present ? data.date.value : this.date,
      distanceKm: data.distanceKm.present
          ? data.distanceKm.value
          : this.distanceKm,
      elevationM: data.elevationM.present
          ? data.elevationM.value
          : this.elevationM,
      durationS: data.durationS.present ? data.durationS.value : this.durationS,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      trackJson: data.trackJson.present ? data.trackJson.value : this.trackJson,
      routeId: data.routeId.present ? data.routeId.value : this.routeId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Activity(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('date: $date, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('elevationM: $elevationM, ')
          ..write('durationS: $durationS, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('trackJson: $trackJson, ')
          ..write('routeId: $routeId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    date,
    distanceKm,
    elevationM,
    durationS,
    status,
    notes,
    trackJson,
    routeId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Activity &&
          other.id == this.id &&
          other.title == this.title &&
          other.date == this.date &&
          other.distanceKm == this.distanceKm &&
          other.elevationM == this.elevationM &&
          other.durationS == this.durationS &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.trackJson == this.trackJson &&
          other.routeId == this.routeId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ActivitiesCompanion extends UpdateCompanion<Activity> {
  final Value<String> id;
  final Value<String> title;
  final Value<DateTime> date;
  final Value<double?> distanceKm;
  final Value<int?> elevationM;
  final Value<int?> durationS;
  final Value<String> status;
  final Value<String?> notes;
  final Value<String?> trackJson;
  final Value<String?> routeId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ActivitiesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.date = const Value.absent(),
    this.distanceKm = const Value.absent(),
    this.elevationM = const Value.absent(),
    this.durationS = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.trackJson = const Value.absent(),
    this.routeId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivitiesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required DateTime date,
    this.distanceKm = const Value.absent(),
    this.elevationM = const Value.absent(),
    this.durationS = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.trackJson = const Value.absent(),
    this.routeId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : title = Value(title),
       date = Value(date);
  static Insertable<Activity> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<DateTime>? date,
    Expression<double>? distanceKm,
    Expression<int>? elevationM,
    Expression<int>? durationS,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<String>? trackJson,
    Expression<String>? routeId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (date != null) 'date': date,
      if (distanceKm != null) 'distance_km': distanceKm,
      if (elevationM != null) 'elevation_m': elevationM,
      if (durationS != null) 'duration_s': durationS,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (trackJson != null) 'track_json': trackJson,
      if (routeId != null) 'route_id': routeId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivitiesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<DateTime>? date,
    Value<double?>? distanceKm,
    Value<int?>? elevationM,
    Value<int?>? durationS,
    Value<String>? status,
    Value<String?>? notes,
    Value<String?>? trackJson,
    Value<String?>? routeId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ActivitiesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      distanceKm: distanceKm ?? this.distanceKm,
      elevationM: elevationM ?? this.elevationM,
      durationS: durationS ?? this.durationS,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      trackJson: trackJson ?? this.trackJson,
      routeId: routeId ?? this.routeId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (distanceKm.present) {
      map['distance_km'] = Variable<double>(distanceKm.value);
    }
    if (elevationM.present) {
      map['elevation_m'] = Variable<int>(elevationM.value);
    }
    if (durationS.present) {
      map['duration_s'] = Variable<int>(durationS.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (trackJson.present) {
      map['track_json'] = Variable<String>(trackJson.value);
    }
    if (routeId.present) {
      map['route_id'] = Variable<String>(routeId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivitiesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('date: $date, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('elevationM: $elevationM, ')
          ..write('durationS: $durationS, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('trackJson: $trackJson, ')
          ..write('routeId: $routeId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivityPhotosTable extends ActivityPhotos
    with TableInfo<$ActivityPhotosTable, ActivityPhoto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityPhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _uuid(),
  );
  static const VerificationMeta _activityIdMeta = const VerificationMeta(
    'activityId',
  );
  @override
  late final GeneratedColumn<String> activityId = GeneratedColumn<String>(
    'activity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES activities (id)',
    ),
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double> lng = GeneratedColumn<double>(
    'lng',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _takenAtMeta = const VerificationMeta(
    'takenAt',
  );
  @override
  late final GeneratedColumn<DateTime> takenAt = GeneratedColumn<DateTime>(
    'taken_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    activityId,
    localPath,
    lat,
    lng,
    takenAt,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivityPhoto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('activity_id')) {
      context.handle(
        _activityIdMeta,
        activityId.isAcceptableOrUnknown(data['activity_id']!, _activityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_activityIdMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    }
    if (data.containsKey('lng')) {
      context.handle(
        _lngMeta,
        lng.isAcceptableOrUnknown(data['lng']!, _lngMeta),
      );
    }
    if (data.containsKey('taken_at')) {
      context.handle(
        _takenAtMeta,
        takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityPhoto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityPhoto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      activityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_id'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      ),
      lng: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lng'],
      ),
      takenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}taken_at'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ActivityPhotosTable createAlias(String alias) {
    return $ActivityPhotosTable(attachedDatabase, alias);
  }
}

class ActivityPhoto extends DataClass implements Insertable<ActivityPhoto> {
  final String id;
  final String activityId;
  final String localPath;
  final double? lat;
  final double? lng;
  final DateTime? takenAt;
  final int sortOrder;
  const ActivityPhoto({
    required this.id,
    required this.activityId,
    required this.localPath,
    this.lat,
    this.lng,
    this.takenAt,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['activity_id'] = Variable<String>(activityId);
    map['local_path'] = Variable<String>(localPath);
    if (!nullToAbsent || lat != null) {
      map['lat'] = Variable<double>(lat);
    }
    if (!nullToAbsent || lng != null) {
      map['lng'] = Variable<double>(lng);
    }
    if (!nullToAbsent || takenAt != null) {
      map['taken_at'] = Variable<DateTime>(takenAt);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ActivityPhotosCompanion toCompanion(bool nullToAbsent) {
    return ActivityPhotosCompanion(
      id: Value(id),
      activityId: Value(activityId),
      localPath: Value(localPath),
      lat: lat == null && nullToAbsent ? const Value.absent() : Value(lat),
      lng: lng == null && nullToAbsent ? const Value.absent() : Value(lng),
      takenAt: takenAt == null && nullToAbsent
          ? const Value.absent()
          : Value(takenAt),
      sortOrder: Value(sortOrder),
    );
  }

  factory ActivityPhoto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityPhoto(
      id: serializer.fromJson<String>(json['id']),
      activityId: serializer.fromJson<String>(json['activityId']),
      localPath: serializer.fromJson<String>(json['localPath']),
      lat: serializer.fromJson<double?>(json['lat']),
      lng: serializer.fromJson<double?>(json['lng']),
      takenAt: serializer.fromJson<DateTime?>(json['takenAt']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'activityId': serializer.toJson<String>(activityId),
      'localPath': serializer.toJson<String>(localPath),
      'lat': serializer.toJson<double?>(lat),
      'lng': serializer.toJson<double?>(lng),
      'takenAt': serializer.toJson<DateTime?>(takenAt),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ActivityPhoto copyWith({
    String? id,
    String? activityId,
    String? localPath,
    Value<double?> lat = const Value.absent(),
    Value<double?> lng = const Value.absent(),
    Value<DateTime?> takenAt = const Value.absent(),
    int? sortOrder,
  }) => ActivityPhoto(
    id: id ?? this.id,
    activityId: activityId ?? this.activityId,
    localPath: localPath ?? this.localPath,
    lat: lat.present ? lat.value : this.lat,
    lng: lng.present ? lng.value : this.lng,
    takenAt: takenAt.present ? takenAt.value : this.takenAt,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  ActivityPhoto copyWithCompanion(ActivityPhotosCompanion data) {
    return ActivityPhoto(
      id: data.id.present ? data.id.value : this.id,
      activityId: data.activityId.present
          ? data.activityId.value
          : this.activityId,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      lat: data.lat.present ? data.lat.value : this.lat,
      lng: data.lng.present ? data.lng.value : this.lng,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityPhoto(')
          ..write('id: $id, ')
          ..write('activityId: $activityId, ')
          ..write('localPath: $localPath, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('takenAt: $takenAt, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, activityId, localPath, lat, lng, takenAt, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityPhoto &&
          other.id == this.id &&
          other.activityId == this.activityId &&
          other.localPath == this.localPath &&
          other.lat == this.lat &&
          other.lng == this.lng &&
          other.takenAt == this.takenAt &&
          other.sortOrder == this.sortOrder);
}

class ActivityPhotosCompanion extends UpdateCompanion<ActivityPhoto> {
  final Value<String> id;
  final Value<String> activityId;
  final Value<String> localPath;
  final Value<double?> lat;
  final Value<double?> lng;
  final Value<DateTime?> takenAt;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const ActivityPhotosCompanion({
    this.id = const Value.absent(),
    this.activityId = const Value.absent(),
    this.localPath = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivityPhotosCompanion.insert({
    this.id = const Value.absent(),
    required String activityId,
    required String localPath,
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : activityId = Value(activityId),
       localPath = Value(localPath);
  static Insertable<ActivityPhoto> custom({
    Expression<String>? id,
    Expression<String>? activityId,
    Expression<String>? localPath,
    Expression<double>? lat,
    Expression<double>? lng,
    Expression<DateTime>? takenAt,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (activityId != null) 'activity_id': activityId,
      if (localPath != null) 'local_path': localPath,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (takenAt != null) 'taken_at': takenAt,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivityPhotosCompanion copyWith({
    Value<String>? id,
    Value<String>? activityId,
    Value<String>? localPath,
    Value<double?>? lat,
    Value<double?>? lng,
    Value<DateTime?>? takenAt,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return ActivityPhotosCompanion(
      id: id ?? this.id,
      activityId: activityId ?? this.activityId,
      localPath: localPath ?? this.localPath,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      takenAt: takenAt ?? this.takenAt,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (activityId.present) {
      map['activity_id'] = Variable<String>(activityId.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<DateTime>(takenAt.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityPhotosCompanion(')
          ..write('id: $id, ')
          ..write('activityId: $activityId, ')
          ..write('localPath: $localPath, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('takenAt: $takenAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GearListsTable extends GearLists
    with TableInfo<$GearListsTable, GearList> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GearListsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _uuid(),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gear_lists';
  @override
  VerificationContext validateIntegrity(
    Insertable<GearList> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GearList map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GearList(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GearListsTable createAlias(String alias) {
    return $GearListsTable(attachedDatabase, alias);
  }
}

class GearList extends DataClass implements Insertable<GearList> {
  final String id;
  final String name;
  final DateTime createdAt;
  const GearList({
    required this.id,
    required this.name,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GearListsCompanion toCompanion(bool nullToAbsent) {
    return GearListsCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory GearList.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GearList(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  GearList copyWith({String? id, String? name, DateTime? createdAt}) =>
      GearList(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );
  GearList copyWithCompanion(GearListsCompanion data) {
    return GearList(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GearList(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GearList &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class GearListsCompanion extends UpdateCompanion<GearList> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const GearListsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GearListsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<GearList> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GearListsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return GearListsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GearListsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GearItemsTable extends GearItems
    with TableInfo<$GearItemsTable, GearItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GearItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => _uuid(),
  );
  static const VerificationMeta _gearListIdMeta = const VerificationMeta(
    'gearListId',
  );
  @override
  late final GeneratedColumn<String> gearListId = GeneratedColumn<String>(
    'gear_list_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES gear_lists (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCheckedMeta = const VerificationMeta(
    'isChecked',
  );
  @override
  late final GeneratedColumn<bool> isChecked = GeneratedColumn<bool>(
    'is_checked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_checked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gearListId,
    name,
    category,
    isChecked,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gear_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<GearItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('gear_list_id')) {
      context.handle(
        _gearListIdMeta,
        gearListId.isAcceptableOrUnknown(
          data['gear_list_id']!,
          _gearListIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gearListIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('is_checked')) {
      context.handle(
        _isCheckedMeta,
        isChecked.isAcceptableOrUnknown(data['is_checked']!, _isCheckedMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GearItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GearItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gearListId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gear_list_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      isChecked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_checked'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $GearItemsTable createAlias(String alias) {
    return $GearItemsTable(attachedDatabase, alias);
  }
}

class GearItem extends DataClass implements Insertable<GearItem> {
  final String id;
  final String gearListId;
  final String name;
  final String? category;
  final bool isChecked;
  final int sortOrder;
  const GearItem({
    required this.id,
    required this.gearListId,
    required this.name,
    this.category,
    required this.isChecked,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['gear_list_id'] = Variable<String>(gearListId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['is_checked'] = Variable<bool>(isChecked);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  GearItemsCompanion toCompanion(bool nullToAbsent) {
    return GearItemsCompanion(
      id: Value(id),
      gearListId: Value(gearListId),
      name: Value(name),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      isChecked: Value(isChecked),
      sortOrder: Value(sortOrder),
    );
  }

  factory GearItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GearItem(
      id: serializer.fromJson<String>(json['id']),
      gearListId: serializer.fromJson<String>(json['gearListId']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String?>(json['category']),
      isChecked: serializer.fromJson<bool>(json['isChecked']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gearListId': serializer.toJson<String>(gearListId),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String?>(category),
      'isChecked': serializer.toJson<bool>(isChecked),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  GearItem copyWith({
    String? id,
    String? gearListId,
    String? name,
    Value<String?> category = const Value.absent(),
    bool? isChecked,
    int? sortOrder,
  }) => GearItem(
    id: id ?? this.id,
    gearListId: gearListId ?? this.gearListId,
    name: name ?? this.name,
    category: category.present ? category.value : this.category,
    isChecked: isChecked ?? this.isChecked,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  GearItem copyWithCompanion(GearItemsCompanion data) {
    return GearItem(
      id: data.id.present ? data.id.value : this.id,
      gearListId: data.gearListId.present
          ? data.gearListId.value
          : this.gearListId,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      isChecked: data.isChecked.present ? data.isChecked.value : this.isChecked,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GearItem(')
          ..write('id: $id, ')
          ..write('gearListId: $gearListId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('isChecked: $isChecked, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, gearListId, name, category, isChecked, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GearItem &&
          other.id == this.id &&
          other.gearListId == this.gearListId &&
          other.name == this.name &&
          other.category == this.category &&
          other.isChecked == this.isChecked &&
          other.sortOrder == this.sortOrder);
}

class GearItemsCompanion extends UpdateCompanion<GearItem> {
  final Value<String> id;
  final Value<String> gearListId;
  final Value<String> name;
  final Value<String?> category;
  final Value<bool> isChecked;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const GearItemsCompanion({
    this.id = const Value.absent(),
    this.gearListId = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.isChecked = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GearItemsCompanion.insert({
    this.id = const Value.absent(),
    required String gearListId,
    required String name,
    this.category = const Value.absent(),
    this.isChecked = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : gearListId = Value(gearListId),
       name = Value(name);
  static Insertable<GearItem> custom({
    Expression<String>? id,
    Expression<String>? gearListId,
    Expression<String>? name,
    Expression<String>? category,
    Expression<bool>? isChecked,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gearListId != null) 'gear_list_id': gearListId,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (isChecked != null) 'is_checked': isChecked,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GearItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? gearListId,
    Value<String>? name,
    Value<String?>? category,
    Value<bool>? isChecked,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return GearItemsCompanion(
      id: id ?? this.id,
      gearListId: gearListId ?? this.gearListId,
      name: name ?? this.name,
      category: category ?? this.category,
      isChecked: isChecked ?? this.isChecked,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gearListId.present) {
      map['gear_list_id'] = Variable<String>(gearListId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isChecked.present) {
      map['is_checked'] = Variable<bool>(isChecked.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GearItemsCompanion(')
          ..write('id: $id, ')
          ..write('gearListId: $gearListId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('isChecked: $isChecked, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ActivitiesTable activities = $ActivitiesTable(this);
  late final $ActivityPhotosTable activityPhotos = $ActivityPhotosTable(this);
  late final $GearListsTable gearLists = $GearListsTable(this);
  late final $GearItemsTable gearItems = $GearItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    activities,
    activityPhotos,
    gearLists,
    gearItems,
  ];
}

typedef $$ActivitiesTableCreateCompanionBuilder =
    ActivitiesCompanion Function({
      Value<String> id,
      required String title,
      required DateTime date,
      Value<double?> distanceKm,
      Value<int?> elevationM,
      Value<int?> durationS,
      Value<String> status,
      Value<String?> notes,
      Value<String?> trackJson,
      Value<String?> routeId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ActivitiesTableUpdateCompanionBuilder =
    ActivitiesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<DateTime> date,
      Value<double?> distanceKm,
      Value<int?> elevationM,
      Value<int?> durationS,
      Value<String> status,
      Value<String?> notes,
      Value<String?> trackJson,
      Value<String?> routeId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ActivitiesTableReferences
    extends BaseReferences<_$AppDatabase, $ActivitiesTable, Activity> {
  $$ActivitiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ActivityPhotosTable, List<ActivityPhoto>>
  _activityPhotosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.activityPhotos,
    aliasName: $_aliasNameGenerator(
      db.activities.id,
      db.activityPhotos.activityId,
    ),
  );

  $$ActivityPhotosTableProcessedTableManager get activityPhotosRefs {
    final manager = $$ActivityPhotosTableTableManager(
      $_db,
      $_db.activityPhotos,
    ).filter((f) => f.activityId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_activityPhotosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ActivitiesTableFilterComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get elevationM => $composableBuilder(
    column: $table.elevationM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationS => $composableBuilder(
    column: $table.durationS,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get trackJson => $composableBuilder(
    column: $table.trackJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routeId => $composableBuilder(
    column: $table.routeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> activityPhotosRefs(
    Expression<bool> Function($$ActivityPhotosTableFilterComposer f) f,
  ) {
    final $$ActivityPhotosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activityPhotos,
      getReferencedColumn: (t) => t.activityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivityPhotosTableFilterComposer(
            $db: $db,
            $table: $db.activityPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ActivitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elevationM => $composableBuilder(
    column: $table.elevationM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationS => $composableBuilder(
    column: $table.durationS,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get trackJson => $composableBuilder(
    column: $table.trackJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routeId => $composableBuilder(
    column: $table.routeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActivitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => column,
  );

  GeneratedColumn<int> get elevationM => $composableBuilder(
    column: $table.elevationM,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationS =>
      $composableBuilder(column: $table.durationS, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get trackJson =>
      $composableBuilder(column: $table.trackJson, builder: (column) => column);

  GeneratedColumn<String> get routeId =>
      $composableBuilder(column: $table.routeId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> activityPhotosRefs<T extends Object>(
    Expression<T> Function($$ActivityPhotosTableAnnotationComposer a) f,
  ) {
    final $$ActivityPhotosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activityPhotos,
      getReferencedColumn: (t) => t.activityId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivityPhotosTableAnnotationComposer(
            $db: $db,
            $table: $db.activityPhotos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ActivitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivitiesTable,
          Activity,
          $$ActivitiesTableFilterComposer,
          $$ActivitiesTableOrderingComposer,
          $$ActivitiesTableAnnotationComposer,
          $$ActivitiesTableCreateCompanionBuilder,
          $$ActivitiesTableUpdateCompanionBuilder,
          (Activity, $$ActivitiesTableReferences),
          Activity,
          PrefetchHooks Function({bool activityPhotosRefs})
        > {
  $$ActivitiesTableTableManager(_$AppDatabase db, $ActivitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double?> distanceKm = const Value.absent(),
                Value<int?> elevationM = const Value.absent(),
                Value<int?> durationS = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> trackJson = const Value.absent(),
                Value<String?> routeId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivitiesCompanion(
                id: id,
                title: title,
                date: date,
                distanceKm: distanceKm,
                elevationM: elevationM,
                durationS: durationS,
                status: status,
                notes: notes,
                trackJson: trackJson,
                routeId: routeId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String title,
                required DateTime date,
                Value<double?> distanceKm = const Value.absent(),
                Value<int?> elevationM = const Value.absent(),
                Value<int?> durationS = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> trackJson = const Value.absent(),
                Value<String?> routeId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivitiesCompanion.insert(
                id: id,
                title: title,
                date: date,
                distanceKm: distanceKm,
                elevationM: elevationM,
                durationS: durationS,
                status: status,
                notes: notes,
                trackJson: trackJson,
                routeId: routeId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ActivitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({activityPhotosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (activityPhotosRefs) db.activityPhotos,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (activityPhotosRefs)
                    await $_getPrefetchedData<
                      Activity,
                      $ActivitiesTable,
                      ActivityPhoto
                    >(
                      currentTable: table,
                      referencedTable: $$ActivitiesTableReferences
                          ._activityPhotosRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ActivitiesTableReferences(
                            db,
                            table,
                            p0,
                          ).activityPhotosRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.activityId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ActivitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivitiesTable,
      Activity,
      $$ActivitiesTableFilterComposer,
      $$ActivitiesTableOrderingComposer,
      $$ActivitiesTableAnnotationComposer,
      $$ActivitiesTableCreateCompanionBuilder,
      $$ActivitiesTableUpdateCompanionBuilder,
      (Activity, $$ActivitiesTableReferences),
      Activity,
      PrefetchHooks Function({bool activityPhotosRefs})
    >;
typedef $$ActivityPhotosTableCreateCompanionBuilder =
    ActivityPhotosCompanion Function({
      Value<String> id,
      required String activityId,
      required String localPath,
      Value<double?> lat,
      Value<double?> lng,
      Value<DateTime?> takenAt,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$ActivityPhotosTableUpdateCompanionBuilder =
    ActivityPhotosCompanion Function({
      Value<String> id,
      Value<String> activityId,
      Value<String> localPath,
      Value<double?> lat,
      Value<double?> lng,
      Value<DateTime?> takenAt,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$ActivityPhotosTableReferences
    extends BaseReferences<_$AppDatabase, $ActivityPhotosTable, ActivityPhoto> {
  $$ActivityPhotosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ActivitiesTable _activityIdTable(_$AppDatabase db) =>
      db.activities.createAlias(
        $_aliasNameGenerator(db.activityPhotos.activityId, db.activities.id),
      );

  $$ActivitiesTableProcessedTableManager get activityId {
    final $_column = $_itemColumn<String>('activity_id')!;

    final manager = $$ActivitiesTableTableManager(
      $_db,
      $_db.activities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_activityIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ActivityPhotosTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityPhotosTable> {
  $$ActivityPhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ActivitiesTableFilterComposer get activityId {
    final $$ActivitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activityId,
      referencedTable: $db.activities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivitiesTableFilterComposer(
            $db: $db,
            $table: $db.activities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivityPhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityPhotosTable> {
  $$ActivityPhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ActivitiesTableOrderingComposer get activityId {
    final $$ActivitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activityId,
      referencedTable: $db.activities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivitiesTableOrderingComposer(
            $db: $db,
            $table: $db.activities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivityPhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityPhotosTable> {
  $$ActivityPhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lng =>
      $composableBuilder(column: $table.lng, builder: (column) => column);

  GeneratedColumn<DateTime> get takenAt =>
      $composableBuilder(column: $table.takenAt, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$ActivitiesTableAnnotationComposer get activityId {
    final $$ActivitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.activityId,
      referencedTable: $db.activities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.activities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivityPhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivityPhotosTable,
          ActivityPhoto,
          $$ActivityPhotosTableFilterComposer,
          $$ActivityPhotosTableOrderingComposer,
          $$ActivityPhotosTableAnnotationComposer,
          $$ActivityPhotosTableCreateCompanionBuilder,
          $$ActivityPhotosTableUpdateCompanionBuilder,
          (ActivityPhoto, $$ActivityPhotosTableReferences),
          ActivityPhoto,
          PrefetchHooks Function({bool activityId})
        > {
  $$ActivityPhotosTableTableManager(
    _$AppDatabase db,
    $ActivityPhotosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityPhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityPhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivityPhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> activityId = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<double?> lat = const Value.absent(),
                Value<double?> lng = const Value.absent(),
                Value<DateTime?> takenAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivityPhotosCompanion(
                id: id,
                activityId: activityId,
                localPath: localPath,
                lat: lat,
                lng: lng,
                takenAt: takenAt,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String activityId,
                required String localPath,
                Value<double?> lat = const Value.absent(),
                Value<double?> lng = const Value.absent(),
                Value<DateTime?> takenAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivityPhotosCompanion.insert(
                id: id,
                activityId: activityId,
                localPath: localPath,
                lat: lat,
                lng: lng,
                takenAt: takenAt,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ActivityPhotosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({activityId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (activityId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.activityId,
                                referencedTable: $$ActivityPhotosTableReferences
                                    ._activityIdTable(db),
                                referencedColumn:
                                    $$ActivityPhotosTableReferences
                                        ._activityIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ActivityPhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivityPhotosTable,
      ActivityPhoto,
      $$ActivityPhotosTableFilterComposer,
      $$ActivityPhotosTableOrderingComposer,
      $$ActivityPhotosTableAnnotationComposer,
      $$ActivityPhotosTableCreateCompanionBuilder,
      $$ActivityPhotosTableUpdateCompanionBuilder,
      (ActivityPhoto, $$ActivityPhotosTableReferences),
      ActivityPhoto,
      PrefetchHooks Function({bool activityId})
    >;
typedef $$GearListsTableCreateCompanionBuilder =
    GearListsCompanion Function({
      Value<String> id,
      required String name,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$GearListsTableUpdateCompanionBuilder =
    GearListsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$GearListsTableReferences
    extends BaseReferences<_$AppDatabase, $GearListsTable, GearList> {
  $$GearListsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$GearItemsTable, List<GearItem>>
  _gearItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.gearItems,
    aliasName: $_aliasNameGenerator(db.gearLists.id, db.gearItems.gearListId),
  );

  $$GearItemsTableProcessedTableManager get gearItemsRefs {
    final manager = $$GearItemsTableTableManager(
      $_db,
      $_db.gearItems,
    ).filter((f) => f.gearListId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_gearItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GearListsTableFilterComposer
    extends Composer<_$AppDatabase, $GearListsTable> {
  $$GearListsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> gearItemsRefs(
    Expression<bool> Function($$GearItemsTableFilterComposer f) f,
  ) {
    final $$GearItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gearItems,
      getReferencedColumn: (t) => t.gearListId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GearItemsTableFilterComposer(
            $db: $db,
            $table: $db.gearItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GearListsTableOrderingComposer
    extends Composer<_$AppDatabase, $GearListsTable> {
  $$GearListsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GearListsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GearListsTable> {
  $$GearListsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> gearItemsRefs<T extends Object>(
    Expression<T> Function($$GearItemsTableAnnotationComposer a) f,
  ) {
    final $$GearItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gearItems,
      getReferencedColumn: (t) => t.gearListId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GearItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.gearItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GearListsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GearListsTable,
          GearList,
          $$GearListsTableFilterComposer,
          $$GearListsTableOrderingComposer,
          $$GearListsTableAnnotationComposer,
          $$GearListsTableCreateCompanionBuilder,
          $$GearListsTableUpdateCompanionBuilder,
          (GearList, $$GearListsTableReferences),
          GearList,
          PrefetchHooks Function({bool gearItemsRefs})
        > {
  $$GearListsTableTableManager(_$AppDatabase db, $GearListsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GearListsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GearListsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GearListsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GearListsCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GearListsCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GearListsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({gearItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (gearItemsRefs) db.gearItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (gearItemsRefs)
                    await $_getPrefetchedData<
                      GearList,
                      $GearListsTable,
                      GearItem
                    >(
                      currentTable: table,
                      referencedTable: $$GearListsTableReferences
                          ._gearItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$GearListsTableReferences(
                            db,
                            table,
                            p0,
                          ).gearItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.gearListId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GearListsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GearListsTable,
      GearList,
      $$GearListsTableFilterComposer,
      $$GearListsTableOrderingComposer,
      $$GearListsTableAnnotationComposer,
      $$GearListsTableCreateCompanionBuilder,
      $$GearListsTableUpdateCompanionBuilder,
      (GearList, $$GearListsTableReferences),
      GearList,
      PrefetchHooks Function({bool gearItemsRefs})
    >;
typedef $$GearItemsTableCreateCompanionBuilder =
    GearItemsCompanion Function({
      Value<String> id,
      required String gearListId,
      required String name,
      Value<String?> category,
      Value<bool> isChecked,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$GearItemsTableUpdateCompanionBuilder =
    GearItemsCompanion Function({
      Value<String> id,
      Value<String> gearListId,
      Value<String> name,
      Value<String?> category,
      Value<bool> isChecked,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$GearItemsTableReferences
    extends BaseReferences<_$AppDatabase, $GearItemsTable, GearItem> {
  $$GearItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GearListsTable _gearListIdTable(_$AppDatabase db) =>
      db.gearLists.createAlias(
        $_aliasNameGenerator(db.gearItems.gearListId, db.gearLists.id),
      );

  $$GearListsTableProcessedTableManager get gearListId {
    final $_column = $_itemColumn<String>('gear_list_id')!;

    final manager = $$GearListsTableTableManager(
      $_db,
      $_db.gearLists,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gearListIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GearItemsTableFilterComposer
    extends Composer<_$AppDatabase, $GearItemsTable> {
  $$GearItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isChecked => $composableBuilder(
    column: $table.isChecked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$GearListsTableFilterComposer get gearListId {
    final $$GearListsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gearListId,
      referencedTable: $db.gearLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GearListsTableFilterComposer(
            $db: $db,
            $table: $db.gearLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GearItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $GearItemsTable> {
  $$GearItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isChecked => $composableBuilder(
    column: $table.isChecked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$GearListsTableOrderingComposer get gearListId {
    final $$GearListsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gearListId,
      referencedTable: $db.gearLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GearListsTableOrderingComposer(
            $db: $db,
            $table: $db.gearLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GearItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GearItemsTable> {
  $$GearItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isChecked =>
      $composableBuilder(column: $table.isChecked, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$GearListsTableAnnotationComposer get gearListId {
    final $$GearListsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gearListId,
      referencedTable: $db.gearLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GearListsTableAnnotationComposer(
            $db: $db,
            $table: $db.gearLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GearItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GearItemsTable,
          GearItem,
          $$GearItemsTableFilterComposer,
          $$GearItemsTableOrderingComposer,
          $$GearItemsTableAnnotationComposer,
          $$GearItemsTableCreateCompanionBuilder,
          $$GearItemsTableUpdateCompanionBuilder,
          (GearItem, $$GearItemsTableReferences),
          GearItem,
          PrefetchHooks Function({bool gearListId})
        > {
  $$GearItemsTableTableManager(_$AppDatabase db, $GearItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GearItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GearItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GearItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gearListId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<bool> isChecked = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GearItemsCompanion(
                id: id,
                gearListId: gearListId,
                name: name,
                category: category,
                isChecked: isChecked,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String gearListId,
                required String name,
                Value<String?> category = const Value.absent(),
                Value<bool> isChecked = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GearItemsCompanion.insert(
                id: id,
                gearListId: gearListId,
                name: name,
                category: category,
                isChecked: isChecked,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GearItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({gearListId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (gearListId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.gearListId,
                                referencedTable: $$GearItemsTableReferences
                                    ._gearListIdTable(db),
                                referencedColumn: $$GearItemsTableReferences
                                    ._gearListIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GearItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GearItemsTable,
      GearItem,
      $$GearItemsTableFilterComposer,
      $$GearItemsTableOrderingComposer,
      $$GearItemsTableAnnotationComposer,
      $$GearItemsTableCreateCompanionBuilder,
      $$GearItemsTableUpdateCompanionBuilder,
      (GearItem, $$GearItemsTableReferences),
      GearItem,
      PrefetchHooks Function({bool gearListId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ActivitiesTableTableManager get activities =>
      $$ActivitiesTableTableManager(_db, _db.activities);
  $$ActivityPhotosTableTableManager get activityPhotos =>
      $$ActivityPhotosTableTableManager(_db, _db.activityPhotos);
  $$GearListsTableTableManager get gearLists =>
      $$GearListsTableTableManager(_db, _db.gearLists);
  $$GearItemsTableTableManager get gearItems =>
      $$GearItemsTableTableManager(_db, _db.gearItems);
}
