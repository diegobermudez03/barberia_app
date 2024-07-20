import 'package:flutter/material.dart';

class DateTimePickerField extends StatefulWidget{

  final Function stateSet;
  DateTime date;
  TimeOfDay time;

  DateTimePickerField({
    super.key,
    required this.date,
    required this.time,
    required this.stateSet,
  });

  @override
  State<DateTimePickerField> createState() => _DateTimePickerFieldState();
}

class _DateTimePickerFieldState extends State<DateTimePickerField> {

  Future<void> _selectDate(BuildContext context) async{
    DateTime? aux = await showDatePicker(
      context: context, 
      firstDate: DateTime.now(), 
      currentDate: widget.date, 
      lastDate: DateTime(2100)
    );
    if(aux != null){
      setState(() {
        widget.date = aux;
      });
      widget.stateSet();
    }
  }

  Future<void> _selectTime(BuildContext context) async{
    TimeOfDay? aux = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now()
    );
    if(aux != null){
      setState(() {
        widget.time = aux;
      });
      widget.stateSet();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          children: [
            Expanded(
              flex: 2,
              child: TextField(
                readOnly: true,
                onTap: ()=>_selectDate(context),
                decoration: InputDecoration(
                  hintText: '${widget.date.year}/${widget.date.month}/${widget.date.day}',
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
            ),
            SizedBox(width: 20),
            Expanded(
              flex: 1,
              child: TextField(
                readOnly: true,
                onTap: ()=> _selectTime(context),
                decoration: InputDecoration(
                  hintText: '${widget.time.hour}:${widget.time.minute}',
                  filled: true,
                  prefixIcon: Icon(Icons.timelapse_rounded),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
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