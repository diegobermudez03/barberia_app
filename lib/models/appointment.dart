import 'package:barberia_app/models/user.dart';
import 'package:flutter/material.dart';

class Appointment{
  final User client;
  final DateTime date;
  final TimeOfDay time;

  const Appointment({
    required this.client,
    required this.date,
    required this.time,
  });

}