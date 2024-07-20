import 'package:flutter/material.dart';

class InputField extends StatelessWidget{
  final String fieldType;
  final String fieldHint;
  final TextEditingController controller;

  static const Map<String, TextInputType> keyboards = {
    "Cedula" : TextInputType.number,
    "Nombres": TextInputType.name,
    "Apellidos": TextInputType.name,
    "Edad" : TextInputType.number
  };

  const InputField({
    super.key,
    required this.fieldType,
    required this.fieldHint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          child: Text(
            fieldType,
          ),
        ),
        Expanded(
          child: TextField(
            keyboardType: keyboards[fieldType],
            controller: controller,
            decoration: InputDecoration(
              hintText: fieldHint,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            ),
            
          ),
        )
      ],
    );
  }
}