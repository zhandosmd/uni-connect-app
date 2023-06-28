import 'package:flutter/material.dart';
import 'package:uni_connect/domain/api_client/api_client.dart';

import '../../domain/entities/event.dart';
import '../../domain/entities/story.dart';

class HomeViewModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  List<Story>? stories;
  List<Event> events = [];
  bool isLoading = false;

  Future<void> getStories() async {
    stories = await _apiClient.getStories();
  }

  Future<void> getEvents() async {
    events = await _apiClient.getEvents() ?? [];
  }

  Future<void> init() async {
    isLoading = true;
    notifyListeners();

    await getStories();
    await getEvents();

    isLoading = false;
    notifyListeners();
  }
}
