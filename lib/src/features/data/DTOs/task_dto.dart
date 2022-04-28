class TaskDTO {
  final int? id;
  final String? activity;
  final String? assignee;
  final String? project;
  final DateTime? initDate;
  final DateTime? endDate;

  TaskDTO({
  this.id,
  this.activity,
  this.assignee,
  this.project,
  this.initDate,
  this.endDate,
});

  Map<String, dynamic> get queryParameters {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['activity'] = activity;
    data['assignee'] = assignee;
    data['project'] = project;
    data['initDate'] = initDate;
    data['endDate'] = endDate;
    return data;
  }
}