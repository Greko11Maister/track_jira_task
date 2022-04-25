import 'package:hive/hive.dart';
import 'package:track_jira_task/src/features/domain/entities/auth_entity.dart';

 part 'auth_adapter.g.dart';

@HiveType(typeId:3)
// ignore: must_be_immutable
class AuthAdapter extends AuthEntity {

  @HiveField(0)
  String? token;

  @HiveField(1)
  String? username;

  AuthAdapter({this.username, this.token})
  : super(token: token, username: username);
}