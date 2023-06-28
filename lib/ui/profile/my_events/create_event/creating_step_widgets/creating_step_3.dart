import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/ui/profile/my_events/create_event/creating_step_widgets/succesfully_created.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import '../../../../common_widgets/floating_button_widget.dart';
import '../create_event_view_model.dart';

class CreateStep3Widget extends StatefulWidget {
  const CreateStep3Widget({Key? key}) : super(key: key);

  @override
  State<CreateStep3Widget> createState() => _CreateStep3WidgetState();
}

class _CreateStep3WidgetState extends State<CreateStep3Widget> {
  int isPaid = 0;
  bool isLimitedTickets = false;
  final TextEditingController priceController = TextEditingController();
  final TextEditingController ticketCountController = TextEditingController();

  final cardFormatter = MaskTextInputFormatter(
      mask: '#### #### #### ####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    final model = context.read<CreateEventViewModel>();
    final isLoading = context.select((CreateEventViewModel vm) => vm.isLoading);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 15),
        Container(
          height: 41,
          decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    isPaid = 0;
                    setState(() {});
                  },
                  child: Container(
                    height: 41,
                    decoration: BoxDecoration(
                        color:
                            isPaid == 1 ? AppColors.black : AppColors.mainColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: const Center(
                      child: Text('Free Tariff'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    isPaid = 1;
                    setState(() {});
                  },
                  child: Container(
                    height: 41,
                    decoration: BoxDecoration(
                        color:
                            isPaid == 0 ? AppColors.black : AppColors.mainColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: const Center(
                      child: Text('Paid Tariff'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (isPaid == 1)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              const Text(
                'Card number',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 15),
              Container(
                height: 44,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [cardFormatter],
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '---- ---- ---- ----',
                            hintStyle:
                                TextStyle(color: AppColors.gray, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Price (tenge)',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 15),
              Container(
                height: 44,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter price',
                            hintStyle:
                                TextStyle(color: AppColors.gray, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Limited tickets count',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            CupertinoSwitch(
                value: isLimitedTickets,
                activeColor: AppColors.mainColor,
                onChanged: (value) {
                  isLimitedTickets = value;
                  setState(() {});
                })
          ],
        ),
        if (isLimitedTickets)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Ticket count',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 15),
              Container(
                height: 44,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: ticketCountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter max ticket count',
                            hintStyle: TextStyle(
                              color: AppColors.gray,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        const SizedBox(
          height: 20,
        ),
        FloatingButtonWidget(
          onTap: () async {
            if (!isLoading) {
              model.saveThirdStep(
                cardFormatter.getUnmaskedText(),
                priceController.text,
                ticketCountController.text,
              );
              await model.createEvent();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const SuccessfullyCreatedScreen();
              }));
            }
          },
          text: isLoading ? 'Loading' : 'Publish Event',
        )
      ],
    );
  }
}
