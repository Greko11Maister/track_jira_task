import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_jira_task/injection_container.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/auth_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/timer_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/pages/configuration_page.dart';
import 'package:track_jira_task/src/features/app/presentation/pages/home_page.dart';
import 'package:track_jira_task/src/features/app/presentation/pages/timer_page.dart';


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(sl<TimerController>());
    Get.put(sl<AuthController>());

    return ScreenUtilInit(
        designSize: const Size(360, 780),
        builder: () {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Track Jira Task app',
            // theme: ThemeData(
            //     primaryColor: const Color(0xff0277BD), fontFamily: 'Rubik'),
            initialRoute: HomePage.routeName,
            getPages: [
              GetPage(
                  name: HomePage.routeName,
                  page: () => HomePage()),
             /* GetPage(
                  name: TimerPage.routeName,
                  page: () => TimerPage()),*/
              GetPage(
                  name: ConfigurationPage.routeName,
                  page: () => ConfigurationPage()),
            ],
          );
        });
  }
  }