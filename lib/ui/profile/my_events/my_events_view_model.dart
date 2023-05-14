import 'package:flutter/cupertino.dart';

import '../../../domain/entities/event.dart';

class MyEventsViewModel extends ChangeNotifier{
  bool isLoading = true;

  List<Event> myEvents = [
    Event(title: 'FC "Кайрат" - FC "Актобе"', place: 'Almaty Arena', date: '14.05.2023, at 18:30', createdDate: '10 march, 17:47', imageUrl: 'assets/images/im_events_4.jpg'),
    Event(title: 'Ice Skating', place: 'Almaty Medeu Skating Rink', date: '11.07.2023, at 14:00', createdDate: '05 may, 18:35', imageUrl: 'assets/images/im_events_2.jpg'),
    Event(title: 'Ne Prosto Orchestra', place: 'Republic Palace', date: '18.06.2023, at 19:00', createdDate: '21 march, 20:29', imageUrl: 'assets/images/im_events_3.jpg'),
    Event(title: 'SDU Football Cup 2023', place: 'Suleyman Demirel University Stadium', date: '13.06.2023, at 18:00', createdDate: '21 march, 16:23', imageUrl: 'assets/images/im_events_1.png'),
  ];

  void changeIsLoading(bool isLoading) async {
    await Future.delayed(const Duration(seconds: 2));
    this.isLoading = isLoading;
    notifyListeners();
  }
}