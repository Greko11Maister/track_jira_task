import 'package:dartz/dartz.dart';
import 'package:track_jira_task/src/core/error/failures.dart';
import 'package:track_jira_task/src/core/usecases/usecase.dart';
import 'package:track_jira_task/src/features/domain/entities/projects_entity.dart';
import 'package:track_jira_task/src/features/domain/repositories/projects_repository.dart';

class GetProjectUseCase implements UseCase<List<ProjectsEntity>, NoParams> {
  final ProjectsRepository repository;

  GetProjectUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProjectsEntity>>> call(NoParams params) async{
    return await repository.getProjects();
  }

}
