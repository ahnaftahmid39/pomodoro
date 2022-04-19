import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pomodoro/components/custom_widget_test.dart';
import 'package:pomodoro/components/navigator_card.dart';
import 'package:pomodoro/constants/constant.dart';
import 'package:pomodoro/screens/new_session_screen.dart';
import 'package:pomodoro/screens/new_task_screen.dart';
import 'package:pomodoro/screens/settings_screen.dart';
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
      backgroundColor: Provider.of<SettingsProvider>(context).theme == 'dark'
          ? kBgClrNoOpDark
          : kBgClrNoOp,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 50),
              child: Image.asset(
                Provider.of<SettingsProvider>(context).theme == 'dark'
                    ? 'assets/images/tomato_dark.png'
                    : 'assets/images/tomato.png',
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(color: Colors.transparent),
            ),
            ListView(
              children: <Widget>[
                NavigatorCard(
                  icon: Icons.timelapse,
                  onPress: () {
                    Navigator.pushNamed(context, NewSessionScreen.routeName);
                  },
                  title: 'Quick session',
                  subtitle:
                      'Start a quick new session without any hastle of configuration',
                ),
                NavigatorCard(
                  icon: Icons.task,
                  onPress: () {
                    Navigator.pushNamed(context, NewTaskScreen.routeName);
                  },
                  title: 'New Task',
                  subtitle: 'Start a new task by defining your choices',
                ),
                NavigatorCard(
                  icon: Icons.history,
                  onPress: () {
                    Navigator.pushNamed(context, ViewTasksScreen.routeName);
                  },
                  title: 'View Tasks',
                  subtitle:
                      'View a history of your tasks. You can continue to do any task from here.',
                ),
                NavigatorCard(
                  icon: Icons.settings,
                  onPress: () {
                    Navigator.pushNamed(context, SettingsScreen.routeName);
                  },
                  title: 'Settings',
                  subtitle: 'Configure your preferences here',
                ),
                NavigatorCard(
                  icon: Icons.smart_toy_outlined,
                  onPress: () {
                    Navigator.pushNamed(context, CustomWidget.routeName);
                  },
                  title: 'Widget Test',
                  subtitle: 'Testing some widgets (Dev only)',
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 3),
              ],
            )
          ],
        ),
      ),
    );
  }
}
