import 'dart:convert';

List<Story> storyFromJson(String str) => List<Story>.from(json.decode(str).map((x) => Story.fromJson(x)));

String storyToJson(List<Story> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Story {
  final String? image;

  Story({
    this.image,
  });

  factory Story.fromJson(Map<String, dynamic> json) => Story(
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
  };
}