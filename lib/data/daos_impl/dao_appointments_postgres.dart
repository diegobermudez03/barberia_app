import 'package:barberia_app/core/data/postgres/postgres_connection.dart';
import 'package:barberia_app/data/daos_interfaces/dao_appointments.dart';
import 'package:barberia_app/core/utils/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:postgres/postgres.dart';

class DaoAppointmentsPostgres implements DaoAppointments {
  DaoAppointmentsPostgres();

  @override
  Future<Either<Failure, bool>> addAppointment(
      Map<String, dynamic> appt) async {
    try {
      final conn = await PostgresConnection.openConnection();
      await conn.runTx((c) async {
        Result user = await c.execute(
            r'SELECT user_id FROM USERS WHERE cedula = $1',
            parameters: [appt["cedula"]]);
        if (user.isEmpty) {
          user = await c.execute(
              r'INSERT INTO USERS(first_name, last_name, age, cedula) VALUES($1, $2, $3, $4) RETURNING user_id',
              parameters: [
                appt["nombres"],
                appt["apellidos"],
                appt["edad"],
                appt["cedula"]
              ]);
        }
        DateTime date = appt["fecha"];
        TimeOfDay time = appt["hora"];
        String timestamp =
            DateTime(date.year, date.month, date.day, time.hour, time.minute)
                .toIso8601String();
        await c.execute(
            r'INSERT INTO APPOINTMENTS(appointment_date, user_id) VALUES($1, $2)',
            parameters: [timestamp, user[0][0]]);
      });
      PostgresConnection.closeConnection();
      return const Right(true);
    } catch (e) {
      print(e);
      return Left(PostgresFailure());
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> seekAppointments(
      DateTime date) async {
    try {
      final conn = await PostgresConnection.openConnection();
      DateFormat formatter = DateFormat('yyyy-MM-dd');
      String formatedDate = formatter.format(date);
      Result res = await conn.execute(
          Sql.named(
              'SELECT * FROM USERS U INNER JOIN APPOINTMENTS A ON U.USER_ID = A.USER_ID WHERE A.appointment_date::DATE =  @date'),
          parameters: {'date': formatedDate});
      List<Map<String, dynamic>> response = [];
      for (final arr in res) {
        Map<String, dynamic> appt = Map();
        appt["cedula"] = int.parse(arr[1].toString());
        appt["nombres"] = arr[2];
        appt["apellidos"] = arr[3];
        appt["edad"] = int.parse(arr[4].toString());
        appt["hora"] = arr[6].toString().substring(11, 13) +
            arr[6].toString().substring(14, 16);
        response.add(appt);
      }
      PostgresConnection.closeConnection();
      return Right(response);
    } catch (e) {
      print(e);
      return Left(PostgresFailure());
    }
  }
}
