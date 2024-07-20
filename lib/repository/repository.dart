import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class AppointmentsRepository{


  Future<bool> addAppointment(Map<String, dynamic> appt) async
  {
    final directory = await getApplicationDocumentsDirectory();
    return true;
  }
}