import 'package:flutter/material.dart';

class ESnackBar {
//making function
  static void showSuccess(context, message) {
    //show snackbar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$message"),
      backgroundColor: Colors.green,
    ));
  }
  static void showError(context, message) {
    //show snackbar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$message"),
      backgroundColor: Colors.red,
    ));
  }
}
