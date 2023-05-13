import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/ui/profile/my_events/create_event/create_event_screen.dart';
import 'package:uni_connect/ui/profile/my_events/create_event/create_event_view_model.dart';

import '../../event/event_screen.dart';
import '../../theme/app_colors.dart';
import 'my_events_view_model.dart';

class MyEventsScreen extends StatelessWidget {
  const MyEventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myEvents = context.select((MyEventsViewModel vm) => vm.myEvents);

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: SvgPicture.asset('assets/images/ic_chevron_left.svg')
                        ),
                      ),
                    ),
                    const Text('My Events', style: TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 22
                    ),),
                    SizedBox(
                      width: 100,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return ChangeNotifierProvider(
                                create: (_) => CreateEventViewModel(),
                                child: CreateEventScreen()
                              );
                            })
                          ),
                          child: SvgPicture.asset('assets/images/ic_add.svg'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      final currentEvent = myEvents[index];

                      return GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return EventScreen(event: currentEvent);
                              }
                            )
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 32,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: AppColors.black
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                child: Image.asset(
                                  currentEvent.imageUrl,
                                  alignment: Alignment.topCenter,
                                  width: MediaQuery.of(context).size.width - 32,
                                  height: 158,
                                  fit: BoxFit.cover,
                                )
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 13),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currentEvent.title, style: const TextStyle(
                                        fontWeight: FontWeight.w700
                                    ),),
                                    const SizedBox(height: 4,),
                                    FittedBox(
                                      child: Text(currentEvent.place, style: const TextStyle(
                                          fontSize: 12
                                      ),),
                                    ),
                                    const SizedBox(height: 4,),
                                    Text(currentEvent.date, style: const TextStyle(
                                      fontSize: 12
                                    ),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 20,);
                    },
                    itemCount: myEvents.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
