import 'package:track_jira_task/src/features/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity{
  const TaskModel({
    int? id,
    String? activity,
    String? assignee,
    String? project,
    DateTime? initDate,
    DateTime? endDate,
}) : super(id:id, activity: activity, assignee: assignee, project: project, initDate: initDate, endDate: endDate);

  factory TaskModel.fromJson(Map<String, dynamic> json){
    return TaskModel(
      id: json['id'],
      activity: json['activity'],
      assignee: json['assignee'],
      project: json['project'],
      initDate: json['initDate'],
      endDate: json['endDate'],
    );
  }
}