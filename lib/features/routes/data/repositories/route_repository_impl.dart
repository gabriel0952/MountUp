import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/route_entity.dart';
import '../../domain/repositories/route_repository.dart';
import '../datasources/route_local_datasource.dart';
import '../datasources/route_remote_datasource.dart';

class RouteRepositoryImpl implements RouteRepository {
  RouteRepositoryImpl({
    required RouteRemoteDatasource remote,
    required RouteLocalDatasource local,
  })  : _remote = remote,
        _local = local;

  final RouteRemoteDatasource _remote;
  final RouteLocalDatasource _local;

  @override
  Future<Either<Failure, List<RouteEntity>>> fetchAll() async {
    try {
      final models = await _remote.fetchAllOfficial();
      await _local.upsertAll(models);
      return Right(models.map((m) => m.toEntity()).toList());
    } on SocketException {
      // 無網路，嘗試回傳快取
      final cached = await _local.getAll();
      if (cached.isEmpty) {
        return Left(const Failure.network('無網路連線且無本地快取，請先連線載入路線資料'));
      }
      return Right(cached);
    } on PostgrestException catch (e) {
      final cached = await _local.getAll();
      if (cached.isNotEmpty) return Right(cached);
      return Left(Failure.unknown(e.message));
    } catch (e) {
      final cached = await _local.getAll();
      if (cached.isNotEmpty) return Right(cached);
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RouteEntity>> getById(String id) async {
    final cached = await _local.getById(id);
    if (cached != null) return Right(cached);

    try {
      final model = await _remote.fetchById(id);
      if (model == null) return Left(Failure.notFound('找不到路線 $id'));
      await _local.upsertAll([model]);
      return Right(model.toEntity());
    } on SocketException {
      return Left(const Failure.network('無網路連線'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getGpx(String routeId) async {
    // 先嘗試本地快取
    final entity = await _local.getById(routeId);
    final localPath = entity?.gpxLocalPath;
    if (localPath != null) {
      final file = File(localPath);
      if (await file.exists()) {
        return Right(await file.readAsString());
      }
    }

    // 本地無快取，從 Supabase Storage 下載
    if (entity?.gpxUrl == null) {
      return Left(Failure.notFound('路線 $routeId 無 GPX 資料'));
    }

    try {
      final content = await _remote.downloadGpx(entity!.gpxUrl!);

      // 存至本地
      final dir = await getApplicationDocumentsDirectory();
      final routesDir = Directory('${dir.path}/routes');
      if (!await routesDir.exists()) await routesDir.create(recursive: true);
      final file = File('${routesDir.path}/$routeId.gpx');
      await file.writeAsString(content);
      await _local.updateGpxLocalPath(routeId, file.path);

      return Right(content);
    } on SocketException {
      return Left(const Failure.network('無網路連線，無法下載 GPX'));
    } catch (e) {
      return Left(Failure.unknown(e.toString()));
    }
  }
}
