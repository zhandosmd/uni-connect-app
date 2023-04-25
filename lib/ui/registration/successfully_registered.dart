import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main/main_screen.dart';
import '../theme/app_colors.dart';

class SuccessfullyRegistered extends StatelessWidget {
  const SuccessfullyRegistered({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset('assets/images/im_profile_ava.png', height: 200, width: 200,),
          const SizedBox(height: 20,),
          const Text('Congratulations, zhandos', style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700
          ),),
          const SizedBox(height: 8,),
          const Text('You have successfully created an account'),
          Spacer(),
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return const MainScreen();
                })
              );
            },
            child: Container(
              height: 48,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColors.mainColor
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: const Center(
                  child: Text('Ready')
              ),
            ),
          ),
          const SizedBox(height: 40,),
        ],
      ),
    );
  }
}
