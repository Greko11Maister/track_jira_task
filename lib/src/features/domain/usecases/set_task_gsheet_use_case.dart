import 'package:dartz/dartz.dart';
import 'package:track_jira_task/src/core/error/failures.dart';
import 'package:track_jira_task/src/core/usecases/usecase.dart';
import 'package:track_jira_task/src/features/domain/entities/task_entity.dart';
import 'package:track_jira_task/src/features/domain/repositories/google_sheets_repository.dart';

class SetTaskGSheetsUseCase implements UseCase<bool, TaskEntity/*List<TaskEntity>*/>{
  final GoogleSheetsRepository repository;

  SetTaskGSheetsUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(TaskEntity task) async{
    return await repository.setTaskGsheet(task);
  }

}