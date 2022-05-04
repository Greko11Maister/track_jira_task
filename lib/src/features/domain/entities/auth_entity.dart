import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable{
  final String? username;
  final String? token;

  AuthEntity({this.username, this.token});

  @override
  List<Object?> get props => [username, token];
}