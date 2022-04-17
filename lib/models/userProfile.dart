// ignore_for_file: file_names

import 'package:pomodoro/util/database.dart' show DatabaseHelper;
import 'package:sqflite/sql.dart';

class UserProfileModel {
  final int userID;
  final String theme;
  final String alarmTone;
  final bool notificationEnabled;

  const UserProfileModel({
    required this.userID,
    required this.theme,
    required this.alarmTone,
    required this.notificationEnabled,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'theme': theme,
      'alarmTone': alarmTone,
      'notificationEnabled': notificationEnabled ? 1 : 0,
    };
  }

  @override
  String toString() {
    return '''

userId: $userID,
theme: $theme,
alarmTone: $alarmTone,
notificationEnabled: $notificationEnabled
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
      return UserProfileModel(
        userID: maps[i]['userID'],
        alarmTone: maps[i]['alarmTone'],
        theme: maps[i]['theme'],
        notificationEnabled: maps[i]['notificationEnabled'] == 1 ? true : false,
      );
    });
  }
}
