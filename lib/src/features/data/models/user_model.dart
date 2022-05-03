import 'package:track_jira_task/src/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({
    String? id,
    String? name,
    String? mail,
    // AvatarUrlsModel? avatarUrls,
}):super(id:id, name: name, mail: mail);

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['accountId'],
      name: json['displayName'],
      mail: json['emailAddress'],
      // avatarUrls: json.containsKey('avatarUrls') && json['avatarUrls'] != null
      //     ? AvatarUrlsModel.fromJson(json['avatarUrls'])
      //     : null
            );
  }

}

// class AvatarUrlsModel extends AvatarsUrlsEntity {
//   const AvatarUrlsModel({String? avatar24}) : super(avatar24: avatar24);
//
//   factory AvatarUrlsModel.fromJson(Map<String, dynamic> json) {
//     return AvatarUrlsModel(avatar24: json['24x24']);
//   }
// }