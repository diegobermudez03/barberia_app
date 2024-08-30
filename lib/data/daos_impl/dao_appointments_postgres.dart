import 'package:barberia_app/data/daos_interfaces/dao_appointments.dart';
import 'package:barberia_app/utils/failures.dart';
import 'package:dartz/dartz.dart';

class DaoAppointmentsPostgres implements DaoAppointments{
  @override
  Future<Either<Failure,bool>> addAppointment(Map<String, dynamic> appt) {
    // TODO: implement addAppointment
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure,List<Map<String, dynamic>>>> seekAppointments(DateTime date) {
    // TODO: implement seekAppointments
    throw UnimplementedError();
  }
}