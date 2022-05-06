import 'package:dartz/dartz.dart';
import 'package:track_jira_task/src/core/error/failures.dart';
import 'package:track_jira_task/src/core/usecases/usecase.dart';
import 'package:track_jira_task/src/features/domain/repositories/auth_repository.dart';

class GetUsernameUseCase implements UseCase<String?, NoParams>{
  final AuthRepository repository;

  GetUsernameUseCase(this.repository);

  @override
  Future<Either<Failure, String?>> call(NoParams params) async{
  return await repository.getUsername();
  }

}