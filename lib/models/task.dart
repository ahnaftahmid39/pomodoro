import 'package:pomodoro/util/database.dart';
import 'package:pomodoro/util/task.dart';
import 'package:sqflite/sql.dart';

class TaskModel {
  late int? taskID;
  late String name;
  late int sessionCount;
  late int sessionCompletedCount;
  DateTime? startingTime;
  DateTime? finishingTime;
  late int lbsCount;
  late Duration sessionDuration;
  late Duration breakDuration;
  late Duration longBreakDuration;

  TaskModel({
    this.taskID,
    required this.name,
    required this.sessionCount,
    this.sessionCompletedCount = 0,
    this.startingTime,
    this.finishingTime,
    required this.lbsCount,
    required this.sessionDuration,
    required this.breakDuration,
    required this.longBreakDuration,
  });

  TaskModel.fromTask(Task task,
      {int? id, DateTime? taskStartingTime, DateTime? taskFinishingTime}) {
    taskID = id;
    name = task.taskName;
    sessionCount = task.sessionCount;
    lbsCount = task.lbsCount;
    sessionDuration = task.sessionDuration;
    breakDuration = task.breakDuration;
    longBreakDuration = task.longBreakDuration;
    sessionCompletedCount = task.sessionCompletedCount;
    startingTime = taskStartingTime;
    finishingTime = taskFinishingTime;
  }

  Task get task => Task(
        taskName: name,
        breakDuration: breakDuration,
        lbsCount: lbsCount,
        longBreakDuration: longBreakDuration,
        sessionCount: sessionCount,
        sessionDuration: sessionDuration,
        sessionCompletedCount: sessionCompletedCount,
        taskID: taskID,
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sessionCount': sessionCount,
      'sessionCompletedCount': sessionCompletedCount,
      'startingTime': startingTime?.millisecondsSinceEpoch,
      'finishingTime': finishingTime?.millisecondsSinceEpoch,
      'lbsCount': lbsCount,
      'sessionDuration': sessionDuration.inMilliseconds,
      'breakDuration': breakDuration.inMilliseconds,
      'longBreakDuration': longBreakDuration.inMilliseconds,
    };
  }

  @override
  String toString() {
    return '''

  taskID: $taskID,
  name: $name,
  sessionCount: $sessionCount,
  sessionCompletedCount: $sessionCompletedCount,
  startingTime: $startingTime,
  finishingTime: $finishingTime,
  lbsCount: $lbsCount,
  sessionDuration: $sessionDuration,
  breakDuration: $breakDuration,
  longBreakDuration: $longBreakDuration
''';
  }

  static Future updateTaskById(int id, TaskModel taskModel) async {
    final db = await DatabaseHelper.db;
    await db!.update(
      'Task',
      taskModel.toMap(),
      where: 'taskID = ?',
      whereArgs: [id],
    );
  }

  static Future<TaskModel> findById(int id) async {
    final db = await DatabaseHelper.db;
    var queryRes = await db!.query(
      'Task',
      where: 'taskID = ?',
      whereArgs: [id],
    );
    return mapToTaskModel(queryRes[0]);
  }

  static deleteById(int id) async {
    final db = await DatabaseHelper.db;
    await db!.delete('Task', where: 'taskID = ?', whereArgs: [id]);
  }

  static Future<int> insertTask(TaskModel task) async {
    final db = await DatabaseHelper.db;
    int id = await db!.insert(
      'Task',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  static TaskModel mapToTaskModel(Map<String, dynamic> map) {
    return TaskModel(
      taskID: map['taskID'],
      name: map['name'],
      sessionCount: map['sessionCount'],
      sessionCompletedCount: map['sessionCompletedCount'],
      startingTime: map['startingTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startingTime'])
          : null,
      finishingTime: map['finishingTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['finishingTime'])
          : null,
      lbsCount: map['lbsCount'],
      sessionDuration: Duration(milliseconds: map['sessionDuration']),
      breakDuration: Duration(milliseconds: map['breakDuration']),
      longBreakDuration: Duration(milliseconds: map['longBreakDuration']),
    );
  }

  static Future<List<TaskModel>> getData() async {
    final db = await DatabaseHelper.db;
    final List<Map<String, dynamic>> maps = await db!.query('Task');
    // print(maps);
    return List.generate(maps.length, (i) {
      return mapToTaskModel(maps[i]);
    });
  }
}
