import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_jira_task/injection_container.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/home_controller.dart';

class IssuesPage extends StatefulWidget {

  final int? id;

  const IssuesPage({Key? key, this.id}) : super(key: key);

  @override
  State<IssuesPage> createState() => _IssuesPageState();
}

class _IssuesPageState extends State<IssuesPage> {
  final HomeController _controller = sl<HomeController>();
  static const String routeName = '/Issues';
  static const countdownDuration = Duration(seconds: 10);
  Duration duration = Duration();
  Timer? timer;

  bool isCountdown = false;

  @override
  void initState() {
    super.initState();
    // startTimer();
    reset();
  }

  void reset(){
    if(isCountdown){
      setState(() => duration = countdownDuration);
    }else {
      setState(() => duration = Duration());
    }
  }

  void addTime() {
    final addSeconds = isCountdown ? -1 : 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds <0){
        timer?.cancel();
      }else{
        duration = Duration(seconds: seconds);
      }
    });
  }

  void startTimer({bool resets = true}) {
    if(resets){
      reset();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        init: _controller,
        builder: (_) {
          return Container(
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xffEBF2F4), Color(0xffC1DFEA),Color(0xffD5DDE0)],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter
                )
            ),
            child: Center(
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Incidencia: ${_.issuesEntity!.name??''}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                  const SizedBox(height: 15),
                  Text(_.issuesEntity!.description??'',
                      style: const TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),),
                  const SizedBox(height: 150),
                  buildTime(),
                  const SizedBox(height: 50),
                  buildButtons(),
                ],
              ),


            ),
          );
        }
      ),
    );
  }

  Widget buildButtons() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = duration.inSeconds == 0;

    return isRunning || !isCompleted
        ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
            color: Colors.black87,
          child: Container(
            width: 100,
            height: 50,
            child: Center(
              child: Text(isRunning ? 'FINALIZAR' : 'REANUDAR', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ),
            onPressed: (){
              if(isRunning){
                stopTimer(resets: false);
              }else {
                startTimer(resets: false);
              }
            }
        ),
        const SizedBox(width: 12),
        RaisedButton(
            color: Colors.black87,
            child: Container(
              width: 100,
              height: 50,
              child: const Center(
                child: Text('CANCELAR', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
            onPressed: (){
                // startTimer(resets: true);
              stopTimer();
            }
        ),
      ],
    )
        : RaisedButton(
        color: Colors.black87,
        child: Container(
          width: 100,
          height: 50,
          child: const Center(
            child: Text('INICIAR', style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ),
        onPressed: (){
          startTimer();
        }
    );
    //     : ButtonWidget(
    //   text: 'Start Timer!',
    //   color: Colors.black,
    //   backgroundColor: Colors.white,
    //   onClicked: (){},
    // );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildTimeCard(time: hours, header: 'HORAS'),
        const SizedBox(width: 8),
        buildTimeCard(time: minutes, header: 'MINUTOS'),
        const SizedBox(width: 8),
        buildTimeCard(time: seconds, header: 'SEGUNDOS'),
      ],
    );
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xffEBF2F4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              time,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 70,
              ),
            ),
          ),
          const SizedBox(height:10),
          Text(header),
        ],
      );



}
