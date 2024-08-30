import 'package:barberia_app/models/appointment.dart';
import 'package:barberia_app/models/user.dart';
import 'package:barberia_app/data/daos_impl/dao_appointments_json.dart';
import 'package:barberia_app/utils/functions.dart';
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
        "fecha" : dateToString(date), 
        "hora" : '${time.hour < 10 ? 0:""}${time.hour}${time.minute < 10 ? 0:""}${time.minute}',
      };
      print(appt);
      await repo.addAppointment(appt);
      return null;
    }catch(e){
      return "Hubo un error, no se pudo guardar";
    }
  }

  Future<List<Appointment>> seekAppointments(DateTime date) async{
    var apptJSON = await repo.seekAppointments(date);
    List<Appointment> appointments = apptJSON.map((appt){
      User user = User(
        cedula: appt["cedula"],
        lastName: appt["apellidos"],
        firstName: appt["nombres"],
        age: appt["edad"],
      );
      Appointment appointment = Appointment(
        client: user, 
        date: date,
        time: stringToTime(appt["hora"]),
      );
      return appointment;
    }).toList();
    return appointments;

  }

}