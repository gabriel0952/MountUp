import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../data/repositories/photo_repository_impl.dart';
import '../../domain/repositories/photo_repository.dart';

part 'photo_provider.g.dart';

@Riverpod(keepAlive: true)
PhotoRepository photoRepository(Ref ref) =>
    PhotoRepositoryImpl(ref.watch(appDatabaseProvider));

final activityPhotosProvider =
    FutureProvider.autoDispose.family<List<ActivityPhoto>, String>(
  (ref, activityId) =>
      ref.watch(photoRepositoryProvider).getByActivityId(activityId),
);
