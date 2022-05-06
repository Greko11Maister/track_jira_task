import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:track_jira_task/src/core/error/failures.dart';
import 'package:track_jira_task/src/features/data/datasource/google_sheets_remote_data_source.dart';
import 'package:track_jira_task/src/features/domain/entities/task_entity.dart';
import 'package:track_jira_task/src/features/domain/repositories/google_sheets_repository.dart';

class GoogleSheetsRepositoryImpl implements GoogleSheetsRepository{
  final GoogleSheetsRemoteDataSource remoteDataSource;

  GoogleSheetsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, bool>> setTaskGsheet(TaskEntity task) async{
    try {
      await remoteDataSource.setTaskGsheets(task);
      return const Right(true);
    }on ServerFailure catch (e){
      log('insert error',name:'repo impl');
      return Left(e);

    }
  }

  @override
  Future<Either<Failure, bool>> updateTaskGsheets(TaskEntity task) async{
    try {
      await remoteDataSource.updateTaskGsheets(task);
      return const Right(true);
    }on ServerFailure catch (e){
      return Left(e);
    }
  }

}