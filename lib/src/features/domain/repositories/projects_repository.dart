
import 'package:dartz/dartz.dart';
import 'package:track_jira_task/src/core/error/failures.dart';
import 'package:track_jira_task/src/features/data/DTOs/issues_query_dto.dart';
import 'package:track_jira_task/src/features/data/DTOs/project_dto.dart';
import 'package:track_jira_task/src/features/domain/entities/issues_entity.dart';
import 'package:track_jira_task/src/features/domain/entities/projects_entity.dart';
import 'package:track_jira_task/src/features/domain/entities/user_entity.dart';


abstract class ProjectsRepository{

  Future<Either<Failure, List<ProjectsEntity>>> getProjects();

  Future<Either<Failure, List<IssuesEntity>>> getIssuesByProject(ProjectDTO params);

  Future<Either<Failure, List<IssuesEntity>>> getIssuesByQuery(IssuesQueryDTO params);

  Future<Either<Failure, UserEntity>> getUser();

}