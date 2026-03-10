import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/repositories/activity_repository.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  ActivityRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Future<List<Activity>> getAll() =>
      (_db.select(_db.activities)
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .get();

  @override
  Future<void> save(ActivitiesCompanion entry) =>
      _db.into(_db.activities).insertOnConflictUpdate(entry);

  @override
  Future<void> delete(String id) =>
      (_db.delete(_db.activities)..where((t) => t.id.equals(id))).go();
}
