


import 'dart:io';

import 'package:barberia_app/data/daos_impl/dao_appointments_json.dart';
import 'package:barberia_app/data/daos_interfaces/dao_appointments.dart';
import 'package:barberia_app/domain/appointments_service.dart';
import 'package:barberia_app/presentation/view_models/appointments_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

final depIn = GetIt.instance;

Future<void> initDependencies()async{
  if(await chooseRepository() == 0){

  }else{

  }
  //this should be dynamic depending on what's read in the config file
  depIn.registerSingleton<DaoAppointments>(DaoAppointmentsJSON());


  depIn.registerLazySingleton<AppointmentsService>(()=>AppointmentsService(depIn.get<DaoAppointments>()));

  depIn.registerLazySingleton<AppointmentsViewModel>(()=> AppointmentsViewModel(depIn.get<AppointmentsService>()));
}


//returns 0 if we gonna use postgres, or 1 if we're gonna use json
Future<int> chooseRepository() async {
  late final int repoCode;
  final directory = await getApplicationDocumentsDirectory();
  final folder = Directory('${directory.path}/repository');
  if(! await folder.exists()){
    await folder.create(recursive: true);
  }
  final repoFile = File('${folder.path}/repo.txt');
  if(! await repoFile.exists()){
    repoFile.writeAsBytes([0]); //code 0 for postgres database
    repoCode = 0;
  }
  else{
     final bytes = await repoFile.readAsBytes();
     repoCode = bytes.first;
  }
  return repoCode;
}