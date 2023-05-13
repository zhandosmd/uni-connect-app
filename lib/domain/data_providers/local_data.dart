import '../../ui/home/home_screen.dart';
import '../../ui/spaces/spaces_screen.dart';
import '../entities/event.dart';
import '../entities/local_club.dart';
import '../entities/space.dart';

abstract class LocalData{
  static final List<Story> stories = [
    Story(title: 'Welcome Party 2023', image: 'assets/images/im_stories_1.png'),
    Story(title: 'Welcome Party 2023', image: 'assets/images/im_stories_1.png'),
    Story(title: 'Welcome Party 2023', image: 'assets/images/im_stories_1.png'),
    Story(title: 'Welcome Party 2023', image: 'assets/images/im_stories_1.png'),
    Story(title: 'Welcome Party 2023', image: 'assets/images/im_stories_1.png'),
  ];

  static final List<Event> events = [
    Event(title: 'FC "Кайрат" - FC "Актобе"', place: 'Almaty Arena', date: '14.05.2023, at 18:30', createdDate: '10 march, 17:47', imageUrl: 'assets/images/im_events_4.jpg'),
    Event(title: 'Ice Skating', place: 'Almaty Medeu Skating Rink', date: '11.07.2023, at 14:00', createdDate: '05 may, 18:35', imageUrl: 'assets/images/im_events_2.jpg'),
    Event(title: 'Ne Prosto Orchestra', place: 'Republic Palace', date: '18.06.2023, at 19:00', createdDate: '21 march, 20:29', imageUrl: 'assets/images/im_events_3.jpg'),
    Event(title: 'SDU Football Cup 2023', place: 'Suleyman Demirel University Stadium', date: '13.06.2023, at 18:00', createdDate: '21 march, 16:23', imageUrl: 'assets/images/im_events_1.png'),
  ];

  static final List<LocalClub> clubs = [
    LocalClub(name: 'SDU Club', imageUrl: 'assets/images/im_club_1.png'),
    LocalClub(name: 'Music Club', imageUrl: 'assets/images/im_club_2.png'),
    LocalClub(name: 'Academic Club', imageUrl: 'assets/images/im_club_3.png'),
    LocalClub(name: 'Sport Club', imageUrl: 'assets/images/im_club_4.png'),
    LocalClub(name: 'Event Club', imageUrl: 'assets/images/im_club_5.png'),
    LocalClub(name: 'Vision', imageUrl: 'assets/images/im_club_6.png'),
  ];

  static final List<Space> spaces = [
    Space(imageUrl: 'assets/images/image 3-2.png', name: 'ACM Community', postLength: '163 posts'),
    Space(imageUrl: 'assets/images/image 3-3.png', name: 'Eat&Chat', postLength: '255 posts'),
    Space(imageUrl: 'assets/images/image 3-4.png', name: 'Uni Activities', postLength: '766 posts'),
    Space(imageUrl: 'assets/images/image 3-5.png', name: 'SDU Football League', postLength: '175 posts'),
    Space(imageUrl: 'assets/images/image 3-6.png', name: 'Lost and Found SDU', postLength: '255 posts'),
    Space(imageUrl: 'assets/images/image 3-7.png', name: 'Startup Garage', postLength: '1163 posts'),
    Space(imageUrl: 'assets/images/image 3-8.png', name: 'Designers SDU', postLength: '163 posts'),
    Space(imageUrl: 'assets/images/image 3-4.png', name: 'Eat&Chat', postLength: '255 posts'),
  ];
}