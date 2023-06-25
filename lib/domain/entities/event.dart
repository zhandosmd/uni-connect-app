class Event{
  final String title;
  final String place;
  final String date;
  final String createdDate;
  final String imageUrl;
  final String? description;

  Event({required this.title, required this.place, required this.date, required this.createdDate, required this.imageUrl, this.description});
}


// class Event{
//   final String title;
//   final String date; // format - 28.12.2023
//   final String time;
//   final List<int> imageIDs;
//   final String description;
//
//   Event({required this.title, required this.place, required this.date, required this.createdDate, required this.imageUrl, this.description});
// }