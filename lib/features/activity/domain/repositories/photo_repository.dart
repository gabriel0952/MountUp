import '../../../../core/database/app_database.dart';

abstract class PhotoRepository {
  Future<List<ActivityPhoto>> getByActivityId(String activityId);
  Future<void> save(ActivityPhotosCompanion entry);
  Future<void> delete(String id);
}
