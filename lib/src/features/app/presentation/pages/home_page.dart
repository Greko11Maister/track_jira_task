import 'dart:developer';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_jira_task/injection_container.dart';
import 'package:track_jira_task/src/core/settings/app_colors.dart';
import 'package:track_jira_task/src/core/settings/app_text_style.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/auth_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/home_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/timer_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/pages/configuration_page.dart';
import 'package:track_jira_task/src/features/app/presentation/pages/timer_page.dart';
import 'package:track_jira_task/src/features/app/presentation/widgets/build_time.dart';
import 'package:track_jira_task/src/features/app/presentation/widgets/card_project.dart';
import 'package:track_jira_task/src/features/domain/entities/projects_entity.dart';

class HomePage extends StatelessWidget {
  final TimerController _timerController = Get.find<TimerController>();
  final AuthController _authController = Get.find<AuthController>();
  final HomeController _controller = sl<HomeController>();
  static const String routeName = '/home/page';

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Proyectos Jira', style: TextStyle(color: Colors.black87)),
        actions: [
          const SizedBox(width: 10),
          FittedBox(child: buildTime()),
          FloatingActionButton.small(

            backgroundColor: Colors.white,
            child: const Icon(Icons.settings, color: Colors.black87),
              onPressed: (){
              Get.to(()=>ConfigurationPage());
              })
        ],
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xffEBF2F4)
      ),
      body: RefreshIndicator(
        onRefresh: _controller.loadProjects,
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xffEBF2F4),
                    Color(0xffC1DFEA),
                    Color(0xffD5DDE0)
                  ],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter)),
          child: ListView(
            children: [
              GetBuilder<HomeController>(

                  init: _controller,
                  builder: (_) {
                    return Column(
                      children: [
                        projectsTypeAhead(_),
                        const SizedBox(height: 10), // if(_.isProjectsLoading.value) return Center(child: CircularProgressIndicator(),);
                        ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _.issues.length,
                                itemBuilder: (ctx, i) {
                                  return Card(
                                    color: Color(0xffEBF2F4),
                                    margin: const EdgeInsets.all(1),
                                    elevation: 0.3,
                                    // color: Color(0xffEFF4F6),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                                      horizontalTitleGap: 15,
                                      focusColor: Colors.blue,
                                      leading: Text(_.issues[i].name!,
                                          style: const TextStyle(color: Colors.blue)),
                                      title: Text(_.issues[i].description!),
                                      onTap: (){
                                        // Get.to(()=> TimerPage(),arguments: _.issues[i]);
                                        Get.to(()=>TimerPage(data:_.issues[i]));
                                        // _.getIssueData();
                                        // print(_.issues[i].id);
                                      },
                                      // trailing: CircleAvatar(backgroundImage: NetworkImage(_.issues[i].img!)),
                                    ),
                                  );
                                  // log('${_.issues[i].img}', name: 'IMG');
                                }
                        )
                    //} //else if
                      ],
                    );
                    //return listProject(_);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Padding projectsTypeAhead(HomeController _) {
    return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TypeAheadFormField<ProjectsEntity>(
                    // autoFlipDirection: true,
                    textFieldConfiguration: TextFieldConfiguration(

                        style: AppTStyle.pTextW4S14sp,
                        enabled: !_.isProjectsLoading.value,
                        cursorColor: Colors.white,
                        controller: _.projectsCtrl,
                        decoration: InputDecoration(

                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.r)),
                              borderSide: const BorderSide(
                                  color: AppColors.pTextLink, width: 1.0)),
                          hintText: 'Buscar Proyecto',
                          hintStyle: AppTStyle.pTextButtonW3S12sp
                              .copyWith(color: Colors.grey),
                          suffixIcon: _.isProjectsLoading.value
                              ? Transform.scale(
                                  scale: 0.5,
                                  child: const CircularProgressIndicator(
                                      color: AppColors.primary),
                                )
                              : const Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.r)),
                              borderSide: const BorderSide(
                                  color: AppColors.pTextLink, width: 1.0)),
                          contentPadding: EdgeInsets.only(left: 10.w),
                        )),
                    itemBuilder: (context, ProjectsEntity suggestion) {
                      return GetBuilder<AuthController>(
                        init: _authController,
                        builder: (_) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  suggestion.avatarUrls?.avatar24 ?? '',
                                  headers: {
                                    'authorization':
                                        _.token!
                                  }),
                              radius: 20.0,
                            ),
                            title: Text(suggestion.name ?? ''),
                          );
                        }
                      );
                    },
                    onSuggestionSelected: (ProjectsEntity suggestion) {
                      _.setProjectSelected = suggestion;

                    },
                    suggestionsCallback: (pattern) async {
                      return _.projects
                          .where((val) => val.name!
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .toList();
                    },
                    transitionBuilder: (context, suggestionBox, controller) {
                      return suggestionBox;
                    },
                    loadingBuilder: (BuildContext context) {
                      return ListTile(
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: const CircularProgressIndicator(
                                    color: AppColors.primary))
                          ]));
                    },
                    noItemsFoundBuilder: (BuildContext context) {
                      return ListTile(
                          title: _.isProjectsLoading.value
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        width: 20.w,
                                        height: 20.h,
                                        child: const CircularProgressIndicator(
                                            color: AppColors.primary))
                                  ],
                                )
                              : Text(
                                  'No se han encontrado resultados',
                                  style: AppTStyle.pTextW4S14sp,
                                ));
                    },
                  ),
                );
  }

  // ListView listProject(HomeController _) {
  //   return ListView.builder(
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       itemCount: _.projects.length,
  //       itemBuilder: (ctx, i) {
  //          log('${_.projects[i].name}',  name: 'NOMBRE:');
  //          log('${_.projects[i].avatarUrls?.avatar24}',  name: 'URL:');
  //         return CardProject(
  //           name: _.projects[i].name ?? '',
  //           avatarUrls: _.projects[i].avatarUrls?.avatar24 ?? '',
  //         );
  //       });
  // }
}
