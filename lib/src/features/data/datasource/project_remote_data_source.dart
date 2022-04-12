import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:track_jira_task/src/core/error/failures.dart';
import 'package:track_jira_task/src/core/http/api.dart';
import 'package:track_jira_task/src/features/data/models/projects_model.dart';

abstract class ProjectRemoteDataSource{
  Future<List<ProjectsModel>> getProjects();

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
}