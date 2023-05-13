import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/ui/profile/my_events/create_event/create_event_view_model.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import 'creating_step_widgets/creating_step_1.dart';
import 'creating_step_widgets/creating_step_2.dart';
import 'creating_step_widgets/creating_step_3.dart';

class CreateEventScreen extends StatelessWidget {
  CreateEventScreen({Key? key}) : super(key: key);
  final List<Widget> creatingSteps = [
    const CreateStep1Widget(),
    const CreateStep2Widget(),
    const CreateStep3Widget(),
  ];

  @override
  Widget build(BuildContext context) {
    final model = context.read<CreateEventViewModel>();
    final currentTab = context.watch<CreateEventViewModel>().currentTab;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => model.onTapCancel(context),
                          child: SvgPicture.asset('assets/images/ic_chevron_left.svg')
                        ),
                      ),
                    ),
                    const Text('Create Event', style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 22
                    ),),
                    SizedBox(
                      width: 100,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text('Cancel', style: TextStyle(
                              color: AppColors.mainColor
                          ),),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 5,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 5,
                        width: (MediaQuery.of(context).size.width - 32 - 20) / 3,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          color: currentTab >= index ? AppColors.mainColor : AppColors.gray
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 10,);
                    },
                    itemCount: 3,
                  ),
                ),
                const SizedBox(height: 15,),
                creatingSteps[currentTab],
                const SizedBox(height: 80,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
