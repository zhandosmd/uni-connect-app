import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import '../../common_widgets/floating_button_widget.dart';
import '../spaces_view_model.dart';
import 'create_space_view_model.dart';

class CreateSpaceScreen extends StatefulWidget {
  const CreateSpaceScreen({Key? key}) : super(key: key);

  @override
  State<CreateSpaceScreen> createState() => _CreateSpaceScreenState();
}

class _CreateSpaceScreenState extends State<CreateSpaceScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isPressedOnceNext = false;

  @override
  void initState() {
    super.initState();
    titleController.addListener(() {
      setState(() {});
    });
    descriptionController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<CreateSpaceViewModel>();
    final pickedImage =
        context.select((CreateSpaceViewModel vm) => vm.pickedImage);
    final isLoading = context.select((CreateSpaceViewModel vm) => vm.isLoading);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: Navigator.of(context).pop,
                      child: const Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      'Create Space',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 23),
                const Text(
                  'Title',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 44,
                  decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border:
                          (isPressedOnceNext && titleController.text.isEmpty)
                              ? Border.all(color: AppColors.red)
                              : null),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: TextField(
                      controller: titleController,
                      cursorColor: AppColors.mainColor,
                      decoration: const InputDecoration(
                        hintText: 'Write a title',
                        hintStyle: TextStyle(color: Colors.grey),
                        isCollapsed: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Container(
                  constraints: const BoxConstraints(minHeight: 170),
                  decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: (isPressedOnceNext &&
                              descriptionController.text.isEmpty)
                          ? Border.all(color: AppColors.red)
                          : null),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextField(
                    controller: descriptionController,
                    cursorColor: AppColors.mainColor,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Write a description',
                      hintStyle: TextStyle(color: Colors.grey),
                      isCollapsed: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Add photo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 15),
                pickedImage == null
                    ? GestureDetector(
                        onTap: model.onTapPickImage,
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: AppColors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  'assets/images/ic_create_add_image.svg'),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Добавить фото',
                                style: TextStyle(
                                    fontSize: 12, color: AppColors.mainColor),
                              )
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: model.onTapPickImage,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                color: AppColors.black,
                                image: DecorationImage(
                                    image: FileImage(File(pickedImage.path)),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                                right: 6,
                                top: 6,
                                child: GestureDetector(
                                    onTap: () => model.onTapDeletePhoto(),
                                    child: SvgPicture.asset(
                                        'assets/images/ic_delete_photo.svg'))),
                            Positioned(
                              bottom: 6,
                              child: Container(
                                height: 20,
                                decoration: const BoxDecoration(
                                    color: AppColors.black,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: const Center(
                                  child: Text(
                                    'Main photo',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                const SizedBox(height: 15),
                FloatingButtonWidget(
                  onTap: () async {
                    if (titleController.text.isEmpty ||
                        pickedImage == null ||
                        descriptionController.text.isEmpty) {
                      isPressedOnceNext = true;
                      setState(() {});
                    } else {
                      await model.createSpace(
                        titleController.text,
                        descriptionController.text,
                      );
                      await context.read<SpacesViewModel>().getSpaces();
                      Navigator.pop(context);
                    }
                  },
                  text: isLoading ? 'Loading' : 'Create Space',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
