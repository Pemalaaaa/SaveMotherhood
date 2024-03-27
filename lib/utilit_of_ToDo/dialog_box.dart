import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pema_la/utilit_of_ToDo/my_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final controller;
// making a function that retun no value fro save and cancel
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super. key, 

    //constructor 
    required this.controller,
    required this.onSave,
    required this.onCancel,
    
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Color(0xFFF7E5E7),
        content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // for user input
            TextField(
              //controller to access the data . the controller that is used fromthe above code  final controller
                controller: controller,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),

            //buttons->save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Save button
                MyButton(text: "Save", onPressed: onSave),

                const SizedBox(width: 9),

                //Cancel button
                MyButton(text: "Cancel", onPressed: onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
