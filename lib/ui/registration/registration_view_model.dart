import 'package:flutter/cupertino.dart';
import 'package:uni_connect/domain/api_client.dart';

class RegistrationViewModel extends ChangeNotifier{
  final _apiClient = ApiClient();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool isClosed = true;
  String? errorText;

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String surname
  }) async {
    isLoading = true;
    notifyListeners();

    String? message = await _apiClient.register(
      email: email,
      password: password,
      name: name,
      surname: surname
    );
    errorText = message;
    isLoading = false;
    notifyListeners();
  }

  Future<void> validateSignUp() async {
    if(emailController.text.isNotEmpty && nameController.text.isNotEmpty
    && surnameController.text.isNotEmpty && passwordController.text.isNotEmpty){
      errorText = null;
      notifyListeners();
      await register(
        email: '${emailController.text}@stu.sdu.edu.kz',
        password: passwordController.text,
        name: nameController.text,
        surname: surnameController.text
      );
    }else{
      errorText = 'Please, fill in all fields';
    }

    notifyListeners();
  }

  void changeIsClosed(){
    isClosed = !isClosed;

    notifyListeners();
  }
}