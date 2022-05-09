import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/auth_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/home_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/timer_controller.dart';
import 'package:track_jira_task/src/features/domain/usecases/set_token_usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/set_username_usecase.dart';

class ConfigurationController extends GetxController {

  final SetTokenUseCase _setTokenUseCase;
  final SetUsernameUseCase _setUsernameUseCase;

  late AuthController _authController;
  late TimerController _timerController;
  late HomeController _homeController;

  final tokenCtrl = TextEditingController();
  final userNameCtrl = TextEditingController();


  ConfigurationController({
    required SetUsernameUseCase setUsernameUseCase,
    required SetTokenUseCase setTokenUseCase,
    })
      : _setUsernameUseCase = setUsernameUseCase,
        _setTokenUseCase = setTokenUseCase;

  @override
  void onReady() {
    _authController = Get.find<AuthController>();
    _timerController = Get.find<TimerController>();
    _homeController = Get.find<HomeController>();
    super.onReady();
    // update(['home']);
  }

  void saveToken(String token, String username) {
    // log(username,name: 'Username cntrl');
    _setTokenUseCase(token);
    _setUsernameUseCase(username);
    _authController.loadToken();
    _authController.loadUsername();
    _timerController.loadUser();
    _homeController.loadProjects();
    update();
  }
}