import 'package:dartz/dartz.dart';
import 'package:track_jira_task/src/core/error/failures.dart';
import 'package:track_jira_task/src/core/usecases/usecase.dart';
import 'package:track_jira_task/src/features/domain/entities/user_entity.dart';
import 'package:track_jira_task/src/features/domain/repositories/projects_repository.dart';

class GetUserUseCase implements UseCase<UserEntity, NoParams> {
  final ProjectsRepository repository;

  GetUserUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async{
    return await repository.getUser();
  }


}