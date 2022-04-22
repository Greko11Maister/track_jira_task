import 'package:get_it/get_it.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/configuration_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/home_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/timer_controller.dart';
import 'package:track_jira_task/src/features/data/datasource/project_remote_data_source.dart';
import 'package:track_jira_task/src/features/data/repositories/projects_repository_impl.dart';
import 'package:track_jira_task/src/features/domain/repositories/projects_repository.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_issues_usecase.dart';
import 'package:track_jira_task/src/features/domain/usecases/get_projects_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Controllers
  sl.registerFactory(() => HomeController(
      getProjectUseCase: sl(),
      getIssuesUseCase: sl()));

  sl.registerFactory(() => TimerController());

  sl.registerFactory(() => ConfigurationController());

  //Use Cases
  sl.registerLazySingleton(() => GetProjectUseCase(sl()));
  sl.registerLazySingleton(() => GetIssuesUseCase(sl()));

  //Repository
  sl.registerLazySingleton<ProjectsRepository>(
          () => ProjectsRepositoryImpl(remoteDataSource: sl(),
          ));

  //Data Source
  sl.registerLazySingleton<ProjectRemoteDataSource>(
          () => ProjectRemoteDataSourceImpl());
}