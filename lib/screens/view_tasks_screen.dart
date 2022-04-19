import 'package:flutter/material.dart';
import 'package:pomodoro/constants/constant.dart';
import 'package:pomodoro/models/task_model.dart';
import 'package:pomodoro/screens/task_session_screen.dart';
import 'package:pomodoro/util/util_functions.dart';
import 'package:pomodoro/viewmodels/settings_provider.dart';
import 'package:provider/provider.dart';

class ViewTasksScreen extends StatefulWidget {
  const ViewTasksScreen({Key? key}) : super(key: key);

  static String routeName = '/view-tasks';

  @override
  State<ViewTasksScreen> createState() => _ViewTasksScreenState();
}

class _ViewTasksScreenState extends State<ViewTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<SettingsProvider>(context).theme == 'dark'
          ? kBgClrNoOpDark
          : kBgClrNoOp,
      body: SafeArea(
        child: FutureBuilder(
          future: TaskModel.getData(),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<TaskModel>> snapshot,
          ) {
            List<Widget> children;

            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                children = [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color:
                          Provider.of<SettingsProvider>(context).theme == 'dark'
                              ? kBgClr2Dark
                              : kBgClr2,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Text(
                      'There are no tasks!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Provider.of<SettingsProvider>(context).theme ==
                                  'dark'
                              ? kTextClr2Dark
                              : kTextClr),
                    ),
                  )
                ];
              } else {
                children = snapshot.data!
                    .map(
                      (task) => Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 8, bottom: 8),
                        child: Card(
                          borderOnForeground: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            tileColor:
                                Provider.of<SettingsProvider>(context).theme ==
                                        'dark'
                                    ? kBgClr2Dark
                                    : kBgClr4,
                            title: Text(
                              task.name,
                              style: TextStyle(
                                  color: Provider.of<SettingsProvider>(context)
                                              .theme ==
                                          'dark'
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('TaskId: ${task.taskID.toString()}'),
                                      Text(task.sessionCompletedCount ==
                                              task.sessionCount
                                          ? 'Completed'
                                          : 'Not completed'),
                                      if (task.startingTime != null) ...[
                                        Text(
                                          onlyDateFromDateTime(
                                              task.startingTime!),
                                        ),
                                        Text(
                                          onlyTimeFromDateTime(
                                              task.startingTime!),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      if (task.sessionCompletedCount !=
                                          task.sessionCount)
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TaskSessionScreen(
                                                  task: task.task,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.play_arrow,
                                            color:
                                                Provider.of<SettingsProvider>(
                                                                context)
                                                            .theme ==
                                                        'dark'
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        ),
                                      const SizedBox(
                                        width: 15,
                                        height: 15,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          TaskModel.deleteById(task.taskID!);
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Provider.of<SettingsProvider>(
                                                          context)
                                                      .theme ==
                                                  'dark'
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList()
                    .reversed
                    .toList();
              }
            } else {
              children = [
                const Center(child: CircularProgressIndicator()),
              ];
            }
            return ListView(
              children: children,
            );
          },
        ),
      ),
    );
  }
}
