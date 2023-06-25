import 'package:flutter/material.dart';
import 'package:uni_connect/domain/api_client/api_client.dart';

import '../../domain/entities/story.dart';

class HomeViewModel extends ChangeNotifier{
  final _apiClient = ApiClient();
  List<Story>? stories;
  bool isLoading = true;

  Future<void> getStories() async {
    stories = await _apiClient.getStories();
  }

  Future<void> init() async{
    await getStories();

    isLoading = false;
    notifyListeners();
  }
}