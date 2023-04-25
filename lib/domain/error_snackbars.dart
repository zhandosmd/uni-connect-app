import 'package:flutter/material.dart';

abstract class ErrorSnackBar{

  static void showSnackBar(String message, BuildContext context){
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}