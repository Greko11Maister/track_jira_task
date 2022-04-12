import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:track_jira_task/src/features/app/presentation/pages/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              GetPage(name: '/Home', page: () => HomePage()),
              // GetPage(
              //     name: InletPage.routeName,
              //     page: () => InletPage(),
              //     binding: InletBinding()),
            ],
          );
        });
  }
  }