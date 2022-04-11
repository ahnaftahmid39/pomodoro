class UserProfile {
  final int userID;
  final String theme;
  final String alarmTone;
  final bool notificationEnabled;

  const UserProfile({
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
      'notifEnabled': notificationEnabled,
    };
  }
}
