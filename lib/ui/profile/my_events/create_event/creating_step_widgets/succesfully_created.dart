import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common_widgets/floating_button_widget.dart';

class SuccessfullyCreatedScreen extends StatelessWidget {
  const SuccessfullyCreatedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/ic_succesfully_created.svg'),
              const SizedBox(height: 45,),
              const Text('Event created successfully', style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700
              ),)
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FloatingButtonWidget(
          onTap: () {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          },
          text: 'Go back to main',
        ),
      ),
    );
  }
}
