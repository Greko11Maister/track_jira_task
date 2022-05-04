
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
import 'package:track_jira_task/src/features/domain/usecases/get_user_usecase.dart';


class HomeController extends GetxController {
  final GetProjectUseCase _getProjectUseCase;
  final GetIssuesByProjectUseCase _getIssuesByProjectUseCase;
  final GetIssuesByQueryUseCase _getIssuesByQueryUseCase;
  final GetUserUseCase _getUserUseCase;

  TextEditingController projectsCtrl = TextEditingController();
  final searchCtrl = TextEditingController();
  // TextEditingController userCtrl = TextEditingController();
  String? id;
  String? projectId;

  RxList<ProjectsEntity> projects = <ProjectsEntity>[].obs;
  RxList<IssuesEntity> issues = <IssuesEntity>[].obs;
  // RxList<UserEntity> user= <UserEntity>[].obs;

  IssuesEntity? issuesEntity;
  UserEntity? userEntity;
  IssuesQueryDTO? issuesQueryDTO;

  RxBool isProjectsLoading = false.obs;
  RxBool isUsersLoading = false.obs;
  RxString user = ''.obs;

  HomeController({
    required GetProjectUseCase getProjectUseCase,
    required GetIssuesByProjectUseCase getIssuesUseCase,
    required GetUserUseCase getUserUseCase,
    required GetIssuesByQueryUseCase getIssuesByQueryUseCase,
  }) : _getProjectUseCase = getProjectUseCase,
  _getIssuesByProjectUseCase = getIssuesUseCase,
  _getUserUseCase = getUserUseCase,
  _getIssuesByQueryUseCase = getIssuesByQueryUseCase;

  @override
  void onInit() {
    // loadUser();
    // loadIssuesByQuery();
    super.onInit();
  }

  @override
  void onReady() {
     // loadUser();
    loadProjects();
    update();
  }

  // set setUserSelected(UserEntity value){
  //   userCtrl.text = value.name!;
  //   log('usuario seleccionado: ${value.name}, id: ${value.id}',name: 'Usuario del controlador');
  //   // loadIssuesByProject(value.id!);
  //   update();
  // }

  set setProjectSelected(ProjectsEntity value) {
      projectsCtrl.text = value.name!;
       // id = value.id;
      loadIssuesByProject(value.id!);
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

  Future<void> loadIssuesByProject(String projectId) async{
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

  Future<void> loadIssuesByQuery(String queryTxt) async{
    IssuesQueryDTO params = IssuesQueryDTO(query: queryTxt);
    final res = await _getIssuesByQueryUseCase.call(params);
    // log('${params.query}', name: "query cntrl");
    // log(queryTxt, name: 'query input');
    res.fold((l) {
      log('$l', name: 'Error Issues Query');
    }, (r) {
      log('$r', name: 'Issues cntrl r');
      issues.clear();
      issues.addAll(r);
      log('$issues', name: 'Issues cntrl');
      update();
    });
  }

  // void getIssueData(){
  //   var item = issues.firstWhere((e) => Get.arguments==e.id);
  //   issuesEntity = item;
  // }

}