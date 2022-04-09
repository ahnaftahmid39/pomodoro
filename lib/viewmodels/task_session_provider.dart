import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/util/task.dart';

class TaskSessionProvider extends ChangeNotifier {
  TaskSessionProvider({required this.task, this.autoBreak = false}) {
    sessionDuration = task.sessionDuration;
    breakDuration = task.breakDuration;
    longBreakDuration = task.longBreakDuration;
  }



  final Task task;
  bool autoBreak;
  Timer? _timer;
  Duration dx = const Duration(milliseconds: 10);
  late Duration sessionDuration;
  late Duration breakDuration;
  late Duration longBreakDuration;

  TimerType timerType = TimerType.sessionTimer;

  int sessionCompletedCount = 0;

  TaskSessionState state = TaskSessionState.initial;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void runSession({bool reset = false}) {
    if (reset) sessionDuration = task.sessionDuration;
    state = TaskSessionState.sessionRunning;
    timerType = TimerType.sessionTimer;
    sessionDuration = Duration(seconds: sessionDuration.inSeconds - 1);
    notifyListeners();
    _timer?.cancel();
    _timer = Timer.periodic(dx, (timer) {
      if (sessionDuration.inSeconds > 0) {
        sessionDuration = Duration(seconds: sessionDuration.inSeconds - 1);
        notifyListeners();
      } else {
        timer.cancel();
        state = TaskSessionState.sessionCompleted;
        sessionCompletedCount++;
        if (sessionCompletedCount >= task.sessionCount) {
          state = TaskSessionState.completed;
        }
        notifyListeners();
        if (autoBreak) {
          if (sessionCompletedCount % task.lbsCount == 0) {
            runLongBreak(reset: true);
          } else {
            runBreak(reset: true);
          }
        }
      }
    });
  }

  void runBreak({bool reset = false}) {
    if (reset) breakDuration = task.breakDuration;
    state = TaskSessionState.breakRunning;
    timerType = TimerType.breakTimer;
    breakDuration = Duration(seconds: breakDuration.inSeconds - 1);
    notifyListeners();
    _timer?.cancel();
    _timer = Timer.periodic(dx, (timer) {
      if (breakDuration.inSeconds > 0) {
        breakDuration = Duration(seconds: breakDuration.inSeconds - 1);
        notifyListeners();
      } else {
        timer.cancel();
        state = TaskSessionState.breakCompleted;
        notifyListeners();
      }
    });
  }

  void runLongBreak({bool reset = false}) {
    if (reset) longBreakDuration = task.longBreakDuration;
    state = TaskSessionState.longBreakRunning;
    timerType = TimerType.longbreakTimer;
    longBreakDuration = Duration(seconds: longBreakDuration.inSeconds - 1);
    notifyListeners();
    _timer?.cancel();
    _timer = Timer.periodic(dx, (timer) {
      if (longBreakDuration.inSeconds > 0) {
        longBreakDuration = Duration(seconds: longBreakDuration.inSeconds - 1);
        notifyListeners();
      } else {
        timer.cancel();
        state = TaskSessionState.longBreakCompleted;
        notifyListeners();
      }
    });
  }

  void pause() {
    if (timerType == TimerType.sessionTimer) {
      state = TaskSessionState.sessionPaused;
    } else if (timerType == TimerType.breakTimer) {
      state = TaskSessionState.breakPaused;
    } else {
      state = TaskSessionState.longBreakPaused;
    }
    _timer?.cancel();
    notifyListeners();
  }

  void unpause() {
    if (timerType == TimerType.sessionTimer) {
      runSession();
    } else if (timerType == TimerType.breakTimer) {
      runBreak();
    } else {
      runLongBreak();
    }
  }

  void stop() {
    _timer?.cancel();
    state = TaskSessionState.incomplete;
    notifyListeners();
  }

  void handleOnStart() {
    if (state == TaskSessionState.completed) {
      return;
    }
    if (timerType == TimerType.sessionTimer) {
      if (state == TaskSessionState.sessionCompleted) {
        if (sessionCompletedCount % task.lbsCount == 0) {
          runLongBreak(reset: true);
        } else {
          runBreak(reset: true);
        }
      } else {
        runSession();
      }
    } else if (timerType == TimerType.breakTimer) {
      if (state == TaskSessionState.breakCompleted) {
        runSession(reset: true);
      } else {
        runBreak();
      }
    } else {
      if (state == TaskSessionState.longBreakCompleted) {
        runSession(reset: true);
      } else {
        runLongBreak();
      }
    }
  }
}

enum TimerType {
  sessionTimer,
  breakTimer,
  longbreakTimer,
}

enum TaskSessionState {
  initial,
  sessionRunning,
  sessionPaused,
  sessionCompleted,
  breakRunning,
  breakPaused,
  breakCompleted,
  longBreakRunning,
  longBreakPaused,
  longBreakCompleted,
  completed,
  incomplete,
}