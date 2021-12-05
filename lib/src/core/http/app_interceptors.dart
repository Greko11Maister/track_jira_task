import 'dart:io';

import 'package:dio/dio.dart';


class AppInterceptors extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    List noRequiresAuthentication = [];

    int requiresToken = noRequiresAuthentication.indexWhere((endpoint) => RegExp(endpoint, multiLine: true).hasMatch(options.path));

    if (requiresToken == -1) {
     // final resp = await sl<GetMainTokenUseCase>().call(NoParams());
      String token = /*resp.fold<String>((l) => '', (r) => r ?? '');*/ "";
      options.headers.addAll({"Authorization": "Bearer $token"});
    }

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
