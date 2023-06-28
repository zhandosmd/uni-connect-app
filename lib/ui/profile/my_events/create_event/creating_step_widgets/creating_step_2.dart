import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/ui/profile/my_events/create_event/create_event_view_model.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import '../../../../common_widgets/floating_button_widget.dart';

class CreateStep2Widget extends StatelessWidget {
  const CreateStep2Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<CreateEventViewModel>();
    final pickedImages = context.watch<CreateEventViewModel>().pickedImages;
    final pickedStoryImage =
        context.watch<CreateEventViewModel>().pickedStoryImage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add photo',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (int index = 0; index < pickedImages.length; index++)
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 100,
                    width: (MediaQuery.of(context).size.width - 32 - 16) / 2,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      color: AppColors.black,
                      image: DecorationImage(
                          image: FileImage(File(pickedImages[index].path)),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                      right: 6,
                      top: 6,
                      child: GestureDetector(
                          onTap: () => model.onTapDeletePhoto(index),
                          child: SvgPicture.asset(
                              'assets/images/ic_delete_photo.svg'))),
                  if (index == 0)
                    Positioned(
                      bottom: 6,
                      child: Container(
                        height: 20,
                        decoration: const BoxDecoration(
                            color: AppColors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: const Center(
                          child: Text(
                            'Main photo',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            GestureDetector(
              onTap: model.onTapPickImage,
              child: Container(
                height: 100,
                width: (pickedImages.isNotEmpty)
                    ? (MediaQuery.of(context).size.width - 32 - 16) / 2
                    : double.infinity,
                decoration: const BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/ic_create_add_image.svg'),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Add photo from gallery',
                      style:
                          TextStyle(fontSize: 12, color: AppColors.mainColor),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        const Text(
          'Add stories',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 15),
        (pickedStoryImage != null)
            ? GestureDetector(
                onTap: model.onTapPickStories,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: (MediaQuery.of(context).size.width - 32 - 16) / 2,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        color: AppColors.black,
                        image: DecorationImage(
                            image: FileImage(File(pickedStoryImage.path)),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      right: 6,
                      top: 6,
                      child: GestureDetector(
                        onTap: () => model.onTapDeleteStories,
                        child: SvgPicture.asset(
                            'assets/images/ic_delete_photo.svg'),
                      ),
                    ),
                    Positioned(
                      bottom: 6,
                      child: Container(
                        height: 20,
                        decoration: const BoxDecoration(
                            color: AppColors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: const Center(
                          child: Text(
                            'Stories photo',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : GestureDetector(
                onTap: model.onTapPickStories,
                child: Container(
                  height: 100,
                  width: (pickedImages.isNotEmpty)
                      ? (MediaQuery.of(context).size.width - 32 - 16) / 2
                      : double.infinity,
                  decoration: const BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/ic_create_add_image.svg'),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Add stories',
                        style:
                            TextStyle(fontSize: 12, color: AppColors.mainColor),
                      )
                    ],
                  ),
                ),
              ),
        const SizedBox(height: 25),
        FloatingButtonWidget(
          onTap: () {
            model.onTapNextPage();
          },
          text: 'Next',
        )
      ],
    );
  }
}
