import 'package:track_jira_task/injection_container.dart';
import 'package:track_jira_task/src/core/env/env.dart';
import 'package:dio/dio.dart';
import 'app_interceptors.dart';

class ApiProvider {
  final String _baseApiUrl = sl<Env>().api;
  Dio? dio;

  ApiProvider() {
    dio = Dio(BaseOptions(baseUrl: _baseApiUrl));
    dio?.interceptors.add(AppInterceptors());
  }
}
