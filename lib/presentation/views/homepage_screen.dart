import 'dart:io';

import 'package:barberia_app/dependencies.dart' as depen;
import 'package:barberia_app/presentation/views/make_appt_screen.dart';
import 'package:barberia_app/presentation/views/seek_appt_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int page = 0;

  List<Widget> pages = [
    const MakeAppointmentScreen(),
    SeekAppointmentScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("App barberia")),
        elevation: 20,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20,),
          ToggleSwitch(
            initialLabelIndex: depen.repoCode,
            customWidths: const [90.0, 90.0],
            cornerRadius: 20.0,
            activeBgColors: const [
              [Colors.cyan],
              [Colors.redAccent]
            ],
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.white,
            totalSwitches: 2,
            labels: const ['Postgres', 'JSON'],
            icons: const [null, null],
            onToggle: switchRepository,
          ),
          Expanded(
            child: IndexedStack(
              index: page,
              children: pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 15,
        currentIndex: page,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.add_alarm_rounded), label: "Cita"),
          BottomNavigationBarItem(
              icon: Icon(Icons.table_rows_outlined), label: "Buscar"),
        ],
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
      ),
    );
  }


  //this function shouldn't be entirely implemented here, instead it should 
  //call a viewmodel which calls a service, but I'm lazy for this one, so I'll
  //implement it completely here
  void switchRepository(int? index) async{
    index ??= 0;
    final directory = await getApplicationDocumentsDirectory();
    final folder = Directory('${directory.path}/repository');
    final repoFile = File('${folder.path}/repo.txt');
    repoFile.writeAsBytes([index], mode: FileMode.write); //it overwrites what it was before

    //dialog to close the app
    await showDialog(
      barrierDismissible: false, //so it can be closed if it isn't with the button
      context: context, 
      builder: (dialogContext){
        return  AlertDialog(
          title: const Text("la aplicacion necesitara reiniciar"),
          content: TextButton(
            onPressed: (){
              //it closes the app once it's pressed
              SystemNavigator.pop();
            }, 
            child: const Text("CERRAR")
          ),
        );
      });

  }
}
