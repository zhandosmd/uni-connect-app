import 'dart:convert';

class SpaceLocal {
  final String imageUrl;
  final String name;
  final String postLength;

  SpaceLocal({
    required this.imageUrl,
    required this.name,
    required this.postLength,
  });
}

// To parse this JSON data, do
//
//     final space = spaceFromJson(jsonString);

List<Space> spaceFromJson(String str) =>
    List<Space>.from(json.decode(str).map((x) => Space.fromJson(x)));

String spaceToJson(List<Space> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Space {
  String? id;
  String? title;
  String? description;
  int? postCount;
  String? image;

  Space({
    this.id,
    this.title,
    this.description,
    this.postCount,
    this.image,
  });

  factory Space.fromJson(Map<String, dynamic> json) => Space(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        postCount: json["postCount"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "postCount": postCount,
        "image": image,
      };
}
