import 'package:flutter/material.dart';
import 'package:pomodoro/components/custom_widget_test.dart';
import 'package:pomodoro/screens/home_screen.dart';
import 'package:pomodoro/screens/new_session_screen.dart';
import 'package:pomodoro/screens/new_task_screen.dart';
import 'package:pomodoro/screens/session_screen.dart';
import 'package:pomodoro/util/material_color_maker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double getElevation(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return 8.0;
      }
      return 4.0;
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: getMaterialcolor(const Color(0xFFE47769)),
        textTheme: const TextTheme(
          bodySmall: TextStyle(
            color: Color(0xFF7C0000),
            fontSize: 12.0,
          ),
          displayMedium: TextStyle(
            color: Color.fromARGB(255, 139, 9, 9),
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Colors.white,
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFE47769),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            alignment: Alignment.center,
            textStyle:
                MaterialStateProperty.all(const TextStyle(fontSize: 16.0)),
            backgroundColor: MaterialStateProperty.all(const Color(0xFFE47769)),
            padding: MaterialStateProperty.all(
                const EdgeInsets.fromLTRB(16, 16, 16, 16)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
            ),
            elevation: MaterialStateProperty.resolveWith(getElevation),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(title: 'Home'),
        NewSessionScreen.routeName: (context) => const NewSessionScreen(),
        '/new-task': (context) => const NewTaskScreen(),
        CustomWidget.routeName: ((context) => const CustomWidget()),
        SessionScreen.routeName: (context) => const SessionScreen(),
      },
    );
  }
}
