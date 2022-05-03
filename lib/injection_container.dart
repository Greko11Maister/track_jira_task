import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:track_jira_task/src/core/database/collections_name.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/auth_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/configuration_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/home_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/timer_controller.dart';
import 'package:track_jira_task/src/features/data/datasource/auth_local_data_source.dart';
import 'package:track_jira_task/src/features/data/datasource/google_sheets_remote_data_source.dart';
import 'package:track_jira_task/src/features/data/datasource/project_remote_data_source.dart';
import 'package:track_jira_task/src/features/data/models/auth_adapter.dart';
import 'package:track_jira_task/src/features/data/repositories/auth_repository_impl.dart';
import 'package:track_jira_task/src/features/data/repositories/google_sheets_repository_impl.dart';
import 'package:track_jira_task/src/features/data/repositories/projects_repository_impl.dart';
import 'package:track_jira_task/src/features/domain/repositories/auth_repository.dart';
import 'package:track_jira_task/src/features/domain/repositories/google_sheets_repository.dart';
import 'package:track_jira_task/src/features/domain/repositories/projects_repository.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_issues_by_project_usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_issues_by_query_usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_projects_usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_token_usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_user_usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/set_task_gsheet_usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/set_token_usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/update_task_gsheets_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Controllers
  sl.registerFactory(() => HomeController(
        getProjectUseCase: sl(),
        getIssuesUseCase: sl(),
        getUserUseCase: sl(),
    getIssuesByQueryUseCase: sl(),
      ));

  sl.registerFactory(() => TimerController(
        setTaskGSheetsUseCase: sl(),
        updateTaskGSheetsUseCase: sl(),
        getUserUseCase: sl(),
      ));

  sl.registerFactory(() => ConfigurationController(
        getTokenUseCase: sl(),
        setTokenUseCase: sl(),
      ));

  sl.registerFactory(() => AuthController(getTokenUseCase: sl()));

  //Use Cases
  sl.registerLazySingleton(() => GetProjectUseCase(sl()));
  sl.registerLazySingleton(() => GetIssuesByProjectUseCase(sl()));
  sl.registerLazySingleton(() => GetIssuesByQueryUseCase(sl()));
  sl.registerLazySingleton(() => GetTokenUseCase(sl()));
  sl.registerLazySingleton(() => SetTokenUseCase(sl()));
  sl.registerLazySingleton(() => SetTaskGSheetsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTaskGSheetsUseCase(sl()));
  sl.registerLazySingleton(() => GetUserUseCase(sl()));

  //Repository
  sl.registerLazySingleton<ProjectsRepository>(() => ProjectsRepositoryImpl(
        remoteDataSource: sl(),
      ));

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        localDataSource: sl(),
      ));

  sl.registerLazySingleton<GoogleSheetsRepository>(
      () => GoogleSheetsRepositoryImpl(remoteDataSource: sl()));

  //Data Source
  sl.registerLazySingleton<ProjectRemoteDataSource>(
      () => ProjectRemoteDataSourceImpl());

  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl());

  sl.registerLazySingleton<GoogleSheetsRemoteDataSource>(
      () => GoogleSheetsRemoteDataSourceImpl());

  await Hive.initFlutter();
  //Adapters
  Hive.registerAdapter(AuthAdapterAdapter());

  //Open Box
  await Hive.openBox<String>(Collections.tokens);
}
