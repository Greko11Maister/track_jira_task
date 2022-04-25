import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:track_jira_task/src/core/database/collections_name.dart';

abstract class AuthLocalDataSource{
    Future<String?> getToken();
    Future<void> setToken(String token);
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {

  @override
  Future<String?> getToken() async {
    // var box = await Hive.box(Collections.tokens);
    Box<String> box = Hive.box<String>(Collections.tokens);
    String? token = box.get('token');
    // log(token!, name: 'getToken hive');
    return box.get('token');
  }

  @override
  Future<void> setToken(String token) async{
    Box<String?> box = Hive.box<String>(Collections.tokens);
    // String? token2 = box.get('token');
    // log(token2!, name: 'setToken hive');
    return box.put('token', token);
  }

}