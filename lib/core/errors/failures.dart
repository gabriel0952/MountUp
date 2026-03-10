import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
abstract class Failure with _$Failure {
  const factory Failure.database(String message) = DatabaseFailure;
  const factory Failure.notFound(String message) = NotFoundFailure;
  const factory Failure.permission(String message) = PermissionFailure;
  const factory Failure.network(String message) = NetworkFailure;
  const factory Failure.unknown(String message) = UnknownFailure;
}
