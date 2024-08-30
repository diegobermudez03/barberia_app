import 'package:barberia_app/domain/appointments_service.dart';
import 'package:barberia_app/models/appointment.dart';
import 'package:barberia_app/utils/functions.dart';
import 'package:flutter/material.dart';

class AppointmentsViewModel {
  
  final AppointmentsService service;

  AppointmentsViewModel(this.service);


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
    Map<String, dynamic> appt = {
      "nombres" : firstName,
      "apellidos" : lastName,
      "cedula" : int.parse(cedula),
      "edad" : int.parse(age),
      "fecha" : dateToString(date), 
      "hora" : '${time.hour < 10 ? 0:""}${time.hour}${time.minute < 10 ? 0:""}${time.minute}',
    };
    final response = await service.addAppointment(appt);

    return response.fold(
      (f)=>f.getMessage(), 
      (success)=>null
    );
  }

  Future<List<Appointment>> seekAppointments(DateTime date) async{
    final response = await service.seekAppointments(date);
    return response.fold((f)=>[], (appts)=>appts);
  }

}