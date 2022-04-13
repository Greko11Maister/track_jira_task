import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:track_jira_task/src/core/error/failures.dart';
import 'package:track_jira_task/src/core/http/api.dart';
import 'package:track_jira_task/src/features/data/DTOs/project_dto.dart';
import 'package:track_jira_task/src/features/data/models/issues_model.dart';
import 'package:track_jira_task/src/features/data/models/projects_model.dart';

abstract class ProjectRemoteDataSource{
  Future<List<ProjectsModel>> getProjects();
  Future<List<IssuesModel>> getIssues(ProjectDTO params);
}

class ProjectRemoteDataSourceImpl extends ApiProvider implements ProjectRemoteDataSource{
  @override
  Future<List<ProjectsModel>> getProjects() async{
    try{
      final res = await dio!.get('/rest/api/3/project');
       return (res.data as List)
          .map((e) => ProjectsModel.fromJson(e))
          .toList();
    } on DioError catch (error){
      throw ServerFailure(error: error).extract;
    }
  }

  @override
  Future<List<IssuesModel>> getIssues(ProjectDTO params) async{
    try{
      final res = await dio!.get('/rest/api/3/issue/picker', queryParameters: params.queryParameters);
      log('$res', name: 'Issues');
      return (res.data["sections"] ["issues"] as List)
          .map((e) => IssuesModel.fromJson(e))
          .toList();
    }on DioError catch (error) {
      throw ServerFailure(error: error).extract;
    }
  }


}