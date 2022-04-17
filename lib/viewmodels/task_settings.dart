import 'package:flutter/material.dart';
import 'package:pomodoro/models/task.dart';
import 'package:pomodoro/util/task.dart';

class TaskSettings extends ChangeNotifier {
  Task _task = Task(taskName: '');

  // ignore: unnecessary_getters_setters
  Task get task => _task;

  String get taskName => _task.taskName;
  int get sessionCount => _task.sessionCount;
  int get lbsCount => _task.lbsCount;
  Duration get sessionDuration => _task.sessionDuration;
  Duration get breakDuration => _task.breakDuration;
  Duration get longBreakDuration => _task.longBreakDuration;

  set sessionCount(int sCount) {
    _task.sessionCount = sCount;
    // notifyListeners();
  }

  set taskName(String name) {
    _task.taskName = name;
  }

  set lbsCount(int count) {
    _task.lbsCount = count;
    // notifyListeners();
  }

  set sessionDuration(Duration sd) {
    _task.sessionDuration = sd;
    // notifyListeners();
  }

  set breakDuration(Duration bd) {
    _task.breakDuration = bd;
    // notifyListeners();
  }

  set longBreakDuration(Duration lbd) {
    _task.longBreakDuration = lbd;
    // notifyListeners();
  }

  set taskID(int id) {
    _task.taskID = id;
  }

  set task(Task t) {
    _task = t;
    // notifyListeners();
  }

  Future saveTask() async {
    var taskmodel = TaskModel.fromTask(task, taskStartingTime: DateTime.now());
    var id = await TaskModel.insertTask(taskmodel);
    taskID = id;
  }
}
