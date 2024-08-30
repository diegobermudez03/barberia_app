import 'dart:convert';

import 'package:barberia_app/data/daos_interfaces/dao_appointments.dart';
import 'package:barberia_app/utils/functions.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class DaoAppointmentsJSON implements DaoAppointments{

  @override
  Future<bool> addAppointment(Map<String, dynamic> appt) async
  {
    final directory = await getApplicationDocumentsDirectory();
    final folder = Directory('${directory.path}/${appt["fecha"]}');
    if(! await folder.exists()){
      await folder.create(recursive: true);
    }
    final jsonFile = File('${folder.path}/${appt["cedula"]}.json');
    String jsonString = jsonEncode(appt);
    await jsonFile.writeAsString(jsonString);

    return true;
  }

  @override
  Future<List<Map<String,dynamic>>> seekAppointments(DateTime date) async
  {
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
    return appts;
  }

}