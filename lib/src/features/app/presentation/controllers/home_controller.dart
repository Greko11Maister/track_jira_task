
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_jira_task/src/core/usecases/usecase.dart';
import 'package:track_jira_task/src/features/data/DTOs/project_dto.dart';
import 'package:track_jira_task/src/features/domain/entities/issues_entity.dart';
import 'package:track_jira_task/src/features/domain/entities/projects_entity.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_issues_usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_projects_usecase.dart';

class HomeController extends GetxController {
  final GetProjectUseCase _getProjectUseCase;
  final GetIssuesUseCase _getIssuesUseCase;

  TextEditingController projectsCtrl = TextEditingController();
  String? id;
  String? projectId;

  RxList<ProjectsEntity> projects = <ProjectsEntity>[].obs;
  RxList<IssuesEntity> issues = <IssuesEntity>[].obs;

  IssuesEntity? issuesEntity;

  RxBool isProjectsLoading = false.obs;


  HomeController({
    required GetProjectUseCase getProjectUseCase,
    required GetIssuesUseCase getIssuesUseCase,
  }) : _getProjectUseCase = getProjectUseCase,
  _getIssuesUseCase= getIssuesUseCase;

  @override
  void onReady() {
     loadProjects();
    super.onReady();
  }

  set setProjectSelected(ProjectsEntity value) {
      projectsCtrl.text = value.name!;
       // id = value.id;
      loadIssues(value.id!);
      // log('${value.id}', name: 'ID del project');
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

  Future<void> loadIssues(String projectId) async{
    print(projectId);
    ProjectDTO params = ProjectDTO(id: projectId);
    final res = await _getIssuesUseCase.call(params);
    res.fold((l) {
      log('$l', name: 'Error Issues');
    }, (r) {
      issues.clear();
      issues.addAll(r);
      update();
    });
  }

  void getIssueData(){
    var item = issues.firstWhere((e) => Get.arguments==e.id);
    issuesEntity = item;
  }

}