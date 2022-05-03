import 'package:dartz/dartz.dart';
import 'package:track_jira_task/src/core/error/failures.dart';
import 'package:track_jira_task/src/core/usecases/usecase.dart';
import 'package:track_jira_task/src/features/domain/entities/task_entity.dart';
import 'package:track_jira_task/src/features/domain/repositories/google_sheets_repository.dart';

class UpdateTaskGSheetsUseCase implements UseCase<bool, TaskEntity>{
  final GoogleSheetsRepository repository;

  UpdateTaskGSheetsUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(TaskEntity params) async{
    return await repository.updateTaskGsheets(params);
  }
}