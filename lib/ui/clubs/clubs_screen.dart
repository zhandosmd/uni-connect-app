import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import '../club_info/club_info_screen.dart';

class ClubsScreen extends StatefulWidget {
  const ClubsScreen({Key? key}) : super(key: key);

  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  final List<String> clubImages = [
    'assets/images/im_club_1.png',
    'assets/images/im_club_2.png',
    'assets/images/im_club_3.png',
    'assets/images/im_club_4.png',
    'assets/images/im_club_5.png',
    'assets/images/im_club_6.png',
  ];

  final List<String> clubNames = [
    'SDU Club',
    'Music Club',
    'Academic Club',
    'Sport Club',
    'Event Club',
    'Vision',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Clubs', style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700
            ),),
            const SizedBox(height: 22,),
            Container(
              height: 48,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppColors.black
              ),
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Row(
                children: [
                  SvgPicture.asset('assets/images/ic_search.svg'),
                  const SizedBox(width: 10,),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search clubs...",
                        hintStyle: TextStyle(color: AppColors.gray)
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 22,),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) { 
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return ClubInfoScreen();
                        }
                      )
                    );
                  },
                  child: Container(
                    height: 70,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: AppColors.black
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Row(
                      children: [
                        Image.asset(clubImages[index], height: 42, width: 42,),
                        const SizedBox(width: 10,),
                        Text(clubNames[index], style: const TextStyle(
                          fontWeight: FontWeight.w500
                        ),),
                        const Spacer(),
                        SvgPicture.asset('assets/images/ic_chevron_right.svg')
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 16,);
              },
              itemCount: clubImages.length,
            )
          ],
        ),
      ),
    );
  }
}
