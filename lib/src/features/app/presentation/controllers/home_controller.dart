
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_jira_task/src/core/usecases/usecase.dart';
import 'package:track_jira_task/src/features/data/DTOs/issues_query_dto.dart';
import 'package:track_jira_task/src/features/data/DTOs/project_dto.dart';
import 'package:track_jira_task/src/features/domain/entities/issues_entity.dart';
import 'package:track_jira_task/src/features/domain/entities/projects_entity.dart';
import 'package:track_jira_task/src/features/domain/entities/user_entity.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_issues_by_project_usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_issues_by_query_usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_projects_usecase.dart';


class HomeController extends GetxController {
  final GetProjectUseCase _getProjectUseCase;
  final GetIssuesByProjectUseCase _getIssuesByProjectUseCase;
  final GetIssuesByQueryUseCase _getIssuesByQueryUseCase;


  TextEditingController projectsCtrl = TextEditingController();
  final searchCtrl = TextEditingController();
  String? id;
  String? projectId;

  RxList<ProjectsEntity> projects = <ProjectsEntity>[].obs;
  RxList<IssuesEntity> issues = <IssuesEntity>[].obs;

  IssuesEntity? issuesEntity;
  UserEntity? userEntity;

  RxBool isProjectsLoading = false.obs;
  RxBool projectSelected = false.obs;
  RxString user = ''.obs;

  HomeController({
    required GetProjectUseCase getProjectUseCase,
    required GetIssuesByProjectUseCase getIssuesUseCase,
    required GetIssuesByQueryUseCase getIssuesByQueryUseCase,
  }) : _getProjectUseCase = getProjectUseCase,
  _getIssuesByProjectUseCase = getIssuesUseCase,
  _getIssuesByQueryUseCase = getIssuesByQueryUseCase;

  @override
  void onReady() {
    loadProjects();
    // update(['home']);
  }

  set setProjectSelected(ProjectsEntity value) {
      projectsCtrl.text = value.name!;
      loadIssuesByProject(value.id!);
      // log('${value.id}', name: 'ID del project');
      projectSelected.value = true;
      projectId = value.id!;
    update();
  }



  Future<void> loadProjects()async{
    isProjectsLoading.value = true;
    final res = await _getProjectUseCase.call(NoParams());

    res.fold((l) {
      log('$l', name: 'Error Projects');
      isProjectsLoading.value = false;
    }, (r) {
      projects.addAll(r);
      isProjectsLoading.value = false;
      update();
    });
  }

  Future<void> loadIssuesByProject(String projectId) async{
    projectSelected.value = true;
    // print(projectId);
    ProjectDTO params = ProjectDTO(id: projectId);
    final res = await _getIssuesByProjectUseCase.call(params);
    res.fold((l) {
      log('$l', name: 'Error Issues');
    }, (r) {
      issues.clear();
      issues.addAll(r);
      update();
    });
  }

  Future<void> loadIssuesByQuery(String queryTxt, String projectId) async{

    if(queryTxt==''){
      ProjectDTO params = ProjectDTO(id: projectId);
      final res = await _getIssuesByProjectUseCase.call(params);
      res.fold((l) {
        log('$l', name: 'Error Issues Query');
      }, (r) {
        issues.clear();
        issues.addAll(r);
        update();
      });
    }else{
      IssuesQueryDTO params = IssuesQueryDTO(query: queryTxt, idProject: projectId);
      final res = await _getIssuesByQueryUseCase.call(params);
      res.fold((l) {
        log('$l', name: 'Error Issues Query');
      }, (r) {
        issues.clear();
        issues.addAll(r);
        update();
      });
    }
  }


}