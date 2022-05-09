import 'dart:convert';
import 'package:get/get.dart';
import 'package:track_jira_task/src/core/usecases/usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_token_usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_username_usecase.dart';

class AuthController extends GetxController {
  final GetTokenUseCase _getTokenUseCase;
  final GetUsernameUseCase _getUsernameUseCase;

  String? _token;
  String? _username;

  AuthController({
    required GetTokenUseCase getTokenUseCase,
    required GetUsernameUseCase getUsernameUseCase})
      : _getTokenUseCase = getTokenUseCase,
        _getUsernameUseCase = getUsernameUseCase;

  //Token autorización imagen proyecto
  String? get token {
    // String username = 'gregory.iscala@tribu.team';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_username:$_token'));
    return basicAuth;
  }

  @override
  void onReady() async{

    loadToken();
    loadUsername();

    //Validación credenciales en Hive
    final res1 = await _getTokenUseCase.call(NoParams());
    res1.fold((l) => null, (r) {
      _token = r;
      update();
    });
    final res2 = await _getUsernameUseCase.call(NoParams());
    res2.fold((l) => null, (r) {
      _username = r;
      update();
    });
    // log('$_username', name: 'User Init Auth');
    if(_token==null && _username==null){
      Get.offNamed("/configuration/page");
    }else{
     Get.offNamed("/home/page");
    }
  }

  loadToken() async{
    final res = await _getTokenUseCase.call(NoParams());
    res.fold((l) => null, (r) {
      // log('$r',name: 'Token Auth cntrl');
      _token = r;
      update();
    });
  }

  loadUsername() async{
    final res = await _getUsernameUseCase.call(NoParams());
    res.fold((l) => null, (r) {
      // log('$r',name: 'Username Auth cntrl');
      _username = r;
      update();
    });
  }

}