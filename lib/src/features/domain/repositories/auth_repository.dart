import 'package:dartz/dartz.dart';
import 'package:track_jira_task/src/core/error/failures.dart';

abstract class AuthRepository{
  Future<Either<Failure, String?>> getToken();
  Future<Either<Failure, bool>> setToken(String token);
}