import 'package:flutter/material.dart';
import 'package:pomodoro/constants/constant.dart';
import 'package:pomodoro/models/task.dart';
import 'package:pomodoro/screens/task_session_screen.dart';
import 'package:pomodoro/util/util_functions.dart';

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
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: kBgClr,
            ),
            FutureBuilder(
              future: TaskModel.getData(),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<TaskModel>> snapshot,
              ) {
                List<Widget> children;

                if (snapshot.hasData) {
                  children = snapshot.data!
                      .map(
                        (task) => Card(
                          borderOnForeground: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            tileColor: kBgClr4,
                            title: Text(
                              task.name,
                              style: const TextStyle(
                                  color: Colors.black,
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
                                          icon: const Icon(
                                            Icons.play_arrow,
                                            color: Colors.black,
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
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList()
                      .reversed
                      .toList();
                } else {
                  children = [
                    const Center(child: CircularProgressIndicator()),
                  ];
                }
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: children,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
