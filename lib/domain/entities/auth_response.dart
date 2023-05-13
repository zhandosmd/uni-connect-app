// To parse this JSON data, do
//
//     final authResponse = authResponseFromJson(jsonString);

import 'dart:convert';

AuthResponse authResponseFromJson(String str) => AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  AuthResponse({
    this.error,
    this.success,
    this.message,
    this.accessToken,
  });

  final bool? error;
  final bool? success;
  final String? message;
  final String? accessToken;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    error: json["error"],
    success: json["success"],
    message: json["message"],
    accessToken: json["accessToken"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "success": success,
    "message": message,
    "accessToken": accessToken,
  };
}
