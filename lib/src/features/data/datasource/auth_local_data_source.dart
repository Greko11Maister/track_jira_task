import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:track_jira_task/src/core/database/collections_name.dart';

abstract class AuthLocalDataSource{
    Future<String?> getToken();
    Future<void> setToken(String token);
    Future<String?> getUsername();
    Future<void> setUsername(String username);
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {

  @override
  Future<String?> getToken() async {
    // var box = await Hive.box(Collections.tokens);
    Box<String> box = Hive.box<String>(Collections.tokens);
    String? token = box.get('token');
    log(token!, name: 'getToken hive');
    return box.get('token');
  }

  @override
  Future<String?> getUsername() async{
    Box<String> box2 = Hive.box<String>(Collections.username);
    String? username = box2.get('username');
    log(username!, name: 'username hive');
    return box2.get('username');
  }

  @override
  Future<void> setToken(String token) async{
    Box<String?> box = Hive.box<String>(Collections.tokens);
    // String? token2 = box.get('token');
    // log(token2??'', name: 'setToken hive');
    return box.put('token', token);
  }

  @override
  Future<void> setUsername(String username) async{
    Box<String?> box2 = Hive.box<String>(Collections.username);
    // String? username2 = box2.get('username');
    // log(username2??'', name: 'setUsername hive');
    return box2.put('username', username);
  }

}