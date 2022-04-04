// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

class CustomWidget extends StatefulWidget {
  static const routeName = '/widget-testing';
  const CustomWidget({Key? key}) : super(key: key);

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Home'),
      ),
    );
  }
}
