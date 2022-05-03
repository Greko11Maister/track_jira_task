import 'package:dartz/dartz.dart';
import 'package:track_jira_task/src/core/error/failures.dart';
import 'package:track_jira_task/src/core/usecases/usecase.dart';
import 'package:track_jira_task/src/features/domain/entities/issues_entity.dart';
import 'package:track_jira_task/src/features/data/DTOs/issues_query_dto.dart';
import 'package:track_jira_task/src/features/domain/repositories/projects_repository.dart';

class GetIssuesByQueryUseCase implements UseCase<List<IssuesEntity>, IssuesQueryDTO> {
  final ProjectsRepository repository;

  GetIssuesByQueryUseCase(this.repository);

  @override
  Future<Either<Failure, List<IssuesEntity>>> call(IssuesQueryDTO params) async{
    return await repository.getIssuesByQuery(params);
  }

}