// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final bool? active;
  final String? resetPasswordToken;
  final DateTime? resetPasswordExpires;
  final String? emailToken;
  final dynamic emailTokenExpires;
  final String? accessToken;
  final dynamic referrer;
  final String? id;
  final String? email;
  final String? password;
  final String? name;
  final String? surname;
  final String? userId;
  final String? referralCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  User({
    this.active,
    this.resetPasswordToken,
    this.resetPasswordExpires,
    this.emailToken,
    this.emailTokenExpires,
    this.accessToken,
    this.referrer,
    this.id,
    this.email,
    this.password,
    this.name,
    this.surname,
    this.userId,
    this.referralCode,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    active: json["active"],
    resetPasswordToken: json["resetPasswordToken"],
    resetPasswordExpires: json["resetPasswordExpires"] == null ? null : DateTime.parse(json["resetPasswordExpires"]),
    emailToken: json["emailToken"],
    emailTokenExpires: json["emailTokenExpires"],
    accessToken: json["accessToken"],
    referrer: json["referrer"],
    id: json["_id"],
    email: json["email"],
    password: json["password"],
    name: json["name"],
    surname: json["surname"],
    userId: json["userId"],
    referralCode: json["referralCode"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "active": active,
    "resetPasswordToken": resetPasswordToken,
    "resetPasswordExpires": resetPasswordExpires?.toIso8601String(),
    "emailToken": emailToken,
    "emailTokenExpires": emailTokenExpires,
    "accessToken": accessToken,
    "referrer": referrer,
    "_id": id,
    "email": email,
    "password": password,
    "name": name,
    "surname": surname,
    "userId": userId,
    "referralCode": referralCode,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
