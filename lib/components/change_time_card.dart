import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro/components/change_time_button.dart';
import 'package:pomodoro/constants/constant.dart';
import 'package:pomodoro/util/util_functions.dart';

typedef ChangeTimeCallback = void Function(Duration);

class ChangeTimeCard extends StatefulWidget {
  const ChangeTimeCard({
    Key? key,
    this.cardTitle = 'Card Name',
    this.defaultDuration = const Duration(hours: 0, minutes: 25),
    required this.onChange,
  }) : super(key: key);

  final String cardTitle;
  final ChangeTimeCallback onChange;
  final Duration defaultDuration;
  @override
  State<ChangeTimeCard> createState() => _ChangeTimeCardState();
}

class _ChangeTimeCardState extends State<ChangeTimeCard> {
  final _hcontrol = TextEditingController();
  final _mcontrol = TextEditingController();

  void handleHourOnChange() {
    if (_hcontrol.text == '') return;

    int curNumber = int.parse(_hcontrol.text);
    int nxtNumber = curNumber;

    if (curNumber > 23) {
      nxtNumber = 23;
    }
    if (curNumber < 0) {
      nxtNumber = 0;
    }

    String nxt = intToStringWithPadding(nxtNumber);
    if (curNumber != nxtNumber) {
      _hcontrol.value = _hcontrol.value.copyWith(
        text: nxt,
        selection: const TextSelection(baseOffset: 2, extentOffset: 2),
        composing: TextRange.empty,
      );
    }
    widget.onChange(Duration(
        minutes: nxtNumber * 60 +
            int.parse(_mcontrol.text == '' ? '0' : _mcontrol.text)));
  }

  void handleMinuteOnChange() {
    if (_mcontrol.text == '') return;
    int curNumber = int.parse(_mcontrol.text);
    int nxtNumber = curNumber;

    if (curNumber > 59) {
      nxtNumber = 59;
    }
    if (curNumber < 0) {
      nxtNumber = 0;
    }

    if (curNumber != nxtNumber) {
      String nxt = intToStringWithPadding(nxtNumber);
      _mcontrol.value = _mcontrol.value.copyWith(
        text: nxt,
        selection: const TextSelection(baseOffset: 2, extentOffset: 2),
        composing: TextRange.empty,
      );
    }
    widget.onChange(Duration(
        minutes: int.parse(_hcontrol.text == '' ? '0' : _hcontrol.text) * 60 +
            nxtNumber));
  }

  void handleHourIncrement() {
    String cur = _hcontrol.value.text;
    cur = cur != '' ? cur : '00';
    String nxt = '0';
    int nextInt = int.parse(cur) + 1;
    if (nextInt < 10) {
      nxt += nextInt.toString();
    } else {
      nxt = nextInt.toString();
    }
    _hcontrol.value = _hcontrol.value.copyWith(
      text: nxt,
      selection: const TextSelection(baseOffset: 2, extentOffset: 2),
      composing: TextRange.empty,
    );
  }

  void handleMinuteIncrement() {
    String cur = _mcontrol.text;
    cur = cur != '' ? cur : '00';
    String nxt = '0';
    int nextInt = int.parse(cur) + 1;
    if (nextInt < 10) {
      nxt += nextInt.toString();
    } else {
      nxt = nextInt.toString();
    }
    _mcontrol.value = _mcontrol.value.copyWith(
      text: nxt,
      selection: const TextSelection(baseOffset: 2, extentOffset: 2),
      composing: TextRange.empty,
    );
  }

  void handleMinuteDecrement() {
    String cur = _mcontrol.value.text;
    cur = cur != '' ? cur : '00';
    String nxt = '0';
    int nextInt = int.parse(cur) - 1;
    if (nextInt < 0) {
      nxt = '00';
    } else if (nextInt < 10) {
      nxt += nextInt.toString();
    } else {
      nxt = nextInt.toString();
    }
    _mcontrol.value = _mcontrol.value.copyWith(
      text: nxt,
      selection: const TextSelection(baseOffset: 2, extentOffset: 2),
      composing: TextRange.empty,
    );
  }

  void handleHourDecrement() {
    String cur = _hcontrol.text;
    cur = cur != '' ? cur : '00';
    String nxt = '0';
    int nextInt = int.parse(cur) - 1;
    if (nextInt < 0) {
      nxt = '00';
    } else if (nextInt < 10) {
      nxt += nextInt.toString();
    } else {
      nxt = nextInt.toString();
    }
    _hcontrol.value = _hcontrol.value.copyWith(
      text: nxt,
      selection: const TextSelection(baseOffset: 2, extentOffset: 2),
      composing: TextRange.empty,
    );
  }

  @override
  void initState() {
    super.initState();
    _hcontrol.value = _hcontrol.value
        .copyWith(text: durationHoursPart(widget.defaultDuration));
    _hcontrol.addListener(handleHourOnChange);

    _mcontrol.value = _mcontrol.value
        .copyWith(text: durationMinutesPart(widget.defaultDuration));
    _mcontrol.addListener(handleMinuteOnChange);
  }

  @override
  void dispose() {
    _hcontrol.dispose();
    _mcontrol.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
      decoration: const BoxDecoration(
        color: kBtnBgClr,
      ),
      child: Column(
        children: [
          Text(
            widget.cardTitle,
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: kClkBgClr,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    width: 80,
                    height: 60,
                    child: Center(
                      child: TextField(
                        controller: _hcontrol,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.newRocker(
                          color: kTextClr,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Hours',
                    style: TextStyle(
                      color: kTextClr,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(width: 10.0),
              Column(
                children: [
                  ChangeTimeButton(
                    onPressed: handleHourIncrement,
                    type: ChangeTimeButtonType.up,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  ChangeTimeButton(
                    onPressed: handleHourDecrement,
                    type: ChangeTimeButtonType.down,
                  ),
                ],
              ),
              const SizedBox(width: 10.0),
              Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: kClkBgClr,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    width: 80,
                    height: 60,
                    child: Center(
                      child: TextField(
                        controller: _mcontrol,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.newRocker(
                          color: kTextClr,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Minutes',
                    style: TextStyle(
                      color: kTextClr,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              const SizedBox(width: 10.0),
              Column(
                children: [
                  ChangeTimeButton(
                    onPressed: handleMinuteIncrement,
                    type: ChangeTimeButtonType.up,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  ChangeTimeButton(
                    onPressed: handleMinuteDecrement,
                    type: ChangeTimeButtonType.down,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          )
        ],
      ),
    );
  }
}
