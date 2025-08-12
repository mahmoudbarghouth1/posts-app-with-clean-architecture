import 'package:flutter/material.dart';

class ElevatedButtonIconWidget extends StatelessWidget {
  const ElevatedButtonIconWidget({super.key, required this.onpress, required this.icon, required this.label});
  final void Function() onpress;
  final bool icon;
  final bool label;

  @override
  Widget build(BuildContext context) {
    return   ElevatedButton.icon(
            onPressed: onpress,
             icon: icon ? Icon(Icons.edit) : Icon(Icons.add),
              label: label? Text("Update") : Text("Add"),
              );
  }
}
