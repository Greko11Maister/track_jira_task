import 'dart:async';
import 'package:get/get.dart';
import 'package:track_jira_task/src/features/app/presentation/controllers/home_controller.dart';
import 'package:track_jira_task/src/features/domain/entities/issues_entity.dart';

class TimerController extends GetxController {
  static const countdownDuration = Duration(seconds: 10);
  Rx<Duration> duration = Duration().obs;
  Timer? timer;

  bool isCountdown = false;
  RxBool timerRunning = false.obs;

  IssuesEntity? _issueRunning;

  IssuesEntity? get issueRunning => _issueRunning;


@override
  void onInit() async{
  //startTimer();
    super.onInit();
    update(['timer']);
  }

  @override
  void onReady() {
    // startTimer(resets: false);
    super.onReady();

  }

  void reset(){
    // issueRunning == null;
    if(isCountdown){
      duration.value = countdownDuration;
    }else {
      duration.value = Duration();
    }
    // update(['timer']);
  }

  void addTime() {
    final addSeconds = isCountdown ? -1 : 1;

      final seconds = duration.value.inSeconds + addSeconds;
      if (seconds <0){
        timer?.cancel();
      }else{
        duration.value = Duration(seconds: seconds);
      }
  }

  void startTimer({bool resets = true, IssuesEntity? issueRunning}) {
  this._issueRunning = issueRunning;
    if(resets){
      reset();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    update();
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timer?.cancel();
    issueRunning == null;
    update();
  }
}