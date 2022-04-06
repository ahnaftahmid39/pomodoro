// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
