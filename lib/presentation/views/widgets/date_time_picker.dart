import 'package:flutter/material.dart';

class DateTimePickerField extends StatelessWidget {

  final void Function(BuildContext) dateHanlder;
  final void Function(BuildContext) timeHandler;
  DateTimePickerField({super.key, required this.dateHanlder, required this.timeHandler});

  @override
  Widget build(BuildContext context) {
    DateTime nowDate = DateTime.now();
    TimeOfDay nowTime = TimeOfDay.now();
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          children: [
            Expanded(
              flex: 4,
              child: TextField(
                readOnly: true,
                onTap: ()=> dateHanlder(context),
                decoration: InputDecoration(
                  hintText: '${nowDate.year}/${nowDate.month}/${nowDate.day}',
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
                onTap: ()=> timeHandler(context),
                decoration: InputDecoration(
                  hintText: '${nowTime.hour}:${nowTime.minute}',
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