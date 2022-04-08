import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro/constants/constant.dart';
import 'package:pomodoro/util/task.dart';
import 'package:pomodoro/util/util_functions.dart';
import 'package:pomodoro/viewmodels/task_session_provider.dart';
import 'package:provider/provider.dart';

class TaskSessionScreen extends StatefulWidget {
  const TaskSessionScreen({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  State<TaskSessionScreen> createState() => _TaskSessionScreenState();
}

class _TaskSessionScreenState extends State<TaskSessionScreen> {
  bool _automaticBreak = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(color: kBgClr3),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ChangeNotifierProvider(
                create: (context) => TaskSessionProvider(task: widget.task),
                builder: (context, _) => ListView(
                  children: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Provider.of<TaskSessionProvider>(context,
                                  listen: false)
                              .stop();
                          Navigator.pop(context);
                        },
                        child: const Text('Go back'),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Task: ${widget.task.taskName}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: kTextClr,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: kBtnBgClr.withOpacity(0.8)),
                      child: SwitchListTile(
                        activeTrackColor: HSLColor.fromColor(kBgClr2)
                            .withLightness(0.55)
                            .toColor(),
                        title: const Text(
                          'Automatically start break',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        value: _automaticBreak,
                        onChanged: (newValue) {
                          setState(() {
                            _automaticBreak = newValue;
                            Provider.of<TaskSessionProvider>(context,
                                    listen: false)
                                .autoBreak = newValue;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Consumer<TaskSessionProvider>(builder: (_, tsp, __) {
                      Duration d;
                      if (tsp.timerType == TimerType.sessionTimer) {
                        d = tsp.sessionDuration;
                      } else if (tsp.timerType == TimerType.breakTimer) {
                        d = tsp.breakDuration;
                      } else {
                        d = tsp.longBreakDuration;
                      }
                      return Text(
                        '${durationHoursPart(d)}:${durationMinutesPart(d)}:${durationSecondsPart(d)}',
                        style: GoogleFonts.zcoolQingKeHuangYou(
                            color: kTextClr, fontSize: 24),
                        textAlign: TextAlign.center,
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    Consumer<TaskSessionProvider>(builder: (_, tsp, __) {
                      return Text(
                        tsp.state.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      );
                    }),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final tsp = Provider.of<TaskSessionProvider>(context,
                            listen: false);
                        if (tsp.state == TaskSessionState.completed) {
                          return;
                        }
                        if (tsp.timerType == TimerType.sessionTimer) {
                          if (tsp.state == TaskSessionState.sessionCompleted) {
                            if (tsp.sessionCompletedCount % tsp.task.lbsCount ==
                                0) {
                              tsp.runLongBreak(reset: true);
                            } else {
                              tsp.runBreak(reset: true);
                            }
                          } else {
                            tsp.runSession();
                          }
                        } else if (tsp.timerType == TimerType.breakTimer) {
                          if (tsp.state == TaskSessionState.breakCompleted) {
                            tsp.runSession(reset: true);
                          } else {
                            tsp.runBreak();
                          }
                        } else {
                          if (tsp.state ==
                              TaskSessionState.longBreakCompleted) {
                            tsp.runSession(reset: true);
                          } else {
                            tsp.runLongBreak();
                          }
                        }
                      },
                      child: const Text('Start'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<TaskSessionProvider>(context, listen: false)
                            .pause();
                      },
                      child: const Text('Pause'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Provider.of<TaskSessionProvider>(context, listen: false)
                            .stop();
                      },
                      child: const Text('Stop'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
