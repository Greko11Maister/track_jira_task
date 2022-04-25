import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:track_jira_task/src/core/database/collections_name.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/auth_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/configuration_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/home_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/timer_controller.dart';
import 'package:track_jira_task/src/features/data/datasource/auth_local_data_source.dart';
import 'package:track_jira_task/src/features/data/datasource/project_remote_data_source.dart';
import 'package:track_jira_task/src/features/data/models/auth_adapter.dart';
import 'package:track_jira_task/src/features/data/repositories/auth_repository_impl.dart';
import 'package:track_jira_task/src/features/data/repositories/projects_repository_impl.dart';
import 'package:track_jira_task/src/features/domain/repositories/auth_repository.dart';
import 'package:track_jira_task/src/features/domain/repositories/projects_repository.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_issues_usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_projects_usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_token_use_case.dart';
import 'package:track_jira_task/src/features/domain/usecases/set_token_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Controllers
  sl.registerFactory(() => HomeController(
      getProjectUseCase: sl(),
      getIssuesUseCase: sl(),
    ));

  sl.registerFactory(() => TimerController());

  sl.registerFactory(() => ConfigurationController(
      getTokenUseCase: sl(),
      setTokenUseCase: sl(),
  ));

  sl.registerFactory(() => AuthController(
      getTokenUseCase: sl()
  ));

  //Use Cases
  sl.registerLazySingleton(() => GetProjectUseCase(sl()));
  sl.registerLazySingleton(() => GetIssuesUseCase(sl()));
  sl.registerLazySingleton(() => GetTokenUseCase(sl()));
  sl.registerLazySingleton(() => SetTokenUseCase(sl()));

  //Repository
  sl.registerLazySingleton<ProjectsRepository>(
          () => ProjectsRepositoryImpl(remoteDataSource: sl(),
          ));

  sl.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(localDataSource: sl(),
          ));

  //Data Source
  sl.registerLazySingleton<ProjectRemoteDataSource>(
          () => ProjectRemoteDataSourceImpl());

  sl.registerLazySingleton<AuthLocalDataSource>(
          () => AuthLocalDataSourceImpl());

  await Hive.initFlutter();
  //Adapters
  Hive.registerAdapter(AuthAdapterAdapter());

  //Open Box
  await Hive.openBox<String>(Collections.tokens);
}