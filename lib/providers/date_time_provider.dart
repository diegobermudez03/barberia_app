import 'package:flutter/material.dart';

class DateTimeProvider extends ChangeNotifier{
  
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  DateTime get date => _date;
  TimeOfDay get time => _time;

  set date(DateTime dateA){
    _date = dateA;
    notifyListeners();
  }

  set time(TimeOfDay timeA){
    _time = timeA;
    notifyListeners();
  }

}