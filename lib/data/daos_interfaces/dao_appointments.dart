abstract class DaoAppointments{
  Future<bool> addAppointment(Map<String, dynamic> appt);
  Future<List<Map<String,dynamic>>> seekAppointments(DateTime date);
}