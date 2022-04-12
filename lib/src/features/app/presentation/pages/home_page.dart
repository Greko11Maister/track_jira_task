import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_jira_task/injection_container.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/home_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/widgets/card_project.dart';

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
          title: Text('Proyectos', style: TextStyle(color: Colors.black87)),
          backgroundColor: Colors.white54),
      body: RefreshIndicator(
        onRefresh: _controller.loadProjects,
        child: ListView(
          children: [
            SingleChildScrollView(
              child: GetBuilder<HomeController>(
                  init: _controller,
                  builder: (_) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                        itemCount: _.projects.length,
                        itemBuilder: (ctx, i) {
                        // log('${_.projects[i].name}',  name: 'NOMBRE:');
                        // log('${_.projects[i].avatarUrls?.avatar24}',  name: 'URL:');
                          return CardProject(
                            name: _.projects[i].name??'',
                            avatarUrls: _.projects[i].avatarUrls?.avatar24 ?? '',
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
