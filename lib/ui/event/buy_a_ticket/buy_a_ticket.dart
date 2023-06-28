import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/event.dart';
import '../../theme/app_colors.dart';
import 'package:collection/collection.dart';

class BuyATicketScreen extends StatefulWidget {
  final Event event;
  const BuyATicketScreen({Key? key, required this.event}) : super(key: key);

  @override
  State<BuyATicketScreen> createState() => _BuyATicketScreenState();
}

class _BuyATicketScreenState extends State<BuyATicketScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

  Future<void> pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      'assets/images/ic_chevron_left.svg',
                    ),
                  ),
                  Text(
                    widget.event.title ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Image.network(widget.event.images?.firstOrNull ?? ''),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              decoration: const BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: Row(
                  children: [
                    const Text(
                      'Price',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Spacer(),
                    Text('${widget.event.price} ₸'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              decoration: const BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                    'Card number: ${widget.event.cardNumber.toString().substring(0, 4)} ${widget.event.cardNumber.toString().substring(4, 8)} ${widget.event.cardNumber.toString().substring(8, 12)} ${widget.event.cardNumber.toString().substring(12, 16)}'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 48,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: AppColors.mainColor),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: const Center(
                  child: Text('Upload receipt'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
