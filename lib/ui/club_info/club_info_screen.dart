import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:uni_connect/core/utils/date_formatter.dart';

import '../../domain/entities/local_club.dart';
import '../event/event_screen.dart';
import '../event/event_view_model.dart';
import '../home/home_view_model.dart';

class ClubInfoScreen extends StatelessWidget {
  final LocalClub club;
  ClubInfoScreen({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final events = context.select((HomeViewModel vm) => vm.events);
    final gallery = club.gallery;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    club.imageUrl,
                    fit: BoxFit.cover,
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, top: 10),
                      child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: SvgPicture.asset(
                              'assets/images/ic_chevron_left.svg')),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 16,
                    child: Text(
                      club.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Upcoming Events',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ChangeNotifierProvider(
                            create: (_) => EventViewModel(),
                            child: EventScreen(event: events[0]),
                          );
                        }));
                      },
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: Image.network(
                              events[0].images?.firstOrNull ?? '',
                              width: 100,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                events[0].title ?? 'Daboi Concert',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                events[0].description ??
                                    'Brightlight Music Festival',
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text(
                                dateFormat(
                                    events[0].createdAt ?? DateTime.now()),
                                style: const TextStyle(
                                    fontSize: 8, fontWeight: FontWeight.w700),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return ChangeNotifierProvider(
                              create: (_) => EventViewModel(),
                              child: EventScreen(event: events[1]));
                        }));
                      },
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: Image.network(
                              events[1].images?.firstOrNull ?? '',
                              width: 100,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                events[1].title ?? 'Daboi Concert',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                events[1].description ??
                                    'Brightlight Music Festival',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                dateFormat(
                                    events[1].createdAt ?? DateTime.now()),
                                style: const TextStyle(
                                    fontSize: 8, fontWeight: FontWeight.w700),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    // const Center(
                    //   child: Text(
                    //     'Show all 5 events',
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w500,
                    //         color: AppColors.mainColor),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 24,
                    // ),
                    const Text(
                      'About:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      club.name,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      club.description ?? '',
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'Gallery',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              if (gallery != null && gallery.isNotEmpty)
                SizedBox(
                  height: 172,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 172,
                        margin: index == 0
                            ? const EdgeInsets.only(left: 16)
                            : index == gallery.length - 1
                                ? const EdgeInsets.only(left: 16)
                                : null,
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            child: Image.asset(gallery[index])),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 16,
                      );
                    },
                    itemCount: gallery.length,
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
