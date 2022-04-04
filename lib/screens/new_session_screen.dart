import 'package:flutter/material.dart';
import 'package:pomodoro/components/change_time_card.dart';
import 'package:pomodoro/screens/session_screen.dart';

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
            Container(color: const Color.fromRGBO(224, 95, 82, 0.6)),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Home'),
                  ),
                  // ignore: prefer_const_constructors
                  ChangeTimeCard(
                    cardTitle: 'Session Duration',
                    initialMinuteDuration: '25',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // ignore: prefer_const_constructors
                  ChangeTimeCard(
                    cardTitle: 'Break Duration',
                    initialMinuteDuration: '05',
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                      onPressed: () {
                        // connect with the view model
                        // for now just go to new session page with these parameters,
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SessionScreen(
                              session: Session(
                                sessionMinutes: '10',
                                breakMinutes: '02',
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Text('Start'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
