import 'package:flutter/material.dart';
import 'package:pomodoro/constants/constant.dart';
import 'package:pomodoro/viewmodels/settings_provider.dart';
import 'package:provider/provider.dart';

class StringInputField extends StatelessWidget {
  const StringInputField({
    Key? key,
    this.helperText,
    required this.controller,
  }) : super(key: key);

  final String? helperText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (helperText != null && helperText != '')
          Container(
            padding: const EdgeInsets.only(left: 12.0, bottom: 4.0),
            child: Text(
              '$helperText',
              style:  TextStyle(
                  color: Provider.of<SettingsProvider>(context).theme == 'dark'
                      ? kTextClr2Dark
                      : kTextClr2,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: Provider.of<SettingsProvider>(context).theme == 'dark'
                  ? kBgClr2Dark
                  : kBgClr2),
          child: TextField(
            controller: controller,
            autofocus: true,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16.0),
            ),
          ),
        ),
      ],
    );
  }
}
