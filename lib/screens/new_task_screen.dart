import 'package:flutter/material.dart';
import 'package:pomodoro/components/change_time_button.dart';

class NewTaskScreen extends StatefulWidget {
  static const routeName = '/new-task';
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeTimeButton(
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
        type: ChangeTimeButtonType.up,
      ),
    );
  }
}
