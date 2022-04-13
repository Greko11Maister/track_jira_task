
import 'package:dartz/dartz.dart';
import 'package:track_jira_task/src/core/error/failures.dart';
import 'package:track_jira_task/src/features/data/DTOs/project_dto.dart';
import 'package:track_jira_task/src/features/domain/entities/issues_entity.dart';
import 'package:track_jira_task/src/features/domain/entities/projects_entity.dart';


abstract class ProjectsRepository{

  Future<Either<Failure, List<ProjectsEntity>>> getProjects();

  Future<Either<Failure, List<IssuesEntity>>> getIssues(ProjectDTO params);

}