import 'package:flutter/material.dart';

enum ChangeTimeButtonType { up, down }

class ChangeTimeButton extends StatelessWidget {
  const ChangeTimeButton({
    Key? key,
    required this.onPressed,
    required this.type,
  }) : super(key: key);

  final VoidCallback onPressed;
  final ChangeTimeButtonType type;

  @override
  Widget build(BuildContext context) {
    const clr = Color(0xFFFFD6D6);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.white,
        borderRadius: BorderRadius.circular(300),
        child: Ink(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(300), color: clr),
          child: type == ChangeTimeButtonType.up
              ? const Icon(
                  Icons.keyboard_arrow_up,
                  size: 18.0,
                )
              : const Icon(Icons.keyboard_arrow_down, size: 18.0),
        ),
      ),
    );
  }
}
