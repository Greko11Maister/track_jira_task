import 'dart:developer';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_jira_task/injection_container.dart';
import 'package:track_jira_task/src/core/settings/app_colors.dart';
import 'package:track_jira_task/src/core/settings/app_text_style.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/home_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/widgets/card_project.dart';
import 'package:track_jira_task/src/features/domain/entities/projects_entity.dart';

class HomePage extends StatelessWidget {
  final HomeController _controller = sl<HomeController>();
  static const String routeName = '/Home';

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          title: const Text('Proyectos', style: TextStyle(color: Colors.black87)),
          backgroundColor: Colors.white54),
      body: RefreshIndicator(
        onRefresh: _controller.loadProjects,
        child: ListView(
          children: [
            GetBuilder<HomeController>(
                init: _controller,
                builder: (_) {
                  return projectsTypeAhead(_);
                  //return listProject(_);
                }),
          ],
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
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              suggestion.avatarUrls?.avatar24 ?? '',
                              headers: {
                                'authorization':
                                    'Basic Z3JlZ29yeS5pc2NhbGFAdHJpYnUudGVhbTpiYXNzWktmOTNrNjdrdjVYTE9Ca0EzQjc='
                              }),
                          radius: 20.0,
                        ),
                        title: Text(suggestion.name ?? ''),
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

  ListView listProject(HomeController _) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _.projects.length,
        itemBuilder: (ctx, i) {
           log('${_.projects[i].name}',  name: 'NOMBRE:');
           log('${_.projects[i].avatarUrls?.avatar24}',  name: 'URL:');
          return CardProject(
            name: _.projects[i].name ?? '',
            avatarUrls: _.projects[i].avatarUrls?.avatar24 ?? '',
          );
        });
  }
}
