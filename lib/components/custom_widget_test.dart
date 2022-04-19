// ignore_for_file: avoid_unnecessary_containers
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pomodoro/components/navigator_card.dart';
import 'package:pomodoro/constants/constant.dart';
import 'package:pomodoro/screens/new_session_screen.dart';
import 'package:pomodoro/viewmodels/settings_provider.dart';
import 'package:provider/provider.dart';

class CustomWidget extends StatefulWidget {
  static const routeName = '/widget-testing';
  const CustomWidget({Key? key}) : super(key: key);

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.value = _controller.value.copyWith(
      text: '1',
      selection: const TextSelection(baseOffset: 1, extentOffset: 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = Provider.of<SettingsProvider>(context).theme == 'dark'
        ? kBgClrNoOpDark
        : kBgClrNoOp;
    // final bgColor2 = Provider.of<SettingsProvider>(context).theme == 'dark'
    //     ? kBgClr2Dark
    //     : kBgClr2;
    // final textColor = Provider.of<SettingsProvider>(context).theme == 'dark'
    //     ? kTextClrDark
    //     : kTextClr;
    // final textColor2 = Provider.of<SettingsProvider>(context).theme == 'dark'
    //     ? kTextClr2Dark
    //     : kTextClr2;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              NavigatorCard(
                icon: Icons.timelapse,
                onPress: () {
                  Navigator.pushNamed(context, NewSessionScreen.routeName);
                },
                title: 'Quick Session',
                subtitle:
                    'Start a new session without any hastle of configuring',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
