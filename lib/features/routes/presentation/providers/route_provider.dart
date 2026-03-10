import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/database/database_provider.dart';
import '../../data/datasources/route_local_datasource.dart';
import '../../data/datasources/route_remote_datasource.dart';
import '../../data/repositories/route_repository_impl.dart';
import '../../domain/entities/route_entity.dart';
import '../../domain/repositories/route_repository.dart';

part 'route_provider.g.dart';

// ── Repository providers ──────────────────────────────────────

@Riverpod(keepAlive: true)
RouteRepository routeRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return RouteRepositoryImpl(
    remote: RouteRemoteDatasource(Supabase.instance.client),
    local: RouteLocalDatasource(db),
  );
}

// ── Data providers ────────────────────────────────────────────

@riverpod
Future<List<RouteEntity>> routeList(Ref ref) async {
  final repo = ref.watch(routeRepositoryProvider);
  final result = await repo.fetchAll();
  return result.fold(
    (failure) => throw failure,
    (routes) => routes,
  );
}

@riverpod
Future<RouteEntity> routeById(Ref ref, String id) async {
  final repo = ref.watch(routeRepositoryProvider);
  final result = await repo.getById(id);
  return result.fold(
    (failure) => throw failure,
    (route) => route,
  );
}

@riverpod
Future<String?> routeGpx(Ref ref, String routeId) async {
  final repo = ref.watch(routeRepositoryProvider);
  final result = await repo.getGpx(routeId);
  return result.fold((_) => null, (gpx) => gpx);
}

// ── Filter state ──────────────────────────────────────────────

class RouteFilterState {
  const RouteFilterState({this.difficulty, this.region});
  final String? difficulty;
  final String? region;

  RouteFilterState copyWith({String? difficulty, String? region}) =>
      RouteFilterState(
        difficulty: difficulty,
        region: region,
      );
}

@riverpod
class RouteFilter extends _$RouteFilter {
  @override
  RouteFilterState build() => const RouteFilterState();

  void setDifficulty(String? difficulty) =>
      state = state.copyWith(difficulty: difficulty);

  void setRegion(String? region) =>
      state = state.copyWith(region: region);
}
