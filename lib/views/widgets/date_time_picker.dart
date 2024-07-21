import 'package:barberia_app/providers/date_time_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateTimePickerField extends StatefulWidget{

  final Function stateSet;

  const DateTimePickerField({
    super.key,
    required this.stateSet,
  });

  @override
  State<DateTimePickerField> createState() => _DateTimePickerFieldState();
}

class _DateTimePickerFieldState extends State<DateTimePickerField> {

  Future<void> _selectDate(BuildContext context) async{
    var prov = Provider.of<DateTimeProvider>(context, listen: false);

    DateTime? aux = await showDatePicker(
      context: context, 
      firstDate: DateTime.now(), 
      currentDate: prov.date, 
      lastDate: DateTime(2100)
    );
    if(aux != null){
      setState(() {
        prov.date = aux;
      });
      widget.stateSet();
    }
  }

  Future<void> _selectTime(BuildContext context) async{
    var prov = Provider.of<DateTimeProvider>(context, listen: false);
    TimeOfDay? aux = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now()
    );
    if(aux != null){
      setState(() {
        prov.time = aux;
      });
      widget.stateSet();
    }
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<DateTimeProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          children: [
            Expanded(
              flex: 4,
              child: TextField(
                readOnly: true,
                onTap: ()=>_selectDate(context),
                decoration: InputDecoration(
                  hintText: '${prov.date.year}/${prov.date.month}/${prov.date.day}',
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
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 3,
              child: TextField(
                readOnly: true,
                onTap: ()=> _selectTime(context),
                decoration: InputDecoration(
                  hintText: '${prov.time.hour}:${prov.time.minute}',
                  filled: true,
                  prefixIcon: const Icon(Icons.timelapse_rounded),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              )
            ),
          ],
      ),
    );
  }
}