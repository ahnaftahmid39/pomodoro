import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:pomodoro/models/userProfile.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper db = DatabaseHelper._();
  static Database? _database;

  Future<Database?> get database async {
    if(_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'pomodoro.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE UserProfile (
            userID INTEGER PRIMARY KEY, alarmTone TEXT, theme TEXT, notificationEnabled INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE Task (
            taskID INTEGER PRIMARY KEY, name TEXT, count INTEGER, isCompleted INTEGER, startTime INTEGER, finishTime INTEGER
          )
        ''');
        await db.execute('''
          CREATE TABLE Session (
            sessionID INTEGER PRIMARY KEY, taskID INTEGER, duration INTEGER, breakTime INTEGER
            FOREIGN KEY (taskID)
            REFERENCES Task(taskID)
          )
        ''');
      },
      version: 1
    );
  }
}
