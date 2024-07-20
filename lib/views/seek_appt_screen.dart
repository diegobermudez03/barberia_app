import 'package:flutter/material.dart';

class SeekAppointmentScreen extends StatelessWidget{
  DateTime date = DateTime.now();
  SeekAppointmentScreen({super.key});

  void _selectDate(BuildContext context){}
  void _seekAppts(){}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Citas por: "),
                Expanded(
                flex: 2,
                child: TextField(
                  readOnly: true,
                  onTap: ()=>_selectDate(context),
                  decoration: InputDecoration(
                    hintText: '${date.year}/${date.month}/${date.day}',
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_month_outlined),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
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
                elevation: WidgetStatePropertyAll(10)
              ),
              onPressed: _seekAppts, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, color: Colors.white,),
                  Text(" Buscar", style: TextStyle(color: Colors.white),),
                ],
              )
          ),
          const SizedBox(height: 10,),
          /*ListView.builder(
            itemBuilder: itemBuilder
          )*/
        ],
      ),
    );
  }
}