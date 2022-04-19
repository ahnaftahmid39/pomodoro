import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro/constants/constant.dart';
import 'package:pomodoro/screens/home_screen.dart';
import 'package:pomodoro/util/session.dart';
import 'package:pomodoro/util/sound.dart';
import 'package:pomodoro/util/util_functions.dart';
import 'package:pomodoro/viewmodels/settings_provider.dart';
import 'package:provider/provider.dart';

class SessionScreen extends StatefulWidget {
  static const routeName = '/session';

  final Session session;

  const SessionScreen({
    Key? key,
    required this.session,
  }) : super(key: key);

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  Timer? _timer;
  Duration dx = const Duration(milliseconds: kDebugMode ? 10 : 1000);
  Duration? sessionDuration;
  Duration? breakDuration;

  final Sound _sound = Sound();
  SessionState _sessionState = SessionState.initial;

  void startSessionTimer(SettingsProvider settings) {
    setState(() {
      _sessionState = SessionState.sessionRunning;
      sessionDuration = Duration(seconds: sessionDuration!.inSeconds - 1);
    });
    _timer = Timer.periodic(dx, (timer) {
      setState(() {
        if (sessionDuration!.inSeconds > 0) {
          sessionDuration = Duration(seconds: sessionDuration!.inSeconds - 1);
        } else {
          // session duration in seconds is now 0, so session completed
          if (settings.autoBreakEnabled) {
            setState(() {
              _sessionState = SessionState.breakRunning;
              startBreakTimer(settings);
            });
          } else {
            setState(() {
              _sessionState = SessionState.sessionCompleted;
            });
          }
          timer.cancel();
          if (settings.notificationEnabled) {
            _sound.playPositive();
          }
        }
      });
    });
  }

  void pauseSessionTimer(SettingsProvider settings) {
    setState(() {
      _sessionState = SessionState.sessionPaused;
    });
    _timer?.cancel();
    if (settings.notificationEnabled) {
      _sound.playBeep();
    }
  }

  void startBreakTimer(SettingsProvider settings) {
    setState(() {
      _sessionState = SessionState.breakRunning;
      breakDuration = Duration(seconds: breakDuration!.inSeconds - 1);
    });
    _timer = Timer.periodic(dx, (timer) {
      setState(() {
        if (breakDuration!.inSeconds > 0) {
          breakDuration = Duration(seconds: breakDuration!.inSeconds - 1);
        } else {
          // session duration in seconds is now 0, so session completed
          setState(() {
            _sessionState = SessionState.completed;
          });
          timer.cancel();
          if (settings.notificationEnabled) {
            _sound.playPositive();
          }
        }
      });
    });
  }

  void pauseBreakTimer(SettingsProvider settings) {
    setState(() {
      _sessionState = SessionState.breakPaused;
    });
    _timer?.cancel();
    if (settings.notificationEnabled) {
      _sound.playBeep();
    }
  }

