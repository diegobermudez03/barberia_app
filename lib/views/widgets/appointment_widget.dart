import 'package:barberia_app/models/appointment.dart';
import 'package:flutter/material.dart';

class AppointmentWidget extends StatelessWidget{
  final Appointment appt;
  final int even;

  const AppointmentWidget(
    {
      super.key,
      required this.appt,
      required this.even,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: even == 1?Colors.black: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 100,
            child: Text(appt.client.cedula.toString()),
          ),
           SizedBox(
            width: 100,
            child: Text('${appt.client.firstName} ${appt.client.lastName}'),
          ),
          SizedBox(
            width: 80,
            child: Text(appt.time.format(context)),
          ),
        ]
      ),
    );
  }
}