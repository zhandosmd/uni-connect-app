import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/ui/app/my_app.dart';
import 'package:uni_connect/ui/auth/login_view_model.dart';
import 'package:uni_connect/ui/registration/registration_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegistrationViewModel()),
      ],
      child: const MyApp(),
    )
  );
}
