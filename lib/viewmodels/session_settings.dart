import 'package:flutter/material.dart';
import 'package:pomodoro/util/session.dart';

class SessionSettings extends ChangeNotifier {
  Session _session = Session();

  Session get session => _session;

  Duration get sessionDuration => _session.sessionDuration;
  Duration get breakDuration => _session.breakDuration;

  set sessionDuration(Duration sd) {
    _session.sessionDuration = sd;
    notifyListeners();
  }

  set breakDuration(Duration bd) {
    _session.breakDuration = bd;
    notifyListeners();
  }

  set session(Session s) {
    _session = s;
    notifyListeners();
  }
}
