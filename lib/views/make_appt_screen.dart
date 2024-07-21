
import 'dart:math';

import 'package:barberia_app/providers/date_time_provider.dart';
import 'package:barberia_app/view_models/appointments_view_model.dart';
import 'package:barberia_app/views/widgets/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/input_field.dart';

class MakeAppointmentScreen extends StatefulWidget{

  const MakeAppointmentScreen({super.key});

  @override
  State<MakeAppointmentScreen> createState() => _MakeAppointmentScreenState();
}



class _MakeAppointmentScreenState extends State<MakeAppointmentScreen> {

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final cedulaController = TextEditingController();
  final ageController = TextEditingController();
  final viewModel = AppointmentsViewModel.getInstance();
  

  void _makeAppointment() async{
    String? errorMessage;
    if(cedulaController.text.length < 8) errorMessage = "La cedula debe contener mas de 7 digitos";
    else if(firstNameController.text.isEmpty) errorMessage = "Debe ingresar el nombre";
    else if(lastNameController.text.isEmpty) errorMessage = "Debe ingresar los apelldios";
    else if(ageController.text.isEmpty) errorMessage = "Debe ingresar la edad";

    var prov = Provider.of<DateTimeProvider>(context, listen: false);
    errorMessage ??= await viewModel.addAppointment(
        firstName: firstNameController.text,
        lastName: lastNameController.text, 
        cedula: cedulaController.text,
        age: ageController.text, 
        date: prov.date, time: prov.time
      );
    if(errorMessage == null){
      await showDialog(
        context: context, 
        builder: (con){
          return const AlertDialog.adaptive(
            icon: Icon(Icons.store_mall_directory),
            title: Text("Cita agendada"),
          );
        }
      );
      setState(() {
        firstNameController.clear();
        lastNameController.clear();
        cedulaController.clear();
        ageController.clear();
        prov.date = DateTime.now();
        prov.time = TimeOfDay.now();
      });
      return;
    };
    await showDialog(
      context: context, 
      builder: (con){
        return AlertDialog(
          title: const Center(child: Text("No se pudo agendar")),
          content: SizedBox(
            height: 100,
            child: Column(
              children: [
                Text(errorMessage!),
                const SizedBox(height: 5,),
                TextButton(
                  onPressed: ()=>Navigator.of(context).pop(), 
                  child: const Text("Aceptar", style: TextStyle(fontSize: 16),)
                )
              ],
            ),
          ),
        );
      }
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            InputField(
              fieldType: "Cedula",
              fieldHint: "Ingresa tu cedula",
              controller: cedulaController,
            ),
            const SizedBox(height: 20,),
            InputField(
              fieldType: "Nombres",
              fieldHint: "Ingresa tu nombre",
              controller: firstNameController,
            ),
            const SizedBox(height: 20,),
            InputField(
              fieldType: "Apellidos",
              fieldHint: "Ingresa tu apellido",
              controller: lastNameController,
            ),
            const SizedBox(height: 20,),
            InputField(
              fieldType: "Edad",
              fieldHint: "Ingresa tu edad",
              controller: ageController,
            ),
            const SizedBox(height: 20,),
            DateTimePickerField(stateSet: setState,),
            const SizedBox(height: 20,),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(220, 82, 73, 124)),
                fixedSize: WidgetStateProperty.all( const Size(200, 50)),
                elevation: const WidgetStatePropertyAll(10)
              ),
              onPressed: _makeAppointment, 
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save_alt, color: Colors.white,),
                  Text("  Agendar cita", style: TextStyle(color: Colors.white),),
                ],
              ))
          ]
        ),
      ),
    );
  }
}