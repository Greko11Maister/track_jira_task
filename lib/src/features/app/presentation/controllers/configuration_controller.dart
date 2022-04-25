import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_token_use_case.dart';
import 'package:track_jira_task/src/features/domain/usecases/set_token_use_case.dart';

class ConfigurationController extends GetxController {
  final GetTokenUseCase _getTokenUseCase;
  final SetTokenUseCase _setTokenUseCase;

  final tokenCtrl = TextEditingController();

  ConfigurationController({
    required GetTokenUseCase getTokenUseCase,
    required SetTokenUseCase setTokenUseCase})
      : _getTokenUseCase = getTokenUseCase,
        _setTokenUseCase = setTokenUseCase;

  @override
  void onInit() {
    // _getTokenUseCase;
    super.onInit();
  }

  void saveToken(String token) {
    _setTokenUseCase(token);
    // _getTokenUseCase;
    update();
  }
}