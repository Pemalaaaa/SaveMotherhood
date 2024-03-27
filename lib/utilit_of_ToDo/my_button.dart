import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
   final String text;

  //the voidcallback is like a function but it does not return anything
  VoidCallback onPressed;
  
  MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color:Color(0xFFFFC2CD),
      child: Text(text),
    );
  }
}
