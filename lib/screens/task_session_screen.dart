import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro/constants/constant.dart';
import 'package:pomodoro/util/task.dart';
import 'package:pomodoro/util/util_functions.dart';
import 'package:pomodoro/viewmodels/settings_provider.dart';
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
            Container(
              color: Provider.of<SettingsProvider>(context).theme == 'dark'
                  ? kBgClrNoOpDark
                  : kBgClrNoOp,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<SettingsProvider>(
                builder: (context, settings, _) => ChangeNotifierProvider(
                  create: (context) => TaskSessionProvider(
                      task: widget.task, settings: settings),
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
                        style: TextStyle(
                          color: Provider.of<SettingsProvider>(context).theme ==
                                  'dark'
                              ? kTextClrDark
                              : kTextClr,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color:
                                Provider.of<SettingsProvider>(context).theme ==
                                        'dark'
                                    ? kBtnBgClrDark
                                    : kBtnBgClr.withOpacity(0.8)),
                        child: SwitchListTile(
                          activeTrackColor: HSLColor.fromColor(
                                  Provider.of<SettingsProvider>(context)
                                              .theme ==
                                          'dark'
                                      ? kBgClr2Dark
                                      : kBgClr2)
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
                        Duration fixed;
                        if (tsp.timerType == TimerType.sessionTimer) {
                          d = tsp.sessionDuration;
                          fixed = tsp.task.sessionDuration;
                        } else if (tsp.timerType == TimerType.breakTimer) {
                          d = tsp.breakDuration;
                          fixed = tsp.task.breakDuration;
                        } else {
                          d = tsp.longBreakDuration;
                          fixed = tsp.task.longBreakDuration;
                        }
                        return Column(
                          children: [
                            Text(
                              'Session completed: ${tsp.sessionCompletedCount}/${tsp.task.sessionCount}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Provider.of<SettingsProvider>(context)
                                            .theme ==
                                        'dark'
                                    ? kTextClrDark
                                    : kTextClr,
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            SizedBox(
                              width: 200,
                              height: 200,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: 200,
                                    height: 200,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      backgroundColor: kBgClr2,
                                      color: kBgClr4,
                                      value: d.inSeconds / fixed.inSeconds,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      '${durationHoursPart(d)}:${durationMinutesPart(d)}:${durationSecondsPart(d)}',
                                      style: GoogleFonts.zcoolQingKeHuangYou(
                                          color: Provider.of<SettingsProvider>(
                                                          context)
                                                      .theme ==
                                                  'dark'
                                              ? kTextClrDark
                                              : kTextClr,
                                          fontSize: 36),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                      const SizedBox(
                        height: 24,
                      ),
                      Consumer<TaskSessionProvider>(builder: (_, tsp, __) {
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color:
                                Provider.of<SettingsProvider>(context).theme ==
                                        'dark'
                                    ? kBgClr2Dark
                                    : kBgClr4,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            stateToDisplay[tsp.state]!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Provider.of<SettingsProvider>(context)
                                          .theme ==
                                      'dark'
                                  ? kTextClrDark
                                  : kTextClr,
                            ),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      Consumer<TaskSessionProvider>(
                        builder: (_, tsp, __) {
                          String btnTitle = '';
                          bool canPause = false;
                          if (tsp.state == TaskSessionState.initial ||
                              tsp.state == TaskSessionState.breakCompleted ||
                              tsp.state ==
                                  TaskSessionState.longBreakCompleted) {
                            btnTitle = 'Start Session';
                            canPause = false;
                          } else if (tsp.state ==
                                  TaskSessionState.sessionRunning ||
                              tsp.state == TaskSessionState.breakRunning ||
                              tsp.state == TaskSessionState.longBreakRunning) {
                            canPause = true;
                            btnTitle = 'Pause';
                          } else if (tsp.state ==
                                  TaskSessionState.sessionPaused ||
                              tsp.state == TaskSessionState.breakPaused ||
                              tsp.state == TaskSessionState.longBreakPaused) {
                            canPause = false;
                            btnTitle = 'Continue';
                          } else if (tsp.state ==
                              TaskSessionState.sessionCompleted) {
                            if (tsp.sessionCompletedCount % tsp.task.lbsCount ==
                                0) {
                              btnTitle = 'Start Long break';
                            } else {
                              btnTitle = 'Start Break';
                            }
                            canPause = false;
                          } else {
                            btnTitle = '';
                          }
                          if (btnTitle == '') return const Center();
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (canPause) {
                                    tsp.pause();
                                  } else {
                                    tsp.handleOnStart();
                                  }
                                },
                                child: Text(btnTitle),
                              ),
                              const SizedBox(
                                height: 16,
                                width: 16,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  tsp.stopIncomplete();
                                },
                                child: const Text('Stop'),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<TaskSessionState, String> stateToDisplay = {
    TaskSessionState.initial: 'A new task begins!',
    TaskSessionState.sessionRunning: 'Running Session',
    TaskSessionState.sessionCompleted: 'Completed Session',
    TaskSessionState.breakRunning: 'Running Break',
    TaskSessionState.breakCompleted: 'Completed Break',
    TaskSessionState.longBreakRunning: 'Taking a long break!',
    TaskSessionState.longBreakCompleted: 'Long break completed',
    TaskSessionState.sessionPaused: 'Session paused for now',
    TaskSessionState.breakPaused: 'Break paused!',
    TaskSessionState.longBreakPaused: 'Long break paused!',
    TaskSessionState.completed: 'Completed yay!',
    TaskSessionState.incomplete: 'Didn\'t finished :(',
  };
}
