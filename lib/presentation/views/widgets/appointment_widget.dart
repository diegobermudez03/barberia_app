import 'package:barberia_app/domain/models/appointment.dart';
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
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: even == 1?Color.fromARGB(255, 216, 212, 248): Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 90,
            padding: EdgeInsets.only(left: 10),
            child: Text(appt.client.cedula.toString()),
          ),
           SizedBox(
            width: 100,
            child: Text('${appt.client.firstName} ${appt.client.lastName}'),
          ),
          SizedBox(
            width: 70,
            child: Text(appt.time.format(context)),
          ),
        ]
      ),
    );
  }
}