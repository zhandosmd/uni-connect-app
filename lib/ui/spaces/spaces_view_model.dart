import 'package:flutter/material.dart';
import 'package:uni_connect/domain/api_client/api_client.dart';
import 'package:uni_connect/domain/entities/space.dart';

class SpacesViewModel extends ChangeNotifier {
  List<Space> spaces = [];
  final apiClient = ApiClient();
  bool isLoading = false;

  Future<void> getSpaces() async {
    isLoading = true;
    notifyListeners();
    spaces = await apiClient.getSpaces() ?? [];
    isLoading = false;
    notifyListeners();
  }
}
