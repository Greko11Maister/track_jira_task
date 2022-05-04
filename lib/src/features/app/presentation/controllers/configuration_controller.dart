import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_token_usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/set_token_usecase.dart';

class ConfigurationController extends GetxController {
  final GetTokenUseCase _getTokenUseCase;
  final SetTokenUseCase _setTokenUseCase;

  final tokenCtrl = TextEditingController();
  final userNameCtrl = TextEditingController();

  ConfigurationController({
    required GetTokenUseCase getTokenUseCase,
    required SetTokenUseCase setTokenUseCase})
      : _getTokenUseCase = getTokenUseCase,
        _setTokenUseCase = setTokenUseCase;


  void saveToken(String token) {
    _setTokenUseCase(token);
    // _getTokenUseCase;
    update();
  }
}