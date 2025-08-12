import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String name;
  final bool multiLine;
  final TextEditingController controller;

  const TextFieldWidget({super.key, required this.name, required this.multiLine, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        minLines: multiLine ? 6 : 1,
        maxLines: multiLine ? 6 : 1,
        controller: controller,
        validator: (value) => value!.isEmpty ? "Cant be empty" : null,
        decoration: InputDecoration(
          hintText: name,
          border: OutlineInputBorder(borderSide: BorderSide(style: BorderStyle.solid)),
        ),
      ),
    );
  }
}
