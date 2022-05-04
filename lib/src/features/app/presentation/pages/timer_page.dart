import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/timer_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/widgets/build_time.dart';
import 'package:track_jira_task/src/features/domain/entities/issues_entity.dart';
import 'package:track_jira_task/src/features/domain/entities/projects_entity.dart';
import 'package:track_jira_task/src/features/domain/entities/task_entity.dart';


class TimerPage extends StatelessWidget {
  final TimerController _controller = Get.find<TimerController>();
  final IssuesEntity data;
  final String? project;
  static const String routeName = '/timer/page';
  // TaskEntity? taskEntity;

  TimerPage({Key? key, required this.data, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(data);
    return Scaffold(
      appBar: AppBar(
        leading:  GetBuilder<TimerController>(
            init: _controller,
            builder: (_) {
              return FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    const Icon(Icons.account_circle,color: Colors.black87),
                    Text('${_.nameUser}', style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),),
                  ],),
                ),
              );
            }
        ),
        actions: [
          GetBuilder<TimerController>(
            builder: (_) {
              return Visibility(
                  visible: _.timerRunning.value != false && data.id != _.issueRunning?.id,
                  child: FittedBox(child: buildTime())
              );
            }
          ),
        ],
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xffEBF2F4),
      ),
      body:Container(
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xffEBF2F4),
                  Color(0xffC1DFEA),
                  Color(0xffD5DDE0)
                ],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Incidencia: ${data.name}',
                //${_.homeController.issuesEntity!.name??''}
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                '${data.description?.replaceAll("<b>", "").replaceAll("</b>", "")}',
                //_.homeController.issuesEntity!.description??''
                style: const TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 150),
              buildTime(issue: data),
              const SizedBox(height: 50),
              // buildButtons(),
              GetBuilder<TimerController>(
                init: _controller,
                builder: (_) {
                  return Visibility(
                    visible:  _.timerRunning.value == false || data.id == _.issueRunning?.id,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Visibility(
                          visible: _.timerRunning.value == false,
                          child: Center(
                            child: ElevatedButton(
                                style:  ElevatedButton.styleFrom(
                                  primary: Colors.black87,
                                ),
                                child: Container(
                                  width: 100,
                                  height: 50,
                                  child: const Center(
                                    child: Text('INICIAR',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18)),
                                  ),
                                ),
                                onPressed: () {
                                  _.startTimer(issueRunning:  data,project: project);
                                  _.timerRunning.value = true;
                                }),
                          ),
                        ),

                        Visibility(
                          visible: _.timerRunning.value ==true,
                          child: ElevatedButton(
                              style:  ElevatedButton.styleFrom(
                                primary: Colors.black87,
                              ),
                              child: Container(
                                width: 100,
                                height: 50,
                                child: const Center(
                                  child: Text('TERMINAR',style: TextStyle(color: Colors.white, fontSize: 18)),
                                ),
                              ),
                              onPressed: (){
                                _.stopTimer(issueRunning:  data,project: project);
                                _.reset();
                                _.timerRunning.value = false;
                              }
                          ),
                        ),
                      ],
                    ),
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }

}
