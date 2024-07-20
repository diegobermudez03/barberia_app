import 'package:barberia_app/views/make_appt_screen.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget{
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("App barberia")),
        elevation: 20,
      ),
      body: MakeAppointmentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 15,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add_alarm_rounded), label: "Cita"),
          BottomNavigationBarItem(icon: Icon(Icons.table_rows_outlined), label: "Buscar"),
        ]
      ),
    );
  }
}