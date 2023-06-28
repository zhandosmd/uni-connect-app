import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/domain/api_client/api_client.dart';
import 'package:uni_connect/domain/data_providers/session_data_provider.dart';
import 'package:uni_connect/domain/error_snackbars.dart';

import '../../domain/entities/auth_response.dart';
import '../main/main_screen.dart';
import '../registration/verification/verification_screen.dart';
import '../registration/verification/verification_view_model.dart';

class LoginViewModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;
  bool isErrorEmail = false;
  bool isErrorPassword = false;
  bool isLoading = false;
  String? errorText;
  String currentEmail = '@stu.sdu.edu.kz';
  List<String> emails = ['@stu.sdu.edu.kz', '@sdu.edu.kz', '@gmail.com'];

  Future<AuthResponse?> logIn({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    notifyListeners();

    AuthResponse? response = await _apiClient.login(
        email: email, password: password); // <statusCode, message>
    isLoading = false;
    notifyListeners();

    return response;
  }

  void changeHidePassword() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  void changeIsErrorEmail(bool isErrorEmail) {
    this.isErrorEmail = isErrorEmail;
    notifyListeners();
  }

  void changeIsErrorPassword(bool isErrorPassword) {
    this.isErrorPassword = isErrorPassword;
    notifyListeners();
  }

  void changeEmail(String currentEmail) {
    this.currentEmail = currentEmail;
    notifyListeners();
  }

  Future<void> pressLogin(BuildContext context) async {
    changeIsErrorEmail(emailController.text.isEmpty);
    changeIsErrorPassword(passwordController.text.isEmpty);

    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      AuthResponse? response = await logIn(
          email: '${emailController.text}$currentEmail',
          password: passwordController.text);
      if (response?.success == true &&
          response?.accessToken != null &&
          response?.accessToken != '') {
        await SessionDataProvider().setSessionId(response?.accessToken ?? '');
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
          return const MainScreen();
        }));
      } else {
        if (response?.message ==
            'You must verify your email to activate your account') {
          sendCode('${emailController.text}$currentEmail', context);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return ChangeNotifierProvider(
                create: (_) => VerificationViewModel(),
                child: VerificationScreen(
                  email: emailController.text,
                  slug: currentEmail,
                ));
          }));
          ErrorSnackBar.showSnackBar(
            message: response?.message,
            context: context,
            color: Colors.orange,
          );
        } else {
          ErrorSnackBar.showSnackBar(
            message: 'Server Error: status code ${response?.statusCode}!',
            context: context,
          );
        }
      }
    }
  }

  Future<void> sendCode(String email, BuildContext context) async {
    final authResponse = await _apiClient.sendCode(email: email);

    if (authResponse?.error ?? false) {
      ErrorSnackBar.showSnackBar(
        message: authResponse?.message,
        context: context,
      );
    }
  }
}
