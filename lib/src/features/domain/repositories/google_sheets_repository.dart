import 'package:dartz/dartz.dart';
import 'package:track_jira_task/src/core/error/failures.dart';
import 'package:track_jira_task/src/features/domain/entities/task_entity.dart';

abstract class GoogleSheetsRepository{

  Future<Either<Failure, bool>> setTaskGsheet(TaskEntity task);
  Future<Either<Failure, bool>> updateTaskGsheets(TaskEntity task);

}