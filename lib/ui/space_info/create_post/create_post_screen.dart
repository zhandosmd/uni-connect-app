import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/ui/space_info/create_post/create_post_view_model.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import '../../common_widgets/common_functions.dart';
import '../space_info_view_model.dart';

class CreatePostScreen extends StatefulWidget {
  final String? spaceId;
  const CreatePostScreen({
    Key? key,
    required this.spaceId,
  }) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
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
    final model = context.read<CreatePostViewModel>();
    final pickedImage =
        context.select((CreatePostViewModel vm) => vm.pickedImage);
    final isLoading = context.select((CreatePostViewModel vm) => vm.isLoading);
    final pickedDate =
        context.select((CreatePostViewModel vm) => vm.pickedDate);

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30,
              color: AppColors.backgroundColor,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 3,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Create Post',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.black,
                  border:
                      (isPressedOnceNext && descriptionController.text.isEmpty)
                          ? Border.all(color: AppColors.red)
                          : null,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
            ),
            if (pickedImage != null)
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
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
                      onTap: () => model.onTapDeletePhoto,
                      child: SvgPicture.asset(
                        'assets/images/ic_delete_photo.svg',
                      ),
                    ),
                  ),
                ],
              ),
            if (pickedDate != null)
              Center(
                child: Text(
                  CommonFunctions.formatDateTimeToString(pickedDate),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: model.onTapPickImage,
                    child: const Icon(
                      CupertinoIcons.photo,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    // onTap: () => model.showDatePickerSheet(context),
                    child: const Icon(
                      CupertinoIcons.time,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : GestureDetector(
                          onTap: () async {
                            await model.createPost(
                              descriptionController.text,
                              widget.spaceId,
                            );
                            await context
                                .read<SpaceInfoViewModel>()
                                .getSpaceDetails(widget.spaceId);
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
