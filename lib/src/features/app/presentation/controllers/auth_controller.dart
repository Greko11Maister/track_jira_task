import 'dart:convert';

import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:track_jira_task/src/core/usecases/usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_token_usecase.dart';

class AuthController extends GetxController {
  @override

  final GetTokenUseCase _getTokenUseCase;

  String? _token;

  String? get token {
    String username = 'gregory.iscala@tribu.team';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$_token'));
    return basicAuth;
  }

  AuthController({required GetTokenUseCase getTokenUseCase})
      : _getTokenUseCase = getTokenUseCase;

  void onReady() {
    loadToken();
    super.onReady();
  }

  loadToken() async{
    final res = await _getTokenUseCase.call(NoParams());
    res.fold((l) => null, (r) {
      this._token = r;
      update();
    });
  }

}