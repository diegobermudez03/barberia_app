import 'package:barberia_app/presentation/views/homepage_screen.dart';
import 'package:barberia_app/presentation/views/make_appt_screen.dart';
import 'package:barberia_app/presentation/views/seek_appt_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Homepage(),
      debugShowCheckedModeBanner: false,
      routes:{
        "/make_app": (context) => MakeAppointmentScreen(),
        "/seek_app": (context) => SeekAppointmentScreen(),
      }
    );
  }
}