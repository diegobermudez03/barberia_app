import 'package:barberia_app/data/daos_interfaces/dao_appointments.dart';
import 'package:barberia_app/models/appointment.dart';
import 'package:barberia_app/models/user.dart';
import 'package:barberia_app/utils/failures.dart';
import 'package:barberia_app/utils/functions.dart';
import 'package:dartz/dartz.dart';

class AppointmentsService{
  final DaoAppointments dao;

  AppointmentsService(this.dao);

  Future<Either<Failure, void>> addAppointment(Map<String, dynamic> appt) async{
    return dao.addAppointment(appt);
  }

  Future<Either<Failure, List<Appointment>>> seekAppointments(DateTime date) async{
    final response = await dao.seekAppointments(date);
    return response.fold(
      (failure)=>Left(failure),
      (resp){
          List<Appointment> appointments = resp.map((appt){
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
        return Right(appointments);
      }
    );
  }
}