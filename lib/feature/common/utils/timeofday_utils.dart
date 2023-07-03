import 'package:flutter/material.dart';

extension TimeOfDayUtils on TimeOfDay {
  TimeOfDay addHour(int hour) {
    return replacing(hour: this.hour + hour, minute: minute);
  }
}
