import 'package:barberia_app/repository/repository.dart';
import 'package:flutter/material.dart';

class AppointmentsViewModel {

  static var instance = AppointmentsViewModel();
  
  final repo = AppointmentsRepository();

  static AppointmentsViewModel getInstance() => instance;

  Future<String?> addAppointment(
    {
      required String firstName,
      required String lastName,
      required String cedula,
      required String age,
      required DateTime date,
      required TimeOfDay time,
    }
  ) async {
    try{
      Map<String, dynamic> appt = {
        "nombres" : firstName,
        "apellidos" : lastName,
        "cedula" : int.parse(cedula),
        "edad" : int.parse(age),
        "fecha" : '${date.year}${date.month<10? 0: "" }${date.month}${date.day < 10? 0:""}${date.day}',
        "hora" : '${time.hour < 10 ? 0:""}${time.hour}${time.minute < 10 ? 0:""}${time.minute}',
      };
      print(appt);
      await repo.addAppointment(appt);
      return null;
    }catch(e){
      return "Hubo un error, no se pudo guardar";
    }
  }

}