
import 'package:dartz/dartz.dart';
import 'package:track_jira_task/src/core/error/failures.dart';
import 'package:track_jira_task/src/features/data/DTOs/issues_query_dto.dart';
import 'package:track_jira_task/src/features/data/DTOs/project_dto.dart';
import 'package:track_jira_task/src/features/data/datasource/project_remote_data_source.dart';
import 'package:track_jira_task/src/features/domain/entities/issues_entity.dart';
import 'package:track_jira_task/src/features/domain/entities/projects_entity.dart';
import 'package:track_jira_task/src/features/domain/entities/user_entity.dart';
import 'package:track_jira_task/src/features/domain/repositories/projects_repository.dart';

class ProjectsRepositoryImpl implements ProjectsRepository{
  final ProjectRemoteDataSource remoteDataSource;

  ProjectsRepositoryImpl({required this.remoteDataSource});


  @override
  Future<Either<Failure, List<ProjectsEntity>>> getProjects() async {
    try {
      final res = await remoteDataSource.getProjects();
      return Right(res);
    }on ServerFailure catch (e){
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<IssuesEntity>>> getIssuesByProject(ProjectDTO params) async {
    try {
      final res = await remoteDataSource.getIssuesByProject(params);
      return Right(res);
    }on ServerFailure catch (e){
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser() async{
    try {
      final res = await remoteDataSource.getUser();
      return Right(res);
    }on ServerFailure catch (e){
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<IssuesEntity>>> getIssuesByQuery(IssuesQueryDTO params) async{
    try {
      final res = await remoteDataSource.getIssuesByQuery(params);
      return Right(res);
    }on ServerFailure catch (e){
      return Left(e);
    }
  }


  
}