import 'package:track_jira_task/src/features/domain/entities/projects_entity.dart';

class ProjectsModel extends ProjectsEntity {
  const ProjectsModel({
    String? id,
    String? name,
    AvatarUrlsModel? avatarUrls,
  }) : super(id: id, name: name, avatarUrls: avatarUrls);

  factory ProjectsModel.fromJson(Map<String, dynamic> json) {
    return ProjectsModel(
        id: json['id'],
        name: json['name'],
        avatarUrls: json.containsKey('avatarUrls') && json['avatarUrls'] != null
            ? AvatarUrlsModel.fromJson(json['avatarUrls'])
            : null);
  }
}

class AvatarUrlsModel extends AvatarsUrlsEntity {
  const AvatarUrlsModel({String? avatar24}) : super(avatar24: avatar24);

  factory AvatarUrlsModel.fromJson(Map<String, dynamic> json) {
    return AvatarUrlsModel(avatar24: json['24x24']);
  }
}
