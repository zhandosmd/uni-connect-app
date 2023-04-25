import 'package:dio/dio.dart';

class ApiClient{
  final String _host = 'https://fine-jade-cobra-toga.cyclic.app';
  final _dioClient = Dio();

  Future<String?> register({
    required String email,
    required String password,
    required String name,
    required String surname,
  }) async {

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
      return response.data['error'] == true ? response.data['message'] : null;
    } on DioError catch (e) {
      print("DioError register: ${e.message}");
    }
    return null;
  }

  Future<List> login({
    required String email,
    required String password,
  }) async {

    try {
      Response response = await _dioClient.post(
        '$_host/users/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      return [response.data['error'], response.data['message']];
    } on DioError catch (e) {
      print("DioError login: ${e.message}");
    }
    return [false, 'Server Error, try again!'];
  }
}