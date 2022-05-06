import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:track_jira_task/injection_container.dart';
import 'package:track_jira_task/src/core/usecases/usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_token_usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_username_usecase.dart';


class AppInterceptors extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // List noRequiresAuthentication = [];
    //
    // int requiresToken = noRequiresAuthentication.indexWhere((endpoint) => RegExp(endpoint, multiLine: true).hasMatch(options.path));
    //
    // if (requiresToken == -1) {
      // final resp = await sl<GetMainTokenUseCase>().call(NoParams());
      // String token = /*resp.fold<String>((l) => '', (r) => r ?? '');*/ "";
    //   options.headers.addAll({"Authorization": "Bearer $token"});
    // }
    // String username = 'dennis.calderon@tribu.team';
    // String username = 'gregory.iscala@tribu.team';
    final res = await sl<GetTokenUseCase>().call(NoParams());
    var pass = res.fold((l) => null, (r) => r ?? '');
    final res2 = await sl<GetUsernameUseCase>().call(NoParams());
    var username = res2.fold((l) => null, (r) => r ?? '');
    // String password = 'bbnFKSCNGSnDWPaOz5msF844';
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$pass'));

    log(basicAuth, name: 'app Interceptor');
    options.headers.addAll({"Authorization": basicAuth});


    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioError dioError, ErrorInterceptorHandler handler,) async {
    switch (dioError.type) {
      case DioErrorType.response:
        if (dioError.response?.statusCode == 401 && dioError.response?.data['status'] == 'El token ha expirado') {
          // Todo: Clear Session
        }


        if (dioError.response?.data.containsKey("message") &&
            dioError.response?.data["message"].contains("jwt")) {

        }
      break;
      default:
        break;
    }

    switch (dioError.error.runtimeType) {
      case SocketException:
        switch ((dioError.error as SocketException).osError?.errorCode ?? -1) {
          case 7:
          case 110:
          case 101:
            // Show.showCustomSnackbar(
            //   "Verifica tu conexión a internet",
            //   "",
            //   svgIcon: AppAssets.not_sin_internet,
            //   snackPosition: SnackPosition.BOTTOM,
            //   duration: Duration(seconds: 15)
            // );
            break;
          default:
        }
        break;
    }

    return super.onError(dioError, handler);
  }
}
