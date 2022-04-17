import 'package:pomodoro/util/util_functions.dart';

class Task {
  Task({
    this.taskID,
    this.sessionDuration = const Duration(minutes: 25),
    this.breakDuration = const Duration(minutes: 5),
    this.longBreakDuration = const Duration(minutes: 15),
    this.sessionCount = 4,
    this.lbsCount = 2,
    required this.taskName,
    this.sessionCompletedCount = 0,
  });

  int sessionCount;
  int? taskID;
  int sessionCompletedCount;

  /// After how many session do you want a long break.
  /// lbs -> Long Break Session Count
  int lbsCount;
  String taskName;
  Duration sessionDuration;
  Duration breakDuration;
  Duration longBreakDuration;

  String get sessionHours =>
      intToStringWithPadding(sessionDuration.inHours.remainder(60));
  String get sessionMinutes =>
      intToStringWithPadding(sessionDuration.inMinutes.remainder(60));
  String get breakHours =>
      intToStringWithPadding(breakDuration.inHours.remainder(60));
  String get breakMinutes =>
      intToStringWithPadding(breakDuration.inMinutes.remainder(60));
  String get longBreakHours =>
      intToStringWithPadding(longBreakDuration.inHours.remainder(60));
  String get longBreakMinutes =>
      intToStringWithPadding(longBreakDuration.inMinutes.remainder(60));

  @override
  String toString() {
    return 'Task name: $taskName\nEach Session Hours: $sessionHours, Session Minutes: $sessionMinutes\nBreak Hours: $breakHours, Break Minutes: $breakMinutes\nLong Break Hours: $longBreakHours, Long Break Minutes: $longBreakMinutes';
  }
}
