import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final int? id;
  final String? activity;
  final String? assignee;
  final String? project;
  final DateTime? initDate;
  final  DateTime? endDate;

  const TaskEntity({
      this.id,
      this.activity,
      this.assignee,
      this.project,
      this.initDate,
      this.endDate
  });

  @override
  List<Object?> get props =>
      [id, activity, assignee, project, initDate, endDate];
}
