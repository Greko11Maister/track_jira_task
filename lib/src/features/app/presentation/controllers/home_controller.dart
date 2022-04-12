
import 'dart:developer';

import 'package:get/get.dart';
import 'package:track_jira_task/src/core/usecases/usecase.dart';
import 'package:track_jira_task/src/features/domain/entities/projects_entity.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_projects_usecase.dart';

class HomeController extends GetxController {
  final GetProjectUseCase _getProjectUseCase;

  RxList<ProjectsEntity> projects = <ProjectsEntity>[].obs;


  HomeController({
    required GetProjectUseCase getProjectUseCase,
  }) : _getProjectUseCase = getProjectUseCase;

  @override
  void onReady() {
     loadProjects();
    super.onReady();
  }

  Future<void> loadProjects()async{
    final res = await _getProjectUseCase.call(NoParams());

    res.fold((l) {
      log('$l', name: 'Error Projects');
    }, (r) {
      projects.addAll(r);
      update();
    });
  }

}