import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/ui/common_widgets/common_functions.dart';
import 'package:uni_connect/ui/profile/my_events/create_event/create_event_view_model.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import '../../../../common_widgets/floating_button_widget.dart';

class CreateStep1Widget extends StatefulWidget {
  const CreateStep1Widget({Key? key}) : super(key: key);

  @override
  State<CreateStep1Widget> createState() => _CreateStep1WidgetState();
}

class _CreateStep1WidgetState extends State<CreateStep1Widget> {
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
    final model = context.read<CreateEventViewModel>();
    final pickedDate =
        context.select((CreateEventViewModel vm) => vm.pickedDate);
    final pickedTime =
        context.select((CreateEventViewModel vm) => vm.pickedTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About event',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
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
              border: (isPressedOnceNext && titleController.text.isEmpty)
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => model.showDatePickerSheet(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Date',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 44,
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: (isPressedOnceNext && pickedDate == null)
                              ? Border.all(color: AppColors.red)
                              : null),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: pickedDate == null
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Pick a date',
                                  style: TextStyle(
                                      color: AppColors.placeHolder,
                                      fontSize: 12),
                                ),
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: AppColors.placeHolder,
                                  size: 20,
                                )
                              ],
                            )
                          : Center(
                              child: Text(
                                CommonFunctions.formatDateTimeToString(
                                    pickedDate),
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () async {
                model.changePickedTime(await showTimePicker(
                    initialEntryMode: TimePickerEntryMode.input,
                    context: context,
                    initialTime:
                        pickedTime ?? const TimeOfDay(hour: 19, minute: 30)));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Time',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 44,
                    width: 150,
                    decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: (isPressedOnceNext && pickedTime == null)
                            ? Border.all(color: AppColors.red)
                            : null),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: pickedTime == null
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pick a time',
                                style: TextStyle(
                                    color: AppColors.placeHolder, fontSize: 12),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: AppColors.placeHolder,
                                size: 20,
                              )
                            ],
                          )
                        : Center(
                            child: Text(
                              '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
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
              border: (isPressedOnceNext && descriptionController.text.isEmpty)
                  ? Border.all(color: AppColors.red)
                  : null),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
        FloatingButtonWidget(
          onTap: () {
            if (titleController.text.isEmpty ||
                pickedDate == null ||
                pickedTime == null ||
                descriptionController.text.isEmpty) {
              isPressedOnceNext = true;
              setState(() {});
            } else {
              model.saveFirstStep(
                titleController.text,
                descriptionController.text,
              );
              model.onTapNextPage();
            }
          },
          text: 'Next',
        )
      ],
    );
  }
}
