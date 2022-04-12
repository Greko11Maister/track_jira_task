import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:track_jira_task/src/core/env/env.dart';
import 'package:track_jira_task/src/features/app/presentation/app.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  sl.registerLazySingleton(() => Env(EnvMode.sandbox));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_){
    runApp(const App());
  });
}

