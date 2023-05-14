import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/ui/profile/my_events/my_events_screen.dart';
import 'package:uni_connect/ui/profile/profile_view_model.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import 'my_events/my_events_view_model.dart';

class ProfileTab{
  final String icon;
  final String title;
  final Widget? nextScreen;

  ProfileTab({required this.icon, required this.title, this.nextScreen});
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<ProfileTab> profileTab = [
    ProfileTab(icon: 'assets/images/ic_space.svg', title: 'My Spaces'),
    ProfileTab(
      icon: 'assets/images/ic_space.svg',
      title: 'My Events',
      nextScreen: ChangeNotifierProvider(
        create: (_) => MyEventsViewModel(),
        child: const MyEventsScreen()
      )
    ),
    ProfileTab(icon: 'assets/images/ic_tickets.svg', title: 'My Tickets'),
    ProfileTab(icon: 'assets/images/ic_favorite.svg', title: 'My Favorites'),
    ProfileTab(icon: 'assets/images/ic_info.svg', title: 'About App'),
  ];

  @override
  Widget build(BuildContext context) {
    final model = context.read<ProfileViewModel>();
    final user = context.select((ProfileViewModel vm) => vm.user);

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
          Text(model.getUserName(user), style: const TextStyle(
            fontWeight: FontWeight.w700, fontSize: 18
          ),),
          const SizedBox(height: 2,),
          Text(user?.email ?? 'Email', style: const TextStyle(
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
              return GestureDetector(
                onTap: (){
                  if(profileTab[index].nextScreen != null){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return profileTab[index].nextScreen!;
                      })
                    );
                  }
                },
                child: Container(
                  height: 70,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: AppColors.black,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: Row(
                    children: [
                      SvgPicture.asset(profileTab[index].icon),
                      const SizedBox(width: 10,),
                      Text(profileTab[index].title, style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700
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
            itemCount: profileTab.length,
          )
        ],
      ),
    );
  }
}
