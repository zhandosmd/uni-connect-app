import 'package:flutter/cupertino.dart';
import 'package:uni_connect/domain/api_client/api_client.dart';

import '../../domain/entities/club.dart';

class MainViewModel extends ChangeNotifier{
  List<Club>? clubs;
  final _apiClient = ApiClient();

  Future<void> getClubs() async{
    clubs = await _apiClient.getClubs();
    notifyListeners();
  }
}