class Post {
  String? id;
  int? likesCount;
  int? commentsCount;
  String? name;
  String? description;
  String? image;

  Post({
    this.id,
    this.likesCount,
    this.commentsCount,
    this.name,
    this.description,
    this.image,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["_id"],
        likesCount: json["likesCount"],
        commentsCount: json["commentsCount"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "likesCount": likesCount,
        "commentsCount": commentsCount,
        "name": name,
        "description": description,
        "image": image,
      };
}
