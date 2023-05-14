import '../../ui/home/home_screen.dart';
import '../../ui/spaces/spaces_screen.dart';
import '../entities/event.dart';
import '../entities/local_club.dart';
import '../entities/space.dart';

abstract class LocalData{
  static final List<Story> stories = [
    Story(title: 'Mountain Trip', image: 'assets/images/im_stories_1.jpeg'),
    Story(title: 'Ice Skating', image: 'assets/images/im_stories_2.jpeg'),
    Story(title: 'Horse Riding', image: 'assets/images/im_stories_3.jpeg'),
  ];

  static final List<Event> events = [
    Event(title: 'FC "Кайрат" - FC "Актобе"', place: 'Almaty Arena', date: '14.05.2023, at 18:30', createdDate: '10 march, 17:47', imageUrl: 'assets/images/im_events_4.jpg'),
    Event(title: 'Ice Skating', place: 'Almaty Medeu Skating Rink', date: '11.07.2023, at 14:00', createdDate: '05 may, 18:35', imageUrl: 'assets/images/im_events_2.jpg', description: 'Join us at the winter event "Ice Skating Meetup"! We are going to have a great time, enjoying winter skating on a beautiful ice rink in the city center. The event is open to everyone, regardless of age or skating skill level. Even if you are a beginner, feel free to join us! Dont miss the opportunity to indulge in winter entertainment and uplift your spirits with positive emotions. Join us at the Ice Skating Meetup and create vivid winter memories! If you have any further questions or need additional information, dont hesitate to ask.'),
    Event(title: 'Ne Prosto Orchestra', place: 'Republic Palace', date: '18.06.2023, at 19:00', createdDate: '21 march, 20:29', imageUrl: 'assets/images/im_events_3.jpg', description: 'Ne Prosto Orchestra is the first private and independent orchestra in Kazakhstan, specializing in performing soundtracks from movies, games, TV shows, and anime. Our challenging journey began in 2017. Our first concert was dedicated to Peter Jacksons "The Lord of the Rings" trilogy and the works of George R.R. Martins "Game of Thrones." We performed in the former Kazakhconcert building with a lineup of 65 talented musicians. The program itself consisted of highly complex musical pieces, especially for a debut performance. However, it became a significant milestone for us, opening the doors to new heights we aimed to conquer.'),
    Event(title: 'SDU Football Cup 2023', place: 'Suleyman Demirel University Stadium', date: '13.06.2023, at 18:00', createdDate: '21 march, 16:23', imageUrl: 'assets/images/im_events_1.png'),
  ];

  static final List<LocalClub> clubs = [
    LocalClub(name: 'SDU Club', imageUrl: 'assets/images/im_club_1.png'),
    LocalClub(name: 'Music Club', imageUrl: 'assets/images/im_club_2.png', gallery: ['assets/images/im_club_info_gallery_1.png'], description:
    ''' Welcome to the vibrant world of the University Music Club! Our club is a hav
    en for music enthusiasts, both seasoned performers and passionate listeners alike. 
    We are dedicated to fostering a thriving musical community within the university.\n
    At the University Music Club, we believe in the power of music to inspire, connect, 
    and uplift. Whether you're a talented instrumentalist, a gifted vocalist, or simply 
    have a deep appreciation for the art form, our club provides a platform for you to 
    explore and express your musical passions.'''),
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