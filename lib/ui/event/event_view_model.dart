import 'package:flutter/material.dart';

class EventViewModel extends ChangeNotifier{
  bool isLoading = true;

  void changeIsLoading(bool isLoading) async {
    await Future.delayed(const Duration(seconds: 1));
    this.isLoading = isLoading;
    notifyListeners();
  }
}