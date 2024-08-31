import 'dart:convert';

import 'package:barberia_app/data/daos_interfaces/dao_appointments.dart';
import 'package:barberia_app/core/utils/failures.dart';
import 'package:barberia_app/core/utils/functions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class DaoAppointmentsJSON implements DaoAppointments{

  @override
  Future<Either<Failure,bool>> addAppointment(Map<String, dynamic> appt) async
  {
    try{
      appt["fecha"] = dateToString(appt["fecha"]);
      TimeOfDay time = appt["hora"];
      appt["hora"] = '${time.hour < 10 ? 0:""}${time.hour}${time.minute < 10 ? 0:""}${time.minute}';
      final directory = await getApplicationDocumentsDirectory();
      final folder = Directory('${directory.path}/${appt["fecha"]}');
      if(! await folder.exists()){
        await folder.create(recursive: true);
      }
      final jsonFile = File('${folder.path}/${appt["cedula"]}.json');
      String jsonString = jsonEncode(appt);
      await jsonFile.writeAsString(jsonString);

      return const Right(true);
    }catch(e){
      return Left(JSONFailure());
    }
  }

  @override
  Future<Either<Failure,List<Map<String,dynamic>>>> seekAppointments(DateTime date) async
  {
    try{
      final directory = await getApplicationDocumentsDirectory();
      final folder = Directory('${directory.path}/${dateToString(date)}');
      List<Map<String,dynamic>> appts = [];
      if(await folder.exists()){
        var apptsStream = folder.list(recursive: false);

        await for(FileSystemEntity file in apptsStream){
          if (file is File){
            appts.add(jsonDecode(await (file as File).readAsString()));
          }
        }
      }
      return Right(appts);
    }catch(e){
      return Left(JSONFailure());
    }
  }

}