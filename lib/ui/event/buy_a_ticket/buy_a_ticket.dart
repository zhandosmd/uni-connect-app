import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../theme/app_colors.dart';

class BuyATicketScreen extends StatefulWidget {
  const BuyATicketScreen({Key? key}) : super(key: key);

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
                    child: SvgPicture.asset('assets/images/ic_chevron_left.svg')
                  ),
                  const Text('Ice party', style: TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 18
                  ),),
                  const SizedBox(width: 20,)
                ],
              ),
            ),
            const SizedBox(height: 20,),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Image.asset('assets/images/im_ice_party.png')
            ),
            const SizedBox(height: 20,),
            Container(
              height: 60,
              decoration: const BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: Row(
                  children: const [
                    Text('Price', style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      '7000 ₸'
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              height: 60,
              decoration: const BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: const Center(
                child: Text(
                    'Extra Information or suggestions'
                ),
              ),
            ),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 48,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppColors.mainColor
                ),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: const Center(
                  child: Text('Upload receipt')
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
