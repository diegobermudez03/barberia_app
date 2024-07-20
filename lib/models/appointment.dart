import 'package:barberia_app/models/user.dart';

class Appointment{
  final User client;
  final DateTime date;

  const Appointment({
    required this.client,
    required this.date,
  });

}