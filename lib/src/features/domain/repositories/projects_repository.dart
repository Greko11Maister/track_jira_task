
import 'package:dartz/dartz.dart';
import 'package:track_jira_task/src/core/error/failures.dart';
import 'package:track_jira_task/src/features/domain/entities/projects_entity.dart';


abstract class ProjectsRepository{

  Future<Either<Failure, List<ProjectsEntity>>> getProjects();

}