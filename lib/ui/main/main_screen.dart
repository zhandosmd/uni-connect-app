import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni_connect/ui/home/home_screen.dart';
import 'package:uni_connect/ui/spaces/spaces_screen.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import '../clubs/clubs_screen.dart';
import '../profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedTab = 0;

  void changeSelectedTab(int index){
    selectedTab = index;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: IndexedStack(
            // хранить все виджеты на памяти тем самым сохраняя стейт
            index: selectedTab,
            children: [
              HomeScreen(),
              SpacesScreen(),
              ClubsScreen(),
              ProfileScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.backgroundColor,
        currentIndex: selectedTab,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(color: AppColors.mainColor),
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        onTap: (index) => changeSelectedTab(index),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/ic_university.svg'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/ic_spaces.svg'),
            label: 'Space'
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/ic_clubs.svg'),
            label: 'Clubs'
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/ic_profile.svg'),
            label: 'Profile'
          )
        ],
      ),
    );
  }
}
