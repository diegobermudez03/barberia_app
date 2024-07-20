import 'dart:convert';

import 'package:barberia_app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class AppointmentsRepository{


  Future<bool> addAppointment(Map<String, dynamic> appt) async
  {
    final directory = await getApplicationDocumentsDirectory();
    final folder = Directory('${directory.path}/${appt["fecha"]}');
    if(! await folder.exists()){
      await folder.create(recursive: true);
    }
    print(folder);
    final jsonFile = File('${folder.path}/${appt["cedula"]}.json');
    String jsonString = jsonEncode(appt);
    await jsonFile.writeAsString(jsonString);

    return true;
  }

  Future<String?> seekAppointments(DateTime date) async
  {
    final directory = await getApplicationDocumentsDirectory();
    final folder = Directory('${directory.path}/${dateToString(date)}');
    if(! await folder.exists()){
      return null;
    }
    var apptsStream = folder.list(recursive: false);

    List<String> appts = [];
    await for(FileSystemEntity file in apptsStream){
      if (file is File){
        appts.add(await (file as File).readAsString());
      }
    }
    print(appts);
  }

}