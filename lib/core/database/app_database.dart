import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// ── Tables ───────────────────────────────────────────────────

class Activities extends Table {
  TextColumn get id          => text().clientDefault(() => _uuid())();
  TextColumn get title       => text()();
  DateTimeColumn get date    => dateTime()();
  RealColumn get distanceKm  => real().nullable()();
  IntColumn get elevationM   => integer().nullable()();
  IntColumn get durationS    => integer().nullable()();
  TextColumn get status      => text().withDefault(const Constant('completed'))();
  TextColumn get notes       => text().nullable()();
  TextColumn get trackJson   => text().nullable()();
  TextColumn get routeId     => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class ActivityPhotos extends Table {
  TextColumn get id         => text().clientDefault(() => _uuid())();
  TextColumn get activityId => text().references(Activities, #id)();
  TextColumn get localPath  => text()();
  RealColumn get lat        => real().nullable()();
  RealColumn get lng        => real().nullable()();
  DateTimeColumn get takenAt => dateTime().nullable()();
  IntColumn get sortOrder   => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class GearLists extends Table {
  TextColumn get id         => text().clientDefault(() => _uuid())();
  TextColumn get name       => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class GearItems extends Table {
  TextColumn get id         => text().clientDefault(() => _uuid())();
  TextColumn get gearListId => text().references(GearLists, #id)();
  TextColumn get name       => text()();
  TextColumn get category   => text().nullable()();
  BoolColumn get isChecked  => boolean().withDefault(const Constant(false))();
  IntColumn get sortOrder   => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Routes extends Table {
  TextColumn get id           => text().clientDefault(() => _uuid())();
  TextColumn get name         => text()();
  TextColumn get region       => text().nullable()();
  TextColumn get difficulty   => text().nullable()();
  RealColumn get distanceKm   => real().nullable()();
  IntColumn get elevationM    => integer().nullable()();
  TextColumn get description  => text().nullable()();
  TextColumn get gpxUrl       => text().nullable()();
  TextColumn get coverUrl     => text().nullable()();
  BoolColumn get isOfficial   => boolean().withDefault(const Constant(true))();
  TextColumn get gpxLocalPath => text().nullable()();
  DateTimeColumn get cachedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// ── Database ─────────────────────────────────────────────────

@DriftDatabase(tables: [Activities, ActivityPhotos, GearLists, GearItems, Routes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.createTable(routes);
      }
    },
  );

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'mountup');
  }
}

String _uuid() {
  // Simple UUID v4 without extra packages
  final now = DateTime.now().microsecondsSinceEpoch;
  return '${now.toRadixString(16).padLeft(12, '0')}-${_rand(4)}-4${_rand(3)}-${_rand(4)}-${_rand(12)}';
}

String _rand(int len) {
  const chars = '0123456789abcdef';
  final buf = StringBuffer();
  for (var i = 0; i < len; i++) {
    buf.write(chars[(DateTime.now().microsecondsSinceEpoch + i * 13) % 16]);
  }
  return buf.toString();
}
