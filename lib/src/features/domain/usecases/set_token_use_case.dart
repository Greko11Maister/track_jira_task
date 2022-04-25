import 'package:dartz/dartz.dart';
import 'package:track_jira_task/src/core/error/failures.dart';
import 'package:track_jira_task/src/core/usecases/usecase.dart';
import 'package:track_jira_task/src/features/domain/repositories/auth_repository.dart';

class SetTokenUseCase implements UseCase<bool, String>{
  final AuthRepository repository;

  SetTokenUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(String token) async{
    return await repository.setToken(token);
  }


}