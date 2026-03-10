import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../data/repositories/activity_repository_impl.dart';
import '../../domain/repositories/activity_repository.dart';

part 'activity_provider.g.dart';

@Riverpod(keepAlive: true)
ActivityRepository activityRepository(Ref ref) =>
    ActivityRepositoryImpl(ref.watch(appDatabaseProvider));

// 手動定義，因為 riverpod_generator 4.x 無法解析 Drift part file 中的 Activity 型別
final activityListProvider = FutureProvider.autoDispose<List<Activity>>((ref) {
  return ref.watch(activityRepositoryProvider).getAll();
});
