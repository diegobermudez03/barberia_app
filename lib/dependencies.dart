


import 'dart:io';

import 'package:barberia_app/core/data/postgres/postgres_connection.dart';
import 'package:barberia_app/data/daos_impl/dao_appointments_json.dart';
import 'package:barberia_app/data/daos_impl/dao_appointments_postgres.dart';
import 'package:barberia_app/data/daos_interfaces/dao_appointments.dart';
import 'package:barberia_app/domain/appointments_service.dart';
import 'package:barberia_app/presentation/view_models/appointments_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

final depIn = GetIt.instance;
int repoCode = 0;

Future<void> initDependencies()async{
  late final DaoAppointments daoAppts;
  if(await chooseRepository() == 0){
    daoAppts = DaoAppointmentsPostgres();
  }else{
    daoAppts = DaoAppointmentsJSON();
  }
  //this should be dynamic depending on what's read in the config file
  depIn.registerSingleton<DaoAppointments>(daoAppts);


  depIn.registerLazySingleton<AppointmentsService>(()=>AppointmentsService(depIn.get<DaoAppointments>()));

  depIn.registerLazySingleton<AppointmentsViewModel>(()=> AppointmentsViewModel(depIn.get<AppointmentsService>()));
}


//returns 0 if we gonna use postgres, or 1 if we're gonna use json
Future<int> chooseRepository() async {
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