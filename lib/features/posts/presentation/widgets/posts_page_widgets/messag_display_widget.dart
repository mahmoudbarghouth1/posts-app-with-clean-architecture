import 'package:flutter/material.dart';

class MessagDisplayWidget extends StatelessWidget {
  final String message;
  const MessagDisplayWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height/3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(message,style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}
