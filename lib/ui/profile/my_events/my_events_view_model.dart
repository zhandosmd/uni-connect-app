import 'package:flutter/cupertino.dart';
import 'package:uni_connect/domain/api_client/api_client.dart';

import '../../../domain/entities/event.dart';

class MyEventsViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<Event> userEvents = [];
  final apiClient = ApiClient();

  Future<void> getUserEvents() async {
    isLoading = true;
    notifyListeners();
    userEvents = await apiClient.getUserEvents() ?? [];
    isLoading = false;
    notifyListeners();
  }
}
