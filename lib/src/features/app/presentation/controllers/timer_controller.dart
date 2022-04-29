import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:track_jira_task/src/features/data/DTOs/task_dto.dart';
import 'package:track_jira_task/src/features/domain/entities/issues_entity.dart';
import 'package:track_jira_task/src/features/domain/entities/task_entity.dart';
import 'package:track_jira_task/src/features/domain/usecases/set_task_gsheet_use_case.dart';
import 'package:track_jira_task/src/features/domain/usecases/update_task_gsheets_use_case.dart';

class TimerController extends GetxController {
  final SetTaskGSheetsUseCase _setTaskGSheetsUseCase;
  final UpdateTaskGSheetsUseCase _updateTaskGSheetsUseCase;
  static const countdownDuration = Duration(seconds: 10);
  Rx<Duration> duration = const Duration().obs;
  Timer? timer;
  // TaskDTO? _taskDTO;

  bool isCountdown = false;
  RxBool timerRunning = false.obs;

  IssuesEntity? _issueRunning;
  TaskEntity? _taskEntity;

  TimerController({
    required SetTaskGSheetsUseCase setTaskGSheetsUseCase,
    required UpdateTaskGSheetsUseCase updateTaskGSheetsUseCase})
      : _setTaskGSheetsUseCase = setTaskGSheetsUseCase,
        _updateTaskGSheetsUseCase = updateTaskGSheetsUseCase;

  IssuesEntity? get issueRunning => _issueRunning;
  TaskEntity? get taskEntity => _taskEntity;


  void reset() {
    // issueRunning == null;
    if (isCountdown) {
      duration.value = countdownDuration;
    } else {
      duration.value = const Duration();
    }
    // update(['timer']);
  }

  void addTime() {
    final addSeconds = isCountdown ? -1 : 1;

    final seconds = duration.value.inSeconds + addSeconds;
    if (seconds < 0) {
      timer?.cancel();
    } else {
      duration.value = Duration(seconds: seconds);
    }
  }

  void startTimer({bool resets = true, IssuesEntity? issueRunning, String? project}) {
    _issueRunning = issueRunning;
    if (resets) {
      reset();
    }
    final initDate = DateTime.now();

    _taskEntity = TaskEntity(
      id: _issueRunning!.id,
      activity: _issueRunning!.description,
      assignee: 'Responsable',
      project: project,
      initDate: initDate,
      endDate: null,
    );
    _setTaskGSheetsUseCase.call(_taskEntity!);
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    log(_taskEntity!.toString(), name: 'TaskEntity Start');
    update();
  }

  void stopTimer({bool resets = true,IssuesEntity? issueRunning, String? project}) {
    if (resets) {
      reset();
    }
    log(_taskEntity!.toString(), name: 'TaskEntity Stop');
    final endDate = DateTime.now();
    // _taskEntity!.endDate = endDate.toString();
    _taskEntity = TaskEntity(
      id: _issueRunning!.id,
      activity: _issueRunning!.description,
      assignee: 'Responsable',
      project: project,
      initDate: null,
      endDate: endDate,
    );

    _updateTaskGSheetsUseCase.call(_taskEntity!);
    timer?.cancel();
    issueRunning == null;
    update();
  }
}
