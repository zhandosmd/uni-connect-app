import 'dart:io';

import 'package:dio/dio.dart';
import 'package:uni_connect/domain/entities/space.dart';

import '../../ui/home/home_screen.dart';
import '../data_providers/session_data_provider.dart';
import '../entities/auth_response.dart';
import '../entities/club.dart';
import '../entities/story.dart';
import '../entities/user.dart';

class ApiClient {
  final String _host = 'https://uniconnect1.onrender.com';
  final _dioClient = Dio();

  Future<AuthResponse?> login({
    required String email,
    required String password,
  }) async {
    AuthResponse? authResponse;

    try {
      Response response = await _dioClient.post('$_host/users/login', data: {
        'email': email,
        'password': password,
      }, options: Options(
        validateStatus: (status) {
          return (status ?? 0) < 500;
        },
      ));
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
      clubs =
          List<Club>.from(response.data["data"].map((x) => Club.fromJson(x)));
    } on DioError catch (e) {
      print("DioError getClubs: ${e.message}");
    }
    print('user: ${clubs?.length}');

    return clubs;
  }

  Future<List<Story>?> getStories() async {
    List<Story>? stories;
    final jwt = await SessionDataProvider().getSessionId();

    try {
      Response response = await _dioClient.get(
        '$_host/stories/all',
        options: Options(headers: {
          'Authorization': "Bearer $jwt",
        }),
      );
      stories =
          List<Story>.from(response.data["data"].map((x) => Story.fromJson(x)));
    } on DioError catch (e) {
      print("DioError getClubs: ${e.message}");
    }
    print('user: ${stories?.length}');

    return stories;
  }

  Future<AuthResponse?> createEvent({
    String? title,
    String? date,
    String? time,
    String? description,
    String? clubId,
    String? cardNumber,
    String? price,
    String? ticketCount,
    List<File>? images,
  }) async {
    AuthResponse? authResponse;
    final jwt = await SessionDataProvider().getSessionId();
    FormData formData = FormData.fromMap({
      'title': title,
      'date': date, // 10.05.2002
      'time': time, // 10:35
      'description': description,
      'clubId': clubId,
      'cardNumber': cardNumber,
      'price': price,
      'ticketCount': ticketCount,
    });
    for (File image in (images ?? [])) {
      formData.files.addAll([
        MapEntry(
            "images",
            await MultipartFile.fromFile(image.path,
                filename: image.path.split('/').last)),
      ]);
    }

    try {
      Response response = await _dioClient.post(
        '$_host/event/create',
        data: formData,
        options: Options(headers: {
          'Authorization': "Bearer $jwt",
        }),
      );
      authResponse = AuthResponse.fromJson(response.data);
    } on DioError catch (e) {
      print("DioError createEvent: ${e.message}");
    }
    return authResponse;
  }

  Future<List<Space>?> getSpaces() async {
    List<Space>? spaces;
    final jwt = await SessionDataProvider().getSessionId();

    try {
      Response response = await _dioClient.get(
        '$_host/space/all',
        options: Options(headers: {
          'Authorization': "Bearer $jwt",
        }),
      );
      spaces = List<Space>.from(response.data.map((x) => Space.fromJson(x)));
    } on DioError catch (e) {
      print("DioError getSpaces: ${e.message}");
    }
    print('user: ${spaces?.length}');

    return spaces;
  }

  Future<AuthResponse?> createSpace({
    String? title,
    String? description,
    File? image,
  }) async {
    AuthResponse? authResponse;
    final jwt = await SessionDataProvider().getSessionId();

    FormData formData = FormData.fromMap({
      'title': title,
      'description': description,
    });
    if (image != null) {
      formData.files.add(
        MapEntry(
          "image",
          await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
        ),
      );
    }

    try {
      Response response = await _dioClient.post(
        '$_host/space/create',
        data: formData,
        options: Options(headers: {
          'Authorization': "Bearer $jwt",
        }),
      );
      authResponse = AuthResponse.fromJson(response.data);
    } on DioError catch (e) {
      print("DioError createSpace: ${e.message}");
    }
    return authResponse;
  }
}
