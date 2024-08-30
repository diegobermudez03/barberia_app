import 'package:barberia_app/presentation/views/make_appt_screen.dart';
import 'package:barberia_app/presentation/views/seek_appt_screen.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget{
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
      body: IndexedStack(
        index: page,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 15,
        currentIndex: page,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_alarm_rounded), label: "Cita"),
          BottomNavigationBarItem(icon: Icon(Icons.table_rows_outlined), label: "Buscar"),
        ],
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
      ),
    );
  }
}