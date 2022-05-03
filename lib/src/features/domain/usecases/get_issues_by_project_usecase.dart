import 'package:dartz/dartz.dart';
import 'package:track_jira_task/src/core/error/failures.dart';
import 'package:track_jira_task/src/core/usecases/usecase.dart';
import 'package:track_jira_task/src/features/data/DTOs/project_dto.dart';
import 'package:track_jira_task/src/features/domain/entities/issues_entity.dart';
import 'package:track_jira_task/src/features/domain/repositories/projects_repository.dart';

class GetIssuesByProjectUseCase implements UseCase<List<IssuesEntity>, ProjectDTO> {
  final ProjectsRepository repository;

  GetIssuesByProjectUseCase(this.repository);

  @override
  Future<Either<Failure, List<IssuesEntity>>> call(ProjectDTO params) async {
    return await repository.getIssuesByProject(params);
  }

}