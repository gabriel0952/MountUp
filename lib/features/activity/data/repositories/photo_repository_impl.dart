import 'dart:io';

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/repositories/photo_repository.dart';

class PhotoRepositoryImpl implements PhotoRepository {
  PhotoRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<List<ActivityPhoto>> getByActivityId(String activityId) =>
      (_db.select(_db.activityPhotos)
            ..where((t) => t.activityId.equals(activityId))
            ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
          .get();

  @override
  Future<void> save(ActivityPhotosCompanion entry) =>
      _db.into(_db.activityPhotos).insertOnConflictUpdate(entry);

  @override
  Future<void> delete(String id) async {
    final photo = await (_db.select(_db.activityPhotos)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (photo == null) return;

    // 先刪檔案，再刪 DB（確保 DB 記錄在檔案刪除失敗時仍保留）
    final file = File(photo.localPath);
    if (await file.exists()) {
      await file.delete();
    }
    await (_db.delete(_db.activityPhotos)..where((t) => t.id.equals(id))).go();
  }
}
