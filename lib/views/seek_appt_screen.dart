import 'package:barberia_app/models/appointment.dart';
import 'package:barberia_app/view_models/appointments_view_model.dart';
import 'package:barberia_app/views/widgets/appointment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SeekAppointmentScreen extends StatefulWidget{

  SeekAppointmentScreen({super.key});

  @override
  State<SeekAppointmentScreen> createState() => _SeekAppointmentScreenState();
}

class _SeekAppointmentScreenState extends State<SeekAppointmentScreen> {
  DateTime date = DateTime.now();
  List<Appointment> appts = [];
  final viewModel = AppointmentsViewModel.getInstance();

  void _selectDate(BuildContext context) async{
    DateTime? aux = await showDatePicker(
      context: context, 
      firstDate: DateTime.now(), 
      currentDate: date, 
      lastDate: DateTime(2100)
    );
    if(aux != null){
      setState(() {
        date = aux;
      });
    }
  }

  void _seekAppts() async{
    appts = await viewModel.seekAppointments(date);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25, right: 15, left: 15, bottom: 5),
            child: Row(
              children: [
                const Text("Citas por: ", style: TextStyle(fontSize: 16),),
                Expanded(
                child: TextField(
                  readOnly: true,
                  onTap: ()=>_selectDate(context),
                  decoration: InputDecoration(
                    hintText: '${date.year}/${date.month}/${date.day}',
                    filled: true,
                    prefixIcon: const Icon(Icons.calendar_month_outlined),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                ),
              ),],
            ),
          ),
          const SizedBox(height: 10,),
          TextButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(220, 82, 73, 124)),
                fixedSize: WidgetStateProperty.all(Size(200, 50)),
                elevation: const WidgetStatePropertyAll(10)
              ),
              onPressed: _seekAppts, 
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, color: Colors.white,),
                  Text(" Buscar", style: TextStyle(color: Colors.white),),
                ],
              )
          ),
          const SizedBox(height: 10,),
          Expanded(
           // height: 400,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(172, 225, 219, 255), 
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView.builder(
                itemCount: appts.length,
                itemBuilder: (context, index){
                  return  AppointmentWidget(appt: appts[index], even: index % 2);
                }
              ),
            ),
          )
        ],
      ),
    );
  }
}