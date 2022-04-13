
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_jira_task/src/core/usecases/usecase.dart';
import 'package:track_jira_task/src/features/domain/entities/projects_entity.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_projects_usecase.dart';

class HomeController extends GetxController {
  final GetProjectUseCase _getProjectUseCase;

  TextEditingController projectsCtrl = TextEditingController();
  String? id;

  RxList<ProjectsEntity> projects = <ProjectsEntity>[].obs;

  RxBool isProjectsLoading = false.obs;


  HomeController({
    required GetProjectUseCase getProjectUseCase,
  }) : _getProjectUseCase = getProjectUseCase;

  @override
  void onReady() {
     loadProjects();
    super.onReady();
  }

  set setProjectSelected(ProjectsEntity value) {
      projectsCtrl.text = value.name!;
      id = value.id;
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

}