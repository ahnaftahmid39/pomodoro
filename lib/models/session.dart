
class Session {
  final int sessionID;
  final int taskID;
  final int duration;
  final int breakTime;

  const Session({
   required this.sessionID,
   required this.taskID,
   required this.duration,
   required this.breakTime
});

  Map<String, dynamic> toMap () {
    return {
      'sessionID' : sessionID,
      'taskID' : taskID,
      'duration' : duration,
      'breakTime' : breakTime,
    };
  }
}