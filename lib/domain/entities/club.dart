// To parse this JSON data, do
//
//     final club = clubFromJson(jsonString);

import 'dart:convert';

List<Club> clubFromJson(String str) => List<Club>.from(json.decode(str).map((x) => Club.fromJson(x)));

String clubToJson(List<Club> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Club {
  final String? id;
  final String? name;
  final String? description;
  final String? headId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? logo;

  Club({
    this.id,
    this.name,
    this.description,
    this.headId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.logo,
  });

  factory Club.fromJson(Map<String, dynamic> json) => Club(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    headId: json["headId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "headId": headId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "logo": logo,
  };
}
