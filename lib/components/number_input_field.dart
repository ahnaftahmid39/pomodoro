import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro/constants/constant.dart';

class NumberInputField extends StatelessWidget {
  const NumberInputField({Key? key, this.helperText, required this.controller})
      : super(key: key);

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
              style: const TextStyle(
                  color: kTextClr, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0), color: kBgClr2),
                child: TextField(
                  controller: controller,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  textAlign: TextAlign.center,
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
            ),
            const SizedBox(
              width: 8.0,
            ),
            Row(
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                      const Size(16, 56),
                    ),
                  ),
                  onPressed: () {
                    int cur = 0;
                    if (controller.text != '') {
                      cur = int.parse(controller.text);
                    }
                    int next = cur + 1;
                    controller.value =
                        controller.value.copyWith(text: next.toString());
                  },
                  child: const Icon(Icons.keyboard_arrow_up),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(16, 56)),
                  ),
                  onPressed: () {
                    int cur = 0;
                    if (controller.text != '') {
                      cur = int.parse(controller.text);
                    }
                    int next = cur - 1;
                    if (next < 1) next = 1;
                    controller.value =
                        controller.value.copyWith(text: next.toString());
                  },
                  child: const Icon(Icons.keyboard_arrow_down),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
