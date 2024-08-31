import 'package:barberia_app/presentation/views/make_appt_screen.dart';
import 'package:barberia_app/presentation/views/seek_appt_screen.dart';
import 'package:flutter/material.dart';
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
          SizedBox(
            height: 50,
            width: 100,
            child: ToggleSwitch(
              customWidths: [90.0, 90.0],
              cornerRadius: 20.0,
              activeBgColors: [
                [Colors.cyan],
                [Colors.redAccent]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              totalSwitches: 2,
              labels: ['YES', ''],
              icons: [null, Icons.abc],
              onToggle: (index) {
                print('switched to: $index');
              },
            ),
          ),
          IndexedStack(
            index: page,
            children: pages,
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
}
