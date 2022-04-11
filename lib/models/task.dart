
class Task {
  final int taskID;
  final String name;
  final int count;
  final bool isFinished;
  final DateTime startingTime;
  final DateTime finishingTime;

  const Task({
   required this.taskID,
   required this.name,
   required this.count,
   required this.isFinished,
   required this.startingTime,
   required this.finishingTime
});
}