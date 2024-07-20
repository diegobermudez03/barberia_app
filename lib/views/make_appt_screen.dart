
import 'package:barberia_app/widgets/date_time_picker.dart';
import 'package:flutter/material.dart';

import '../widgets/input_field.dart';

class MakeAppointmentScreen extends StatefulWidget{

  MakeAppointmentScreen({super.key});

  @override
  State<MakeAppointmentScreen> createState() => _MakeAppointmentScreenState();
}



class _MakeAppointmentScreenState extends State<MakeAppointmentScreen> {

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            InputField(
              fieldType: "Cedula",
              fieldHint: "Ingresa tu cedula",
            ),
            const SizedBox(height: 20,),
            InputField(
              fieldType: "Nombres",
              fieldHint: "Ingresa tu nombre",
            ),
            const SizedBox(height: 20,),
            InputField(
              fieldType: "Apellidos",
              fieldHint: "Ingresa tu apellido",
            ),
            const SizedBox(height: 20,),
            InputField(
              fieldType: "Edad",
              fieldHint: "Ingresa tu edad",
            ),
            const SizedBox(height: 20,),
            DateTimePickerField(date: date, time: time, stateSet: setState,),
          ]
        ),
      ),
    );
  }
}