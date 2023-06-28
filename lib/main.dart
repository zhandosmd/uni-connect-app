import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/domain/data_providers/session_data_provider.dart';
import 'package:uni_connect/ui/app/my_app.dart';
import 'package:uni_connect/ui/auth/login_view_model.dart';
import 'package:uni_connect/ui/home/home_view_model.dart';
import 'package:uni_connect/ui/main/main_view_model.dart';
import 'package:uni_connect/ui/profile/profile_view_model.dart';
import 'package:uni_connect/ui/registration/registration_view_model.dart';
import 'package:uni_connect/ui/space_info/space_info_view_model.dart';
import 'package:uni_connect/ui/spaces/spaces_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isLoggedIn = (await SessionDataProvider().getSessionId()) != null;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ChangeNotifierProvider(create: (_) => RegistrationViewModel()),
      ChangeNotifierProvider(create: (_) => MainViewModel()),
      ChangeNotifierProvider(create: (_) => ProfileViewModel()),
      ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ChangeNotifierProvider(create: (_) => SpacesViewModel()),
      ChangeNotifierProvider(create: (_) => SpaceInfoViewModel()),
    ],
    child: MyApp(isLoggedIn: isLoggedIn),
  ));
}
