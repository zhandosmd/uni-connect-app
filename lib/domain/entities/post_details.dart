// To parse this JSON data, do
//
//     final postDetails = postDetailsFromJson(jsonString);

import 'dart:convert';

PostDetails postDetailsFromJson(String str) =>
    PostDetails.fromJson(json.decode(str));

String postDetailsToJson(PostDetails data) => json.encode(data.toJson());

class PostDetails {
  int? likesCount;
  int? commentsCount;
  String? id;
  String? spaceId;
  String? image;
  String? name;
  String? description;
  List<Comment>? comments;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  PostDetails({
    this.likesCount,
    this.commentsCount,
    this.id,
    this.spaceId,
    this.image,
    this.name,
    this.description,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PostDetails.fromJson(Map<String, dynamic> json) => PostDetails(
        likesCount: json["likesCount"],
        commentsCount: json["commentsCount"],
        id: json["_id"],
        spaceId: json["spaceId"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        comments: json["comments"] == null
            ? []
            : List<Comment>.from(
                json["comments"]!.map((x) => Comment.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "likesCount": likesCount,
        "commentsCount": commentsCount,
        "_id": id,
        "spaceId": spaceId,
        "image": image,
        "name": name,
        "description": description,
        "comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Comment {
  UserComment? user;
  String? id;
  String? text;

  Comment({
    this.user,
    this.id,
    this.text,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        user: json["user"] == null ? null : UserComment.fromJson(json["user"]),
        id: json["_id"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "_id": id,
        "text": text,
      };
}

class UserComment {
  String? id;
  String? fullname;
  String? image;

  UserComment({
    this.id,
    this.fullname,
    this.image,
  });

  factory UserComment.fromJson(Map<String, dynamic> json) => UserComment(
        id: json["id"],
        fullname: json["fullname"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "image": image,
      };
}
