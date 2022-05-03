import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  final String? id;
  final String? name;
  final String? mail;

  UserEntity({this.id, this.name, this.mail});

  @override
  // TODO: implement props
  List<Object?> get props => [id, mail, name];
  
  
}

// class AvatarsUrlsEntity extends Equatable {
//   final String? avatar24;
//
//   const AvatarsUrlsEntity({this.avatar24});
//
//   @override
//   List<Object?> get props {
//     return [avatar24];
//   }
// }