import 'package:pomodoro/util/util_functions.dart';

class Session {

  Session({
    this.sessionDuration = const Duration(minutes: 25),
    this.breakDuration = const Duration(minutes: 5),
  });

  Duration sessionDuration;
  Duration breakDuration;

  String get sessionHours =>
      intToStringWithPadding(sessionDuration.inHours.remainder(60));
  String get sessionMinutes =>
      intToStringWithPadding(sessionDuration.inMinutes.remainder(60));
  String get breakHours =>
      intToStringWithPadding(breakDuration.inMinutes.remainder(60));
  String get breakMinutes =>
      intToStringWithPadding(breakDuration.inMinutes.remainder(60));

  @override
  String toString() {
    return 'Session Hours: $sessionHours, Session Minutes: $sessionMinutes\nBreak Hours: $breakHours, Break Minutes: $breakMinutes';
  }
}
