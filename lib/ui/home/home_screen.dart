import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/ui/event/event_view_model.dart';
import 'package:uni_connect/ui/home/home_view_model.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import '../../domain/data_providers/local_data.dart';
import '../club_info/club_info_screen.dart';
import '../event/event_screen.dart';
import '../stories/stories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<HomeViewModel>().init();
    });
  }

  final clubs = LocalData.clubs;
  final events = LocalData.events;
  final spaces = LocalData.spaces;

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((HomeViewModel vm) => vm.isLoading);
    final stories = context.select((HomeViewModel vm) => vm.stories);

    return isLoading
      ? const Expanded(
        child: Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white,))
      )
      : SingleChildScrollView(
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
              if(stories != null && stories.isNotEmpty) SizedBox(
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
                              return StoriesScreen(stories: stories, index: index,);
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
                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromRGBO(0, 0, 0, 0),
                              Color.fromRGBO(0, 0, 0, 0.8),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter
                          ),
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              child: Image.network(stories[index].image ?? '', width: 100, fit: BoxFit.cover,)
                            ),
                            const Positioned(
                              left: 8,
                              right: 8,
                              bottom: 8,
                              child: Text('No Title', style: TextStyle(fontSize: 12),)
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
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns
                  crossAxisSpacing: 16, // Spacing between columns
                  mainAxisSpacing: 16, // Spacing between rows
                ),
                padding: const EdgeInsets.all(16), // Padding for all sides
                itemCount: clubs.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ClubInfoScreen(club: clubs[index],);
                          }
                        )
                      );
                    },
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: Image.asset(
                        clubs[index].imageUrl,
                        width: (MediaQuery.of(context).size.width - 16 * 4) / 3,
                      ),
                    ),
                  );
                },
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
                    final currentEvent = events[index];

                    return GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ChangeNotifierProvider(
                                create: (_) => EventViewModel(),
                                child: EventScreen(event: currentEvent)
                              );
                            }
                          )
                        );
                      },
                      child: Container(
                        height: 218,
                        width: 205,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        margin: index == 0
                          ? const EdgeInsets.only(left: 16)
                          : index == 4
                          ? const EdgeInsets.only(right: 16)
                          : EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              child: Image.asset(currentEvent.imageUrl, width: 205, height: 158, fit: BoxFit.cover,)
                            ),
                            const SizedBox(height: 7,),
                            Text(currentEvent.title, style: const TextStyle(
                              fontWeight: FontWeight.w700
                            ),),
                            const SizedBox(height: 4,),
                            FittedBox(
                              child: Text(currentEvent.place, style: const TextStyle(
                                fontSize: 12
                              ),),
                            ),
                            const SizedBox(height: 4,),
                            Text(currentEvent.date, style: const TextStyle(
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
                  itemCount: events.length,
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
                    final currentSpace = spaces[index];

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
                          Image.asset(currentSpace.imageUrl),
                          Positioned(
                            left: 8,
                            right: 8,
                            bottom: 8,
                            child: Column(
                              children: [
                                Text(currentSpace.name, style: const TextStyle(
                                  fontWeight: FontWeight.w700
                                ),),
                                const SizedBox(height: 4,),
                                Text(currentSpace.postLength, style: const TextStyle(
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
                  itemCount: spaces.length,
                ),
              )
            ],
          ),
        ),
      );
  }
}

// class Story{
//   final String title;
//   final String image;
//
//   Story({required this.title, required this.image});
// }
