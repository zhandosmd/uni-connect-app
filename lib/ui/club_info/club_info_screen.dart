import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import '../../domain/entities/local_club.dart';

class ClubInfoScreen extends StatelessWidget {
  final LocalClub club;
  ClubInfoScreen({Key? key, required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gallery = club.gallery;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    club.imageUrl,
                    fit: BoxFit.fitWidth,
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, top: 10),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset('assets/images/ic_chevron_left.svg')
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 16,
                    child: Text(club.name, style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 20
                    ),)
                  ),
                ],
              ),
              const SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Upcoming Events', style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18
                    ),),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        Image.asset('assets/images/ic_club_info_upcoming.png', width: 100,),
                        const SizedBox(width: 16,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Daboi Concert', style: TextStyle(
                              fontWeight: FontWeight.w700
                            ),),
                            Text('Brightlight Music Festival', style: TextStyle(
                              fontSize: 12
                            ),),
                            Text('FRIDAY AUG 24, 9PM', style: TextStyle(
                              fontSize: 8, fontWeight: FontWeight.w700
                            ),),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 18,),
                    Row(
                      children: [
                        Image.asset('assets/images/ic_club_info_upcoming.png', width: 100,),
                        const SizedBox(width: 16,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Daboi Concert', style: TextStyle(
                                fontWeight: FontWeight.w700
                            ),),
                            Text('Brightlight Music Festival', style: TextStyle(
                                fontSize: 12
                            ),),
                            Text('FRIDAY AUG 24, 9PM', style: TextStyle(
                                fontSize: 8, fontWeight: FontWeight.w700
                            ),),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 24,),
                    const Center(
                      child: Text('Show all 5 events', style: TextStyle(
                        fontWeight: FontWeight.w500, color: AppColors.mainColor
                      ),),
                    ),
                    const SizedBox(height: 24,),
                    const Text('About:', style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700
                    ),),
                    const SizedBox(height: 15,),
                    Text(club.name, style: const TextStyle(
                      fontWeight: FontWeight.w700
                    ),),
                    const SizedBox(height: 10,),
                    Text(
                      club.description ?? '',
                      style: const TextStyle(
                        fontSize: 12
                      ),
                    ),
                    const SizedBox(height: 24,),
                    const Text('Gallery', style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700
                    ),),
                  ],
                ),
              ),
              const SizedBox(height: 15,),
              if(gallery != null && gallery.isNotEmpty)SizedBox(
                height: 172,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 172,
                      margin: index == 0
                        ? const EdgeInsets.only(left: 16)
                        : index == gallery.length-1
                          ? const EdgeInsets.only(left: 16)
                          : null,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        child: Image.asset(gallery[index])
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 16,);
                  },
                  itemCount: gallery.length,
                ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
