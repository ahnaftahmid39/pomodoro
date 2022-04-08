import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro/constants/constant.dart';
import 'package:pomodoro/screens/home_screen.dart';
import 'package:pomodoro/util/session.dart';
import 'package:pomodoro/util/util_functions.dart';

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
  Duration dx = const Duration(milliseconds: 10);
  Duration? sessionDuration;
  Duration? breakDuration;

  SessionState _sessionState = SessionState.initial;

  void startSessionTimer() {
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
          setState(() {
            timer.cancel();
            _sessionState = SessionState.breakRunning;
            startBreakTimer();
          });
        }
      });
    });
  }

  void pauseSessionTimer() {
    setState(() {
      _sessionState = SessionState.sessionPaused;
    });
    _timer?.cancel();
  }

  void startBreakTimer() {
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
        }
      });
    });
  }

  void pauseBreakTimer() {
    setState(() {
      _sessionState = SessionState.breakPaused;
    });
    _timer?.cancel();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 50),
              child: Image.asset('assets/images/tomato.png'),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: const Color.fromRGBO(224, 95, 82, 0.6)),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                        child: const Text('Home'),
                        onPressed: () {
                          Navigator.popAndPushNamed(
                              context, HomeScreen.routeName);
                        }),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Session Length: ${widget.session.sessionMinutes} minutes,',
                      style: TextStyle(
                          color:
                              Theme.of(context).textTheme.displayMedium?.color,
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
                          color:
                              Theme.of(context).textTheme.displayMedium?.color,
                          fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: Text(
                      getTitleBasedOnState(),
                      style: const TextStyle(color: kTextClr, fontSize: 24),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: _sessionState == SessionState.sessionRunning ||
                            _sessionState == SessionState.sessionPaused ||
                            _sessionState == SessionState.initial
                        ? Text(
                            '${durationHoursPart(sessionDuration!)}:${durationMinutesPart(sessionDuration!)}:${durationSecondsPart(sessionDuration!)}',
                            style: GoogleFonts.newRocker(
                              color: kTextClr,
                              fontSize: 36,
                            ),
                          )
                        : Text(
                            '${durationHoursPart(breakDuration!)}:${durationMinutesPart(breakDuration!)}:${durationSecondsPart(breakDuration!)}',
                            style: GoogleFonts.newRocker(
                              color: kTextClr,
                              fontSize: 36,
                            ),
                          ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: getElevatedButtonBasedOnState(context),
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

  ElevatedButton getElevatedButtonBasedOnState(BuildContext context) {
    ElevatedButton tb;
    switch (_sessionState) {
      case SessionState.initial:
        tb = ElevatedButton(
          onPressed: startSessionTimer,
          child: const Text('Start'),
        );
        break;
      case SessionState.sessionRunning:
        tb = ElevatedButton(
          child: const Text('Pause'),
          onPressed: pauseSessionTimer,
        );
        break;
      case SessionState.sessionPaused:
        tb = ElevatedButton(
          child: const Text('Continue'),
          onPressed: startSessionTimer,
        );
        break;
      case SessionState.breakRunning:
        tb = ElevatedButton(
          child: const Text('Pause'),
          onPressed: pauseBreakTimer,
        );
        break;
      case SessionState.breakPaused:
        tb = ElevatedButton(
          child: const Text('Continue'),
          onPressed: startBreakTimer,
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
  breakRunning, // isSessionCompleted = true && isBreakRunning = true,
  breakPaused, // isSessionCompleted = true && isBreakRunning = false && isBreakCompleted = false,
  completed, // isSessionCompleted = true && isBreakCompleted = true
  incomplete, // isSessionCompleted = false || isBreakCompleted = false
}
