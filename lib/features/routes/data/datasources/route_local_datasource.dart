import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/route_entity.dart';
import '../models/route_model.dart';

class RouteLocalDatasource {
  RouteLocalDatasource(this._db);

  final AppDatabase _db;

  Future<List<RouteEntity>> getAll() async {
    final rows = await _db.select(_db.routes).get();
    return rows.map(_rowToEntity).toList();
  }

  Future<RouteEntity?> getById(String id) async {
    final row = await (_db.select(_db.routes)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _rowToEntity(row);
  }

  Future<void> upsertAll(List<RouteModel> models) async {
    final now = DateTime.now();
    await _db.batch((batch) {
      for (final m in models) {
        batch.insert(
          _db.routes,
          RoutesCompanion.insert(
            id: Value(m.id),
            name: m.name,
            region: Value(m.region),
            difficulty: Value(m.difficulty),
            distanceKm: Value(m.distanceKm),
            elevationM: Value(m.elevationM),
            description: Value(m.description),
            gpxUrl: Value(m.gpxUrl),
            coverUrl: Value(m.coverUrl),
            isOfficial: Value(m.isOfficial),
            cachedAt: Value(now),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<void> updateGpxLocalPath(String id, String localPath) async {
    await (_db.update(_db.routes)..where((t) => t.id.equals(id))).write(
      RoutesCompanion(gpxLocalPath: Value(localPath)),
    );
  }

  Future<DateTime?> getCachedAt(String id) async {
    final row = await (_db.select(_db.routes)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row?.cachedAt;
  }

  RouteEntity _rowToEntity(Route row) => RouteEntity(
        id: row.id,
        name: row.name,
        region: row.region,
        difficulty: row.difficulty,
        distanceKm: row.distanceKm,
        elevationM: row.elevationM,
        description: row.description,
        gpxUrl: row.gpxUrl,
        coverUrl: row.coverUrl,
        isOfficial: row.isOfficial,
        gpxLocalPath: row.gpxLocalPath,
      );
}
