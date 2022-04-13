import 'package:track_jira_task/src/features/domain/entities/issues_entity.dart';

class IssuesModel extends IssuesEntity{
  IssuesModel({
    int? id,
    String? name,
    String? img,
    String? description,
}) : super(id: id, name: name, img: img, description: description);

  factory IssuesModel.fromJson(Map<String, dynamic> json) {
    return IssuesModel(
      id: json['id'],
      name: json['key'],
      img: json['img'],
      description: json['summary'],
    );
  }

}