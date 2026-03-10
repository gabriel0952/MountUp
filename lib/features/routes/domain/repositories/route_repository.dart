import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/route_entity.dart';

abstract class RouteRepository {
  /// 從 Supabase 拉取所有官方路線，快取至本地 Drift。
  /// 離線時回傳本地快取；無快取且無網路則回傳 Left(NetworkFailure)。
  Future<Either<Failure, List<RouteEntity>>> fetchAll();

  /// 優先從 Drift 快取讀取單一路線；無快取則從 Supabase 查詢。
  Future<Either<Failure, RouteEntity>> getById(String id);

  /// 取得路線 GPX 內容字串。
  /// 本地已快取則直接讀取；否則從 Supabase Storage 下載並快取。
  Future<Either<Failure, String>> getGpx(String routeId);
}
