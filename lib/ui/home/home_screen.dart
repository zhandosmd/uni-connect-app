import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import '../club_info/club_info_screen.dart';
import '../event/event_screen.dart';
import '../stories/stories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Story> stories = [
    Story(title: 'Welcome Party 2023', image: 'assets/images/im_stories_1.png'),
    Story(title: 'Welcome Party 2023', image: 'assets/images/im_stories_1.png'),
    Story(title: 'Welcome Party 2023', image: 'assets/images/im_stories_1.png'),
    Story(title: 'Welcome Party 2023', image: 'assets/images/im_stories_1.png'),
    Story(title: 'Welcome Party 2023', image: 'assets/images/im_stories_1.png'),
  ];

  final List<String> clubImages = [
    'assets/images/im_club_1.png',
    'assets/images/im_club_2.png',
    'assets/images/im_club_3.png',
    'assets/images/im_club_4.png',
    'assets/images/im_club_5.png',
    'assets/images/im_club_6.png',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: SvgPicture.asset("assets/images/ic_logo.svg"),
            ),
            const SizedBox(height: 16,),
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (BuildContext context) {
                            return StoriesScreen();
                          }
                        )
                      );
                    },
                    child: Container(
                      width: 100,
                      height: 80,
                      margin: index == 0
                        ? const EdgeInsets.only(left: 16)
                        : index == stories.length - 1
                          ? const EdgeInsets.only(right: 16)
                          : EdgeInsets.zero,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.mainColor, width: 2),
                        borderRadius: const BorderRadius.all(Radius.circular(8))
                      ),
                      child: Stack(
                        children: [
                          Image.asset(stories[index].image),
                          Positioned(
                            left: 8,
                            right: 8,
                            bottom: 8,
                            child: FittedBox(child: Text(stories[index].title))
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 8,);
                },
                itemCount: stories.length,
              ),
            ),
            const SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('Clubs', style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 18
                  ),),
                  Text('see more', style: TextStyle(
                    fontSize: 12
                  ),),
                ],
              ),
            ),
            const SizedBox(height: 13,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ClubInfoScreen();
                    }
                  )
                );
              },
              child: Row(
                children: [
                  const SizedBox(width: 16,),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Image.asset(
                      clubImages[0],
                      width: (MediaQuery.of(context).size.width - 16*4) / 3,
                    )
                  ),
                  const SizedBox(width: 16,),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Image.asset(
                      clubImages[1],
                      width: (MediaQuery.of(context).size.width - 16*4) / 3,
                    )
                  ),
                  const SizedBox(width: 16,),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Image.asset(
                      clubImages[2],
                      width: (MediaQuery.of(context).size.width - 16*4) / 3,
                    )
                  ),
                  const SizedBox(width: 16,),
                ],
              ),
            ),
            const SizedBox(height: 16,),
            Row(
              children: [
                const SizedBox(width: 16,),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Image.asset(
                    clubImages[3],
                    width: (MediaQuery.of(context).size.width - 16*4) / 3,
                  )
                ),
                const SizedBox(width: 16,),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Image.asset(
                    clubImages[4],
                    width: (MediaQuery.of(context).size.width - 16*4) / 3,
                  )
                ),
                const SizedBox(width: 16,),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Image.asset(
                    clubImages[5],
                    width: (MediaQuery.of(context).size.width - 16*4) / 3,
                  )
                ),
                const SizedBox(width: 16,),
              ],
            ),
            const SizedBox(height: 24,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('Events', style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18
                  ),),
                  Text('see more', style: TextStyle(
                      fontSize: 12
                  ),),
                ],
              ),
            ),
            const SizedBox(height: 13,),
            SizedBox(
              height: 218,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return EventScreen();
                          }
                        )
                      );
                    },
                    child: Container(
                      height: 218,
                      width: 205,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      margin: index == 0
                        ? const EdgeInsets.only(left: 16)
                        : index == 4
                        ? const EdgeInsets.only(right: 16)
                        : EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/im_events_1.png', width: 205, height: 158,),
                          const SizedBox(height: 7,),
                          const Text('SDU Football Cup 2023', style: TextStyle(
                            fontWeight: FontWeight.w700
                          ),),
                          const SizedBox(height: 4,),
                          const FittedBox(
                            child: Text('Suleyman Demirel University Stadium', style: TextStyle(
                              fontSize: 12
                            ),),
                          ),
                          const SizedBox(height: 4,),
                          const Text('01.09.2023, at 18:00', style: TextStyle(
                            fontSize: 12
                          ),),

                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 10,);
                },
                itemCount: 5,
              ),
            ),
            const SizedBox(height: 24,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('Top Spaces', style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18
                  ),),
                  Text('see more', style: TextStyle(
                      fontSize: 12
                  ),),
                ],
              ),
            ),
            const SizedBox(height: 13,),
            SizedBox(
              height: 143,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 143,
                    width: 185,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                    margin: index == 0
                      ? const EdgeInsets.only(left: 16)
                      : index == 4
                      ? const EdgeInsets.only(right: 16)
                      : EdgeInsets.zero,
                    child: Stack(
                      children: [
                        Image.asset('assets/images/im_space_1.png'),
                        Positioned(
                          left: 8,
                          right: 8,
                          bottom: 8,
                          child: Column(
                            children: const [
                              Text('ACM Community', style: TextStyle(
                                fontWeight: FontWeight.w700
                              ),),
                              SizedBox(height: 4,),
                              Text('163 posts', style: TextStyle(
                                fontSize: 12
                              ),),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 8,);
                },
                itemCount: 5,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Story{
  final String title;
  final String image;

  Story({required this.title, required this.image});
}
