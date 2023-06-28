import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import '../../core/utils/date_formatter.dart';
import '../../domain/entities/event.dart';
import 'buy_a_ticket/buy_a_ticket.dart';
import 'event_view_model.dart';
import 'package:collection/collection.dart';

class EventScreen extends StatefulWidget {
  final Event event;
  const EventScreen({Key? key, required this.event}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<EventViewModel>().changeIsLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((EventViewModel vm) => vm.isLoading);

    return Scaffold(
      body: isLoading
          ? const SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  )
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  if ((widget.event.images ?? []).isNotEmpty)
                    Stack(
                      children: [
                        Image.network(widget.event.images?.firstOrNull ?? ''),
                        Positioned(
                          top: 20,
                          left: 16,
                          child: SafeArea(
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(999)),
                                    color: AppColors.mainColor),
                                padding: const EdgeInsets.all(5),
                                child: SvgPicture.asset(
                                  'assets/images/ic_chevron_left.svg',
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.event.title ?? '',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  dateFormat(
                                      widget.event.createdAt ?? DateTime.now()),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            const Spacer(),
                            SvgPicture.asset('assets/images/ic_heart.svg'),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          widget.event.description ??
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra nulla sapien, '
                                  'sed congue quam aliquam suscipit. Maecenas et nunc ut neque facilisis euismod. Vestibulum '
                                  'condimentum ligula et ligula cursus ultricies. Nulla a mauris sed velit tincidunt pretium. '
                                  'Nunc at ipsum ut dui posuere rhoncus. Mauris sit amet consequat mi, et porttitor diam. '
                                  'In vitae nunc risus. Etiam venenatis sollicitudin massa eget luctus.',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          '"Мы сократили зарплаты казахстанским футболистам, теперь потолок — полтора миллиона тенге. Если приходит молодой футболист, он изначально получает 500 тысяч тенге. Мы считаем, что казахстанские футболисты не соответствуют тем зарплатам, которые они получали. За такие деньги они должны были играть минимум в РПЛ. Мы со всеми хорошо расстались. Кто-то считает, что должен зарабатывать больше, ради бога, у нас в клубе не будет высоких зарплат для казахстанцев.',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Contacts',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 90,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: AppColors.black),
                          padding: const EdgeInsets.symmetric(horizontal: 21),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/im_profile_ava.png',
                                height: 51,
                                width: 51,
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nursat Bakyt',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    '190103001@stu.sdu.edu.kz',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 8),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    '+7 (747) 434-12-35',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 8),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return BuyATicketScreen(
                                event: widget.event,
                              );
                            }));
                          },
                          child: Container(
                            height: 48,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: AppColors.mainColor,
                            ),
                            child: Center(
                              child: Text(
                                'Order (0/${widget.event.ticketCount} sold)',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
