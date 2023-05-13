import 'package:dio/dio.dart';

import '../data_providers/session_data_provider.dart';
import '../entities/auth_response.dart';
import '../entities/club.dart';
import '../entities/user.dart';

class ApiClient{
  final String _host = 'https://fine-jade-cobra-toga.cyclic.app';
  final _dioClient = Dio();

  Future<AuthResponse?> login({
    required String email,
    required String password,
  }) async {
    AuthResponse? authResponse;

    try {
      Response response = await _dioClient.post(
          '$_host/users/login',
          data: {
            'email': email,
            'password': password,
          },
          options: Options(
            validateStatus: (status) {
              return (status ?? 0) < 500;
            },
          )
      );
      authResponse = AuthResponse.fromJson(response.data);

    } on DioError catch (e) {
      print("DioError login: ${e.message}");
    }
    return authResponse;
  }

  Future<AuthResponse?> register({
    required String email,
    required String password,
    required String name,
    required String surname,
  }) async {
    AuthResponse? authResponse;

    try {
      Response response = await _dioClient.post(
        '$_host/users/signup',
        data: {
          'email': email,
          'password': password,
          'name': name,
          'surname': surname
        },
      );
      authResponse = AuthResponse.fromJson(response.data);

    } on DioError catch (e) {
      print("DioError register: ${e.message}");
    }
    return authResponse;
  }

  Future<AuthResponse?> sendCode({
    required String email,
  }) async {
    AuthResponse? authResponse;

    try {
      Response response = await _dioClient.put(
        '$_host/users/repeatCode',
        data: {
          'email': email,
        },
      );
      authResponse = AuthResponse.fromJson(response.data);

    } on DioError catch (e) {
      print("DioError repeatCode: ${e.message}");
    }
    print('${authResponse?.success} sendCode request');
    return authResponse;
  }

  Future<AuthResponse?> verifyCode({
    required String email,
    required String code,
  }) async {
    AuthResponse? authResponse;

    try {
      Response response = await _dioClient.put(
        '$_host/users/activate',
        data: {
          'email': email,
          'code': code,
        },
      );
      authResponse = AuthResponse.fromJson(response.data);

    } on DioError catch (e) {
      print("DioError verifyCode: ${e.message}");
    }
    print('success ${authResponse?.success} verifyCode request');

    return authResponse;
  }

  Future<User?> getUser() async {
    User? user;
    final jwt = await SessionDataProvider().getSessionId();
    print('jwt: $jwt');

    try {
      Response response = await _dioClient.get(
        '$_host/users/',
        options: Options(headers: {
          'Authorization': "Bearer $jwt",
        }),
      );
      user = User.fromJson(response.data["user"]);

    } on DioError catch (e) {
      print("DioError getUser: ${e.message}");
    }
    print('user: ${user?.name}');

    return user;
  }

  Future<List<Club>?> getClubs() async {
    List<Club>? clubs;
    final jwt = await SessionDataProvider().getSessionId();

    try {
      Response response = await _dioClient.get(
        '$_host/clubs/all',
        options: Options(headers: {
          'Authorization': "Bearer $jwt",
        }),
      );
      clubs = List<Club>.from(response.data["data"].map((x) => Club.fromJson(x)));

    } on DioError catch (e) {
      print("DioError getClubs: ${e.message}");
    }
    print('user: ${clubs?.length}');

    return clubs;
  }
}