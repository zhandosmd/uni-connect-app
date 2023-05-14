class Event{
  final String title;
  final String place;
  final String date;
  final String createdDate;
  final String imageUrl;
  final String? description;

  Event({required this.title, required this.place, required this.date, required this.createdDate, required this.imageUrl, this.description});
}