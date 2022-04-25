import 'package:track_jira_task/src/features/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity{
  AuthModel({String? username, String? token})
  : super(username: username, token: token);

  factory AuthModel.fromJson(Map<String, dynamic> json){
    return AuthModel(
      username: json['username'],
      token: json['token']
    );
  }
}