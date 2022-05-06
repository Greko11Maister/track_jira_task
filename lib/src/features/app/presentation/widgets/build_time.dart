import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/timer_controller.dart';
import 'package:track_jira_task/src/features/app/presentation/pages/timer_page.dart';
import 'package:track_jira_task/src/features/domain/entities/issues_entity.dart';

Widget buildTime({IssuesEntity? issue}) {
  final TimerController _controller = Get.find<TimerController>();

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  return GetBuilder<TimerController>(
    id: 'timer',
    init: _controller,
    builder: (_) {
      return Obx(() {
        final hours = twoDigits(_.duration.value.inHours);
        final minutes = twoDigits(_.duration.value.inMinutes.remainder(60));
        final seconds = twoDigits(_.duration.value.inSeconds.remainder(60));

        return Visibility(
          visible: issue == null || _.timerRunning == false || issue.id == _.issueRunning?.id,
          child: InkWell(
            onTap: (){
              if(_.issueRunning !=  null) Get.to(TimerPage(data: _.issueRunning!));
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                    visible: _.timerRunning == true && issue?.id != _.issueRunning?.id,
                      child: Column(
                        children: [
                          const Text('Incidencia en curso',
                            style: TextStyle(color: Colors.blue, fontSize: 22, fontWeight: FontWeight.bold),),
                          Text('${_.issueRunning?.name}',
                            style: const TextStyle(color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),),
                        ],
                      )),
                  buildTimeCard(time: hours, header: 'HORAS'),
                  const SizedBox(width: 8),
                  buildTimeCard(time: minutes, header: 'MINUTOS'),
                  const SizedBox(width: 8),
                  buildTimeCard(time: seconds, header: 'SEGUNDOS'),
                ],
              ),
          ),
        );
        }
      );
    }
  );
}

Widget buildTimeCard({required String time, required String header}) =>
    Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xffEBF2F4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            time,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 60,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(header, style: const TextStyle(color: Colors.black87)),
      ],
    );