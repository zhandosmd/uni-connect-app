import 'dart:convert';

// class EventLocal {
//   final String title;
//   final String place;
//   final String date;
//   final String createdDate;
//   final String imageUrl;
//   final String? description;

//   EventLocal(
//       {required this.title,
//       required this.place,
//       required this.date,
//       required this.createdDate,
//       required this.imageUrl,
//       this.description});
// }

// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

List<Event> eventFromJson(String str) =>
    List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventToJson(List<Event> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
  List<String>? images;
  String? id;
  String? title;
  String? date;
  String? time;
  String? description;
  String? clubId;
  int? price;
  String? userId;
  String? storyImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? cardNumber;
  int? ticketCount;

  Event({
    this.images,
    this.id,
    this.title,
    this.date,
    this.time,
    this.description,
    this.clubId,
    this.price,
    this.userId,
    this.storyImage,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.cardNumber,
    this.ticketCount,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        id: json["_id"],
        title: json["title"],
        date: json["date"],
        time: json["time"],
        description: json["description"],
        clubId: json["clubId"],
        price: json["price"],
        userId: json["userId"],
        storyImage: json["storyImage"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        cardNumber: json["cardNumber"],
        ticketCount: json["ticketCount"],
      );

  Map<String, dynamic> toJson() => {
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "_id": id,
        "title": title,
        "date": date,
        "time": time,
        "description": description,
        "clubId": clubId,
        "price": price,
        "userId": userId,
        "storyImage": storyImage,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "cardNumber": cardNumber,
        "ticketCount": ticketCount,
      };
}
