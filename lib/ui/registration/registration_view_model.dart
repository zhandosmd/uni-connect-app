import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/domain/api_client/api_client.dart';
import 'package:uni_connect/ui/registration/verification/verification_screen.dart';
import 'package:uni_connect/ui/registration/verification/verification_view_model.dart';

import '../../domain/entities/auth_response.dart';
import '../../domain/error_snackbars.dart';

class RegistrationViewModel extends ChangeNotifier{
  final _apiClient = ApiClient();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final passwordController = TextEditingController();
  String currentEmail = '@stu.sdu.edu.kz';
  List<String> emails = ['@stu.sdu.edu.kz', '@sdu.edu.kz', '@gmail.com'];

  bool hidePassword = true;
  bool isLoading = false;
  String? errorText;

  Future<AuthResponse?> register({
    required String email,
    required String password,
    required String name,
    required String surname
  }) async {
    isLoading = true;
    notifyListeners();

    AuthResponse? authResponse = await _apiClient.register(
      email: email,
      password: password,
      name: name,
      surname: surname
    );

    isLoading = false;
    notifyListeners();

    return authResponse;
  }

  Future<void> pressRegister(BuildContext context) async {

    if(emailController.text.isNotEmpty && nameController.text.isNotEmpty
    && surnameController.text.isNotEmpty && passwordController.text.isNotEmpty){

      AuthResponse? authResponse = await register(
        email: '${emailController.text}$currentEmail',
        name: nameController.text,
        surname: surnameController.text,
        password: passwordController.text,
      );
      if(authResponse?.success ?? false){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return ChangeNotifierProvider(
              create: (_) => VerificationViewModel(),
              child: VerificationScreen(email: emailController.text, slug: currentEmail,)
            );
          })
        );
      }else{
        ErrorSnackBar.showSnackBar(message: authResponse?.message, context: context);
      }
    }else{
      ErrorSnackBar.showSnackBar(message: 'Please, fill in all fields', context: context);
    }
  }

  void changeHidePassword(){
    hidePassword = !hidePassword;

    notifyListeners();
  }

  void changeEmail(String currentEmail){
    this.currentEmail = currentEmail;
    notifyListeners();
  }
}