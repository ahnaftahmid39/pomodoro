import 'package:flutter/material.dart';
import 'package:pomodoro/components/change_time_card.dart';
import 'package:pomodoro/constants/constant.dart';
import 'package:pomodoro/screens/session_screen.dart';
import 'package:pomodoro/util/session.dart';
import 'package:pomodoro/viewmodels/session_settings.dart';
import 'package:pomodoro/viewmodels/settings_provider.dart';
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
      backgroundColor: Provider.of<SettingsProvider>(context).theme == 'dark'
          ? kBgClrNoOpDark
          : kBgClrNoOp,
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (_) => SessionSettings(),
          builder: (context, _) {
            return ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                ChangeTimeCard(
                  cardTitle: 'Session Duration',
                  defaultDuration: const Duration(minutes: 25),
                  onChange: (Duration duration) {
                    final sessionSettings =
                        Provider.of<SessionSettings>(context, listen: false);
                    sessionSettings.sessionDuration = duration;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // ignore: prefer_const_constructors
                ChangeTimeCard(
                  cardTitle: 'Break Duration',
                  defaultDuration: const Duration(minutes: 5),
                  onChange: (Duration duration) {
                    final sessionSettings =
                        Provider.of<SessionSettings>(context, listen: false);
                    sessionSettings.breakDuration = duration;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Session session =
                            Provider.of<SessionSettings>(context, listen: false)
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
                    const SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Go Home'),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 3),
              ],
            );
          },
        ),
      ),
    );
  }
}
