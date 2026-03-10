import '../../../../core/database/app_database.dart';

abstract class ActivityRepository {
  Future<List<Activity>> getAll();
  Future<void> save(ActivitiesCompanion entry);
  Future<void> delete(String id);
}
