import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pomodoro/constants/constant.dart';
import 'package:pomodoro/screens/view_tasks_screen.dart';
import 'package:pomodoro/viewmodels/settings_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 50),
              child: Image.asset(
                'assets/images/tomato.png',
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                  color: Provider.of<SettingsProvider>(context).theme == 'dark'
                      ? kBgClrNoOpDark
                      : kBgClr),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      child: const Text('New Session'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/new-session');
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      child: const Text('New Task'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/new-task');
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      child: const Text('History'),
                      onPressed: () {
                        Navigator.pushNamed(context, ViewTasksScreen.routeName);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      child: const Text('Settings'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/settings');
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      child: const Text('WidgetTesting'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/widget-testing');
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 3),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
