import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/components/custom_widget_test.dart';
import 'package:pomodoro/constants/constant.dart';
import 'package:pomodoro/screens/home_screen.dart';
import 'package:pomodoro/screens/new_session_screen.dart';
import 'package:pomodoro/screens/new_task_screen.dart';
import 'package:pomodoro/screens/session_screen.dart';
import 'package:pomodoro/screens/settings_screen.dart';
import 'package:pomodoro/screens/view_tasks_screen.dart';
import 'package:pomodoro/util/material_color_maker.dart';
import 'package:pomodoro/util/session.dart';
import 'package:pomodoro/viewmodels/settings_provider.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = SettingsProvider();
  await settings.loadSettings();
  runApp(
    MyApp(
      settings: settings,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.settings}) : super(key: key);

  final SettingsProvider settings;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => settings,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: getMaterialcolor(
              Provider.of<SettingsProvider>(context).theme == 'dark'
                  ? kBgClr2Dark
                  : kBgClr2),
          textTheme: TextTheme(
            bodySmall: TextStyle(
              color: Provider.of<SettingsProvider>(context).theme == 'dark'
                  ? kTextClrDark
                  : kTextClr,
              fontSize: 12.0,
            ),
            displayMedium: TextStyle(
              color: Provider.of<SettingsProvider>(context).theme == 'dark'
                  ? kTextClr2Dark
                  : kTextClr2,
              fontSize: 20.0,
            ),
          ),
          backgroundColor: Colors.white,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Provider.of<SettingsProvider>(context).theme == 'dark'
                ? kTextClrDark
                : kTextClr.withOpacity(0.9),
            selectionHandleColor:
                Provider.of<SettingsProvider>(context).theme == 'dark'
                    ? kTextClrDark
                    : kTextClr.withOpacity(0.7),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFE47769),
          ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              textStyle:
                  MaterialStateProperty.all(const TextStyle(color: kTextClr)),
              backgroundColor: MaterialStateProperty.all(kBgClr4),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              enableFeedback: false,
              backgroundColor: MaterialStateProperty.all(
                  Provider.of<SettingsProvider>(context).theme == 'dark'
                      ? kBtnBgClrDark
                      : kBtnBgClr),
              textStyle:
                  MaterialStateProperty.all(const TextStyle(fontSize: 16)),
              overlayColor:
                  MaterialStateProperty.all(Colors.white.withOpacity(0.2)),
              padding: MaterialStateProperty.all(
                defaultTargetPlatform == TargetPlatform.linux ||
                        defaultTargetPlatform == TargetPlatform.windows
                    ? const EdgeInsets.fromLTRB(16, 20, 16, 20)
                    : const EdgeInsets.fromLTRB(16, 12, 16, 12),
              ),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
              ),
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(title: 'Home'),
          NewSessionScreen.routeName: (context) => const NewSessionScreen(),
          '/new-task': (context) => const NewTaskScreen(),
          CustomWidget.routeName: ((context) => const CustomWidget()),
          SessionScreen.routeName: (context) => SessionScreen(
                session: Session(),
              ),
          ViewTasksScreen.routeName: (context) => const ViewTasksScreen(),
          SettingsScreen.routeName: (context) => const SettingsScreen(),
        },
      ),
    );
  }
}
