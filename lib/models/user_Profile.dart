// ignore_for_file: file_names

import 'package:pomodoro/util/database.dart' show DatabaseHelper;
import 'package:sqflite/sql.dart';

class UserProfileModel {
  int? userID;
  String theme;
  String alarmTone;
  bool notificationEnabled;
  bool autoBreakEnabled;

  UserProfileModel({
    this.userID,
    this.theme = 'light',
    this.alarmTone = 'default',
    this.notificationEnabled = true,
    this.autoBreakEnabled = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'theme': theme,
      'alarmTone': alarmTone,
      'notificationEnabled': notificationEnabled ? 1 : 0,
      'autoBreakEnabled': autoBreakEnabled ? 1 : 0,
    };
  }

  static UserProfileModel fromMap(Map<String, dynamic> profileMap) {
    return UserProfileModel(
      userID: profileMap['userID'],
      alarmTone: profileMap['alarmTone'] ?? 'default',
      theme: profileMap['theme'] ?? 'light',
      notificationEnabled: profileMap['notificationEnabled'] != null
          ? profileMap['notificationEnabled'] == 1
              ? true
              : false
          : true,
      autoBreakEnabled: profileMap['autoBreakEnabled'] != null
          ? profileMap['autoBreakEnabled'] == 1
              ? true
              : false
          : false,
    );
  }

  @override
  String toString() {
    return '''

userId: $userID,
theme: $theme,
alarmTone: $alarmTone,
notificationEnabled: $notificationEnabled,
autoBreakEnabled: $autoBreakEnabled
''';
  }

  static Future insertData(UserProfileModel userProfile) async {
    final db = await DatabaseHelper.db;
    db!.insert(
      'UserProfile',
      userProfile.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<UserProfileModel>> getData() async {
    final db = await DatabaseHelper.db;
    final List<Map<String, dynamic>> maps = await db!.query('UserProfile');
    return List.generate(maps.length, (i) {
      return fromMap(maps[i]);
    });
  }
}
