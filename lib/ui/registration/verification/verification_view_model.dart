import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_connect/domain/api_client/api_client.dart';
import 'package:uni_connect/ui/auth/login_screen.dart';

import '../../../domain/error_snackbars.dart';

class VerificationViewModel extends ChangeNotifier{
  bool isErrorCode = false;
  bool isLoading = false;
  final codeController = TextEditingController();
  final _apiClient = ApiClient();

  void changeIsErrorCode(bool isErrorCode){
    this.isErrorCode = isErrorCode;

    notifyListeners();
  }

  void changeIsLoading(bool isLoading){
    this.isLoading = isLoading;

    notifyListeners();
  }

  Future<void> onTapVerify(BuildContext context, String email, String code) async {
    isLoading = true;
    notifyListeners();

    final authResponse = await _apiClient.verifyCode(email: email, code: code);
    if(authResponse?.error == true){
      ErrorSnackBar.showSnackBar(message: authResponse?.message, context: context);
    }else{
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) {
          return const LoginScreen();
        })
      );
    }

    isLoading = false;
    notifyListeners();
  }
}