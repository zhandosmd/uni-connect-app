import 'package:flutter/material.dart';

abstract class ErrorSnackBar{

  static void showSnackBar({String? message, required BuildContext context, Color? color}){
    final snackBar = SnackBar(
      backgroundColor: color ?? Colors.red,
      content: Text(message ?? '', style: const TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white
      ),),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}