import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pomodoro/components/change_time_card.dart';
import 'package:pomodoro/screens/session_screen.dart';
import 'package:pomodoro/util/session.dart';
import 'package:pomodoro/viewmodels/session_settings.dart';
import 'package:provider/provider.dart';

class NewSessionScreen extends StatefulWidget {
  static const routeName = '/new-session';

  const NewSessionScreen({Key? key}) : super(key: key);

  @override
  State<NewSessionScreen> createState() => _NewSessionScreenState();
}

class _NewSessionScreenState extends State<NewSessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: const Color.fromRGBO(224, 95, 82, 0.6)),
            ),
            Container(
              alignment: Alignment.center,
              child: ChangeNotifierProvider(
                create: (_) => SessionSettings(),
                builder: (context, _) => SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('<  Home'),
                      ),
                      ChangeTimeCard(
                          cardTitle: 'Session Duration',
                          defaultDuration: const Duration(minutes: 25),
                          onChange: (Duration duration) {
                            final sessionSettings =
                                Provider.of<SessionSettings>(context,
                                    listen: false);
                            sessionSettings.sessionDuration = duration;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      // ignore: prefer_const_constructors
                      ChangeTimeCard(
                        cardTitle: 'Break Duration',
                        defaultDuration: const Duration(minutes: 5),
                        onChange: (Duration duration) {
                          final sessionSettings = Provider.of<SessionSettings>(
                              context,
                              listen: false);
                          sessionSettings.breakDuration = duration;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Session session = Provider.of<SessionSettings>(
                                  context,
                                  listen: false)
                              .session;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SessionScreen(
                                session: session,
                              ),
                            ),
                          );
                        },
                        child: const Text('Start'),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 3),
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
}
