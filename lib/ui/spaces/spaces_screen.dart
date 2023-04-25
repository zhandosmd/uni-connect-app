import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../space_info/space_info_screen.dart';
import '../space_info/space_info_view_model.dart';
import '../theme/app_colors.dart';

class Space{
  final String imageUrl;
  final String name;
  final String text;

  Space({
    required this.imageUrl,
    required this.name,
    required this.text,
  });
}

class SpacesScreen extends StatelessWidget {
  SpacesScreen({Key? key}) : super(key: key);
  final List<Space> spaces = [
    Space(imageUrl: 'assets/images/image 3-2.png', name: 'ACM Community', text: '163 posts'),
    Space(imageUrl: 'assets/images/image 3-3.png', name: 'Eat&Chat', text: '255 posts'),
    Space(imageUrl: 'assets/images/image 3-4.png', name: 'Uni Activities', text: '766 posts'),
    Space(imageUrl: 'assets/images/image 3-5.png', name: 'SDU Football League', text: '175 posts'),
    Space(imageUrl: 'assets/images/image 3-6.png', name: 'Lost and Found SDU', text: '255 posts'),
    Space(imageUrl: 'assets/images/image 3-7.png', name: 'Startup Garage', text: '1163 posts'),
    Space(imageUrl: 'assets/images/image 3-8.png', name: 'Designers SDU', text: '163 posts'),
    Space(imageUrl: 'assets/images/image 3-4.png', name: 'Eat&Chat', text: '255 posts'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              const Text('Spaces', style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w700
              ),),
              const Spacer(),
              SvgPicture.asset('assets/images/ic_add.svg'),
              const SizedBox(width: 20,)
            ],
          ),
          const SizedBox(height: 22,),
          Container(
            height: 48,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppColors.black
            ),
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              children: [
                SvgPicture.asset('assets/images/ic_search.svg'),
                const SizedBox(width: 10,),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search spaces...",
                      hintStyle: TextStyle(color: AppColors.gray)
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: GridView.builder(
              itemCount: spaces.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two items in a row
                crossAxisSpacing: 10.0, // Spacing between items horizontally
                mainAxisSpacing: 10.0, // Spacing between items vertically
                childAspectRatio: 150/120, // Width/Height ratio
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return ChangeNotifierProvider(
                            create: (_) => SpaceInfoViewModel(),
                            child: const SpaceInfoScreen()
                          );
                        }
                      )
                    );
                  },
                  child: Container(
                    height: 120.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(spaces[index].imageUrl),
                        fit: BoxFit.cover
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            spaces[index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          Text(
                            spaces[index].text,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                    )
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
