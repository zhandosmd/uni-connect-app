import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<String> icons = [
    'assets/images/ic_space.svg',
    'assets/images/ic_tickets.svg',
    'assets/images/ic_favorite.svg',
    'assets/images/ic_info.svg'
  ];

  final List<String> iconNames = [
    'My Spaces',
    'My Tickets',
    'My Favorites',
    'About App'
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.asset('assets/images/ic_settings.svg')
          ),
          const SizedBox(height: 16,),
          Image.asset('assets/images/im_profile_ava.png', height: 100, width: 100,),
          const SizedBox(height: 16,),
          const Text('John Doe', style: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 18
          ),),
          const SizedBox(height: 2,),
          const Text('190103445@stu.sdu.edu.kz', style: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 10
          ),),
          const SizedBox(height: 4,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Status:', style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 10
              ),),
              Text(' Student', style: TextStyle(
                fontWeight: FontWeight.w700, fontSize: 10, color: AppColors.mainColor
              ),),
            ],
          ),
          const SizedBox(height: 16,),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 70,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColors.black,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: Row(
                  children: [
                    SvgPicture.asset(icons[index]),
                    const SizedBox(width: 10,),
                    Text(iconNames[index], style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700
                    ),),
                    const Spacer(),
                    SvgPicture.asset('assets/images/ic_chevron_right.svg')
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 16,);
            },
            itemCount: icons.length,
          )
        ],
      ),
    );
  }
}
