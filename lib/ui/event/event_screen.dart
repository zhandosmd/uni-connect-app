import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import '../../domain/entities/event.dart';
import 'buy_a_ticket/buy_a_ticket.dart';

class EventScreen extends StatelessWidget {
  final Event event;
  const EventScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/im_ice_party.png'),
                Positioned(
                  top: 20,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset('assets/images/ic_chevron_left.svg')
                  )
                )
              ],
            ),
            const SizedBox(height: 24,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Ice party', style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700
                          ),),
                          SizedBox(height: 3,),
                          Text('21 march, 16:23', style: TextStyle(
                              fontSize: 12
                          ),),
                        ],
                      ),
                      const Spacer(),
                      SvgPicture.asset('assets/images/ic_heart.svg'),
                    ],
                  ),
                  const SizedBox(height: 24,),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra nulla sapien, '
                    'sed congue quam aliquam suscipit. Maecenas et nunc ut neque facilisis euismod. Vestibulum '
                    'condimentum ligula et ligula cursus ultricies. Nulla a mauris sed velit tincidunt pretium. '
                    'Nunc at ipsum ut dui posuere rhoncus. Mauris sit amet consequat mi, et porttitor diam. '
                    'In vitae nunc risus. Etiam venenatis sollicitudin massa eget luctus.',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16,),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Contacts', style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700
                    ),),
                  ),
                  const SizedBox(height: 16,),
                  Container(
                    height: 90,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: AppColors.black
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 21),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/im_profile_ava.png', height: 51, width: 51,),
                        const SizedBox(width: 24,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('John Doe', style: TextStyle(
                                fontWeight: FontWeight.w700
                            ),),
                            SizedBox(height: 3,),
                            Text('190103001@stu.sdu.edu.kz', style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 8
                            ),),
                            SizedBox(height: 3,),
                            Text('+7 (707) 777-77-77', style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 8
                            ),)
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16,),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return BuyATicketScreen();
                          }
                        )
                      );
                    },
                    child: Container(
                      height: 48,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: AppColors.mainColor
                      ),
                      child: const Center(
                        child: Text('Order (21/100 sold)')
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
