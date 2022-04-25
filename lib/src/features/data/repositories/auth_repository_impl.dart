import 'package:dartz/dartz.dart';
import 'package:track_jira_task/src/core/error/failures.dart';
import 'package:track_jira_task/src/features/data/datasource/auth_local_data_source.dart';
import 'package:track_jira_task/src/features/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, String?>> getToken() async{
   try {
     String? res = await localDataSource.getToken();
     return Right(res);
   }on CacheFailure catch (e){
     return Left(e);
   }
  }

  @override
  Future<Either<Failure, bool>> setToken(String token) async{
    try {
      await localDataSource.setToken(token);
      return const Right(true);
    }on CacheFailure catch (e){
      return Left(e);
    }
  }
}