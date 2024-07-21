import 'package:flutter/material.dart';

String dateToString(DateTime date)=>'${date.year}${date.month<10? 0: "" }${date.month}${date.day < 10? 0:""}${date.day}';

TimeOfDay stringToTime(String time){
  int hour = int.parse(time.substring(0, 2));
  int minute = int.parse(time.substring(2, 4));
  return TimeOfDay(hour: hour, minute: minute);
}
