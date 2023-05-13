import 'package:flutter/material.dart';
import 'package:uni_connect/domain/api_client/api_client.dart';

import '../../domain/entities/user.dart';

class ProfileViewModel extends ChangeNotifier{
  User? user;
  final _apiClient = ApiClient();

  Future<void> getUser() async{
    user = await _apiClient.getUser();
    notifyListeners();
  }

  String getUserName(User? user){
    if(user == null || (user.name == null && user.surname == null)){
      return 'John Doe';
    }else if(user.name == null){
      return '${user.surname}';
    }else if(user.surname == null){
      return '${user.name}';
    }else{
      return '${user.name} ${user.surname}';
    }
  }
}