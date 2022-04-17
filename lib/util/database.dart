import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _db;
  static Future<Database?> get db async {
    if (_db == null) {
      WidgetsFlutterBinding.ensureInitialized();
      // await deleteDatabase(join(await getDatabasesPath(), 'pomodoro.db'));
      return await initDB();
    } else {
      return _db;
    }
  }

  static Future<Database?> initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'pomodoro.db'),
        onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE UserProfile (
            userID INTEGER PRIMARY KEY AUTOINCREMENT, alarmTone TEXT, theme TEXT, notificationEnabled INTEGER
          )
        ''');
      await db.execute('''
          CREATE TABLE Task (
            taskID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, sessionCount INTEGER, lbsCount INTEGER, sessionCompletedCount INTEGER, startingTime INTEGER, finishingTime INTEGER, sessionDuration INTEGER, breakDuration INTEGER, longBreakDuration INTEGER
          );
        ''');
      await db.execute('''
          CREATE TABLE Session (
            sessionID INTEGER PRIMARY KEY AUTOINCREMENT, taskID INTEGER, sessionDuration INTEGER, breakDuration INTEGER,
            FOREIGN KEY (taskID) REFERENCES Task(taskID)
          )
        ''');
    }, version: 1);
  }
}
