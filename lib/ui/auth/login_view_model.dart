import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_connect/domain/api_client.dart';
import 'package:uni_connect/domain/error_snackbars.dart';

import '../main/main_screen.dart';

class LoginViewModel extends ChangeNotifier{
  final _apiClient = ApiClient();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;
  bool isErrorEmail = false;
  bool isErrorPassword = false;
  bool isLoading = false;
  String? errorText;

  Future<List> logIn({
    required String email,
    required String password,
  }) async{
    isLoading = true;
    notifyListeners();

    List response = await _apiClient.login(email: email, password: password);
    isLoading = false;
    notifyListeners();

    return response;
  }

  void changeHidePassword(){
    hidePassword = !hidePassword;
    notifyListeners();
  }

  void changeIsErrorEmail(bool isErrorEmail){
    this.isErrorEmail = isErrorEmail;
    notifyListeners();
  }

  void changeIsErrorPassword(bool isErrorPassword){
    this.isErrorPassword = isErrorPassword;
    notifyListeners();
  }

  Future<void> pressLogin(BuildContext context) async {
    if(emailController.text.isEmpty || passwordController.text.isEmpty){
      changeIsErrorEmail(emailController.text.isEmpty);
      changeIsErrorPassword(passwordController.text.isEmpty);
    }else{
      List response = await logIn(email: emailController.text, password: passwordController.text);
      if(response[0]){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return const MainScreen();
          })
        );
      }
      ErrorSnackBar.showSnackBar(response[1], context);
    }
  }
}