import 'package:flutter/material.dart';
import 'package:uni_connect/ui/main/main_screen.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import '../auth/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: AppColors.backgroundColor,
          textTheme: const TextTheme(
            subtitle1: TextStyle(color: Colors.white, fontSize: 12),
            headline1: TextStyle(color: Colors.white),
            headline2: TextStyle(color: Colors.white),
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
          )),
      home: const LoginScreen(),
      // home: const MainScreen(),
    );
  }
}
