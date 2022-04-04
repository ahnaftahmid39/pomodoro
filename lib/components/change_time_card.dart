import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pomodoro/components/change_time_button.dart';
import 'package:pomodoro/constants/constant.dart';

class ChangeTimeCard extends StatefulWidget {
  const ChangeTimeCard({
    Key? key,
    this.cardTitle = 'Card Name',
    this.initialHourDuration = '00',
    this.initialMinuteDuration = '25',
  }) : super(key: key);

  final String cardTitle;
  final String initialHourDuration;
  final String initialMinuteDuration;

  @override
  State<ChangeTimeCard> createState() => _ChangeTimeCardState();
}

class _ChangeTimeCardState extends State<ChangeTimeCard> {
  final _hcontrol = TextEditingController();
  final _mcontrol = TextEditingController();

  void handleHourOnChange() {
    if (_hcontrol.text == '') return;
    String nxt = '';
    int curNumber = int.parse(_hcontrol.text);

    if (curNumber < 10 && curNumber != 0 && _hcontrol.text.length == 1) {
      nxt = '0' + _hcontrol.text;
    }
    if (curNumber == 0 && _hcontrol.text.length > 2) {
      nxt = '00';
    }
    if (curNumber >= 10 && _hcontrol.text.length > 2) {
      nxt = curNumber.toString();
    }

    if (curNumber > 23) {
      nxt = '23';
    }
    if (curNumber < 0) {
      nxt = '00';
    }

    if (nxt != '') {
      _hcontrol.value = _hcontrol.value.copyWith(
        text: nxt,
        selection: const TextSelection(baseOffset: 2, extentOffset: 2),
        composing: TextRange.empty,
      );
    }
  }

  void handleMinuteOnChange() {
    if (_mcontrol.text == '') return;
    String nxt = '';
    int curNumber = int.parse(_mcontrol.text);

    if (curNumber < 10 && curNumber != 0 && _mcontrol.text.length == 1) {
      nxt = '0' + _mcontrol.text;
    }
    if (curNumber == 0 && _mcontrol.text.length > 2) {
      nxt = '00';
    }
    if (curNumber >= 10 && _mcontrol.text.length > 2) {
      nxt = curNumber.toString();
    }

    if (curNumber > 59) {
      nxt = '59';
    }
    if (curNumber < 0) {
      nxt = '00';
    }

    if (nxt != '') {
      _mcontrol.value = _mcontrol.value.copyWith(
        text: nxt,
        selection: const TextSelection(baseOffset: 2, extentOffset: 2),
        composing: TextRange.empty,
      );
    }
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
    _hcontrol.value = _hcontrol.value.copyWith(text: widget.initialHourDuration);
    _hcontrol.addListener(handleHourOnChange);

    _mcontrol.value = _mcontrol.value.copyWith(text: widget.initialMinuteDuration);
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