  @override
  void initState() {
    sessionDuration = widget.session.sessionDuration;
    breakDuration = widget.session.breakDuration;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _sound.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<SettingsProvider>(context).theme == 'dark'
          ? kBgClrNoOpDark
          : kBgClrNoOp,
      body: SafeArea(
        child: Consumer<SettingsProvider>(
          builder: (context, settings, _) => ListView(
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                    child: const Text('Home'),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, HomeScreen.routeName);
                    }),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Session Length: ${widget.session.sessionMinutes} minutes,',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.displayMedium?.color,
                      fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Text(
                  'Break Length: ${widget.session.breakMinutes} minutes',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.displayMedium?.color,
                      fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: Text(
                  getTitleBasedOnState(),
                  style: TextStyle(
                      color:
                          Provider.of<SettingsProvider>(context).theme == 'dark'
                              ? kTextClrDark
                              : kTextClr,
                      fontSize: 24),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: Builder(builder: (context) {
                  Duration? d;
                  Duration fixed;
                  if (_sessionState == SessionState.sessionRunning ||
                      _sessionState == SessionState.sessionPaused ||
                      _sessionState == SessionState.initial) {
                    d = sessionDuration;
                    fixed = widget.session.sessionDuration;
                  } else {
                    d = breakDuration;
                    fixed = widget.session.breakDuration;
                  }
                  return Stack(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            backgroundColor:
                                Provider.of<SettingsProvider>(context).theme ==
                                        'dark'
                                    ? kBgClr2Dark
                                    : kBgClr2,
                            color: kBgClr4,
                            value:
                                d != null ? d.inSeconds / fixed.inSeconds : 0,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          '${durationHoursPart(d!)}:${durationMinutesPart(d)}:${durationSecondsPart(d)}',
                          style: GoogleFonts.zcoolQingKeHuangYou(
                            color:
                                Provider.of<SettingsProvider>(context).theme ==
                                        'dark'
                                    ? kTextClrDark
                                    : kTextClr,
                            fontSize: 36,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: getElevatedButtonBasedOnState(context, settings),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 3),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton getElevatedButtonBasedOnState(
      BuildContext context, SettingsProvider settings) {
    ElevatedButton tb;
    switch (_sessionState) {
      case SessionState.initial:
        tb = ElevatedButton(
          onPressed: () => startSessionTimer(settings),
          child: const Text('Start'),
        );
        break;
      case SessionState.sessionRunning:
        tb = ElevatedButton(
          child: const Text('Pause'),
          onPressed: () => pauseSessionTimer(settings),
        );
        break;
      case SessionState.sessionPaused:
        tb = ElevatedButton(
          child: const Text('Continue'),
          onPressed: () => startSessionTimer(settings),
        );
        break;
      case SessionState.sessionCompleted:
        tb = ElevatedButton(
          child: const Text('Start Break'),
          onPressed: () => startBreakTimer(settings),
        );
        break;
      case SessionState.breakRunning:
        tb = ElevatedButton(
          child: const Text('Pause'),
          onPressed: () => pauseBreakTimer(settings),
        );
        break;
      case SessionState.breakPaused:
        tb = ElevatedButton(
          child: const Text('Continue'),
          onPressed: () => startBreakTimer(settings),
        );
        break;
      case SessionState.completed:
        tb = ElevatedButton(
          child: const Text('Completed!'),
          onPressed: () {
            Navigator.pop(context);
          },
        );
        break;
      default:
        tb = ElevatedButton(
          onPressed: () {},
          child: const Text('Nothing'),
        );
    }

    return tb;
  }

  String getTitleBasedOnState() {
    String title = '';

    switch (_sessionState) {
      case SessionState.initial:
        title = 'A New Session Begins!';
        break;
      case SessionState.sessionRunning:
        title = 'Session Running';
        break;
      case SessionState.sessionPaused:
        title = 'Session Paused for now';
        break;
      case SessionState.sessionCompleted:
        title = 'Session Completed';
        break;
      case SessionState.breakRunning:
        title = 'Running Break';
        break;
      case SessionState.breakPaused:
        title = 'Break paused!';
        break;
      case SessionState.completed:
        title = 'Yay completed!';
        break;
      default:
        title = 'Bugged';
    }
    return title;
  }
}

enum SessionState {
  initial, // isSessionRunning = false && isSessionCompleted = false
  sessionRunning, // isSessionRunning = true && isSessionCompleted = false,
  sessionPaused, // isSessionRunning = false && isSessionCompleted = false,
  sessionCompleted,
  breakRunning, // isSessionCompleted = true && isBreakRunning = true,
  breakPaused, // isSessionCompleted = true && isBreakRunning = false && isBreakCompleted = false,
  completed, // isSessionCompleted = true && isBreakCompleted = true
  incomplete, // isSessionCompleted = false || isBreakCompleted = false
}
