import 'package:barberia_app/utils/failures.dart';
import 'package:dartz/dartz.dart';

abstract class DaoAppointments{
  Future<Either<Failure,bool>> addAppointment(Map<String, dynamic> appt);
  Future<Either<Failure,List<Map<String,dynamic>>>> seekAppointments(DateTime date);
}