import 'package:flutter/material.dart';
import 'package:pomodoro/components/change_time_card.dart';
import 'package:pomodoro/components/number_input_field.dart';
import 'package:pomodoro/components/string_input_field.dart';
import 'package:pomodoro/screens/task_session_screen.dart';
import 'package:pomodoro/viewmodels/task_settings.dart';
import 'package:provider/provider.dart';

class NewTaskScreen extends StatefulWidget {
  static const routeName = '/new-task';
  const NewTaskScreen({Key? key}) : super(key: key);

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _sessionCountController = TextEditingController();
  final TextEditingController _longBreakAfterSessionCountController =
      TextEditingController();

  @override
  void initState() {
    _taskNameController.text = 'Study';
    _sessionCountController.text = '5';
    _longBreakAfterSessionCountController.text = '2';
    super.initState();
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _sessionCountController.dispose();
    _longBreakAfterSessionCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(color: const Color.fromRGBO(224, 95, 82, 0.6)),
            ChangeNotifierProvider(
              create: (_) => TaskSettings(),
              builder: (context, _) => ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        StringInputField(
                          controller: _taskNameController,
                          helperText: 'Task Name',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        NumberInputField(
                          controller: _sessionCountController,
                          helperText: 'Number of sessions',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        NumberInputField(
                          controller: _longBreakAfterSessionCountController,
                          helperText: 'Long break after this many sessions:',
                        ),
                      ],
                    ),
                  ),
                  ChangeTimeCard(
                    onChange: (duration) {
                      Provider.of<TaskSettings>(context, listen: false)
                          .sessionDuration = duration;
                    },
                    cardTitle: 'Each session length',
                  ),
                  const SizedBox(height: 16.0),
                  ChangeTimeCard(
                    onChange: (duration) {
                      Provider.of<TaskSettings>(context, listen: false)
                          .breakDuration = duration;
                    },
                    cardTitle: 'Small Break length',
                    defaultDuration: const Duration(minutes: 5),
                  ),
                  const SizedBox(height: 16.0),
                  ChangeTimeCard(
                    onChange: (duration) {
                      Provider.of<TaskSettings>(context, listen: false)
                          .longBreakDuration = duration;
                    },
                    cardTitle: 'Long Break length',
                    defaultDuration: const Duration(minutes: 15),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(18.0)),
                        ),
                        onPressed: () async {
                          final taskSettings =
                              Provider.of<TaskSettings>(context, listen: false);
                          taskSettings.taskName = _taskNameController.text;
                          taskSettings.sessionCount =
                              int.parse(_sessionCountController.text);
                          taskSettings.lbsCount = int.parse(
                              _longBreakAfterSessionCountController.text);
                          await taskSettings.saveTask();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TaskSessionScreen(task: taskSettings.task),
                            ),
                          );
                        },
                        child: const Text('Save!'),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            textStyle: MaterialStateProperty.all(
                              const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(18.0)),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Go Home'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
