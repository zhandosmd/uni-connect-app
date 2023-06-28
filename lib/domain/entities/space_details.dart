// To parse this JSON data, do
//
//     final spaceDetails = spaceDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:uni_connect/domain/entities/post.dart';

SpaceDetails spaceDetailsFromJson(String str) =>
    SpaceDetails.fromJson(json.decode(str));

String spaceDetailsToJson(SpaceDetails data) => json.encode(data.toJson());

class SpaceDetails {
  String? id;
  String? userId;
  String? title;
  String? description;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<Post>? posts;

  SpaceDetails({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.posts,
  });

  factory SpaceDetails.fromJson(Map<String, dynamic> json) => SpaceDetails(
        id: json["_id"],
        userId: json["userId"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        posts: json["posts"] == null
            ? []
            : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "title": title,
        "description": description,
        "image": image,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "posts": posts == null
            ? []
            : List<dynamic>.from(posts!.map((x) => x.toJson())),
      };
}
