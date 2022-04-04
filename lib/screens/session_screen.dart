import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pomodoro/constants/constant.dart';
import 'package:pomodoro/screens/home_screen.dart';

class Session {
  const Session({
    this.sessionHours = '00',
    this.sessionMinutes = '25',
    this.breakHours = '00',
    this.breakMinutes = '05',
  });
  final String sessionHours;
  final String sessionMinutes;
  final String breakHours;
  final String breakMinutes;

  @override
  String toString() {
    return 'Session Hours: $sessionHours, Session Minutes: $sessionMinutes\nBreak Hours: $breakHours, Break Minutes: $breakMinutes';
  }
}

class SessionScreen extends StatefulWidget {
  static const routeName = '/session';

  final Session session;

  const SessionScreen({Key? key, this.session = const Session()})
      : super(key: key);

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  Timer? _timer;
  Duration dx = const Duration(seconds: 1);
  Duration? sessionDuration;
  Duration? breakDuration;

  bool _isSessionRunning = false;
  bool _isSessionCompleted = false;

  bool _isbreakRunning = false;
  bool _isbreakCompleted = false;

  String intToStringWithPadding(int a) => a.toString().padLeft(2, '0');

  void startSessionTimer() {
    setState(() {
      _isSessionRunning = true;
    });

    _timer = Timer.periodic(dx, (timer) {
      setState(() {
        if (sessionDuration!.inSeconds > 0) {
          sessionDuration = Duration(seconds: sessionDuration!.inSeconds - 1);
        } else {
          setState(() {
            _isSessionCompleted = true;
            _isSessionRunning = false;
          });
          timer.cancel();
        }
      });
    });
  }

  void stopSessionTimer() {
    setState(() {
      _isSessionRunning = false;
    });
    _timer?.cancel();
  }

  @override
  void initState() {
    sessionDuration = Duration(
      hours: int.parse(widget.session.sessionHours),
      minutes: int.parse(widget.session.sessionMinutes),
    );
    breakDuration = Duration(
      hours: int.parse(widget.session.breakHours),
      minutes: int.parse(widget.session.breakMinutes),
    );
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
      body: Stack(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 50),
            child: Image.asset(
              'assets/images/tomato.png',
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: const Color.fromRGBO(224, 95, 82, 0.6)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                    child: const Text('Home'),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, HomeScreen.routeName);
                    }),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Session Length: ${widget.session.sessionMinutes} minutes,',
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Text(
                  'Break Length: ${widget.session.breakMinutes} minutes,',
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                    '${intToStringWithPadding(sessionDuration!.inHours.remainder(60))}:${intToStringWithPadding(sessionDuration!.inMinutes.remainder(60))}:${intToStringWithPadding(sessionDuration!.inSeconds.remainder(60))}'),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                    child: !_isSessionRunning || _isSessionCompleted
                        ? const Text('Start')
                        : const Text('Stop'),
                    onPressed: () {
                      if (kDebugMode) {
                        print('is running: $_isSessionRunning, is completed: $_isbreakCompleted');
                      }
                      if (!_isSessionRunning) {
                        if (_isSessionCompleted) {
                          // start break timer, but for now just restart the timer
                          setState(() {
                            _isSessionCompleted = false;
                            sessionDuration = const Duration(
                              // hours: int.parse(widget.session.sessionHours),
                              // minutes: int.parse(widget.session.sessionMinutes),
                              seconds: 2,
                            );
                          });
                        }
                        startSessionTimer();
                      } else {
                        stopSessionTimer();
                      }
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
