import 'package:flutter/material.dart';
import 'package:pomodoro/models/filesystem_handle.dart';
import 'package:pomodoro/models/user_Profile.dart';

class SettingsProvider extends ChangeNotifier {
  UserProfileModel? _userProfileModel;

  String get theme => _userProfileModel!.theme;
  String get alarmTone => _userProfileModel!.alarmTone;
  bool get notificationEnabled => _userProfileModel!.notificationEnabled;
  bool get autoBreakEnabled => _userProfileModel!.autoBreakEnabled;

  set theme(String t) {
    _userProfileModel?.theme = t;
    notifyListeners();
    saveSettings();
  }

  set alarmTone(String alarm) {
    _userProfileModel?.alarmTone = alarm;
    notifyListeners();
    saveSettings();
  }

  set notificationEnabled(bool enabled) {
    _userProfileModel?.notificationEnabled = enabled;
    notifyListeners();
    saveSettings();
  }

  set autoBreakEnabled(bool enabled) {
    _userProfileModel?.autoBreakEnabled = enabled;
    notifyListeners();
    saveSettings();
  }

  @override
  String toString() {
    return _userProfileModel.toString();
  }

  // set userProfileModel(UserProfileModel u) {
  //   _userProfileModel = u;
  //    notifyListeners();
  // }

  void saveSettings() {
    if (_userProfileModel != null) {
      FileSystemHandler.writeSettings(_userProfileModel!.toMap());
    }
  }

  Future loadSettings() async {
    final settings = await FileSystemHandler.readSettings();
    if (settings != null) {
      _userProfileModel = UserProfileModel.fromMap(settings);
    } else {
      _userProfileModel = UserProfileModel();
      await FileSystemHandler.writeSettings(_userProfileModel!.toMap());
    }
  }
}
