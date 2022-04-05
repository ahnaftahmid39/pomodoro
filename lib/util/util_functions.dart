String intToStringWithPadding(int a) => a.toString().padLeft(2, '0');

String durationMinutesPart(Duration d) =>
    intToStringWithPadding(d.inMinutes.remainder(60));

String durationHoursPart(Duration d) =>
    intToStringWithPadding(d.inHours.remainder(60));

String durationSecondsPart(Duration d) =>
    intToStringWithPadding(d.inSeconds.remainder(60));
