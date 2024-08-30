import 'package:barberia_app/data/daos_interfaces/dao_appointments.dart';

class DaoAppointmentsPostgres implements DaoAppointments{
  @override
  Future<bool> addAppointment(Map<String, dynamic> appt) {
    // TODO: implement addAppointment
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> seekAppointments(DateTime date) {
    // TODO: implement seekAppointments
    throw UnimplementedError();
  }
}