import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/ui/spaces/create_space/create_space_screen.dart';
import 'package:uni_connect/ui/spaces/create_space/create_space_view_model.dart';
import 'package:uni_connect/ui/spaces/spaces_view_model.dart';

import '../space_info/space_info_screen.dart';
import '../space_info/space_info_view_model.dart';
import '../theme/app_colors.dart';

class SpacesScreen extends StatefulWidget {
  const SpacesScreen({Key? key}) : super(key: key);

  @override
  State<SpacesScreen> createState() => _SpacesScreenState();
}

class _SpacesScreenState extends State<SpacesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<SpacesViewModel>().getSpaces();
    });
  }

  @override
  Widget build(BuildContext context) {
    final spaces = context.select((SpacesViewModel vm) => vm.spaces);
    final isLoading = context.select((SpacesViewModel vm) => vm.isLoading);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Spaces',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return ChangeNotifierProvider(
                      create: (_) => CreateSpaceViewModel(),
                      child: const CreateSpaceScreen(),
                    );
                  }));
                },
                child: SvgPicture.asset('assets/images/ic_add.svg'),
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          const SizedBox(
            height: 22,
          ),
          Container(
            height: 48,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: AppColors.black),
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Row(
              children: [
                SvgPicture.asset('assets/images/ic_search.svg'),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search spaces...",
                        hintStyle: TextStyle(color: AppColors.gray)),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: isLoading
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    ],
                  )
                : RefreshIndicator.adaptive(
                    color: Colors.white,
                    onRefresh: () async {
                      context.read<SpacesViewModel>().getSpaces();
                    },
                    child: GridView.builder(
                      itemCount: spaces.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two items in a row
                        crossAxisSpacing:
                            10.0, // Spacing between items horizontally
                        mainAxisSpacing:
                            10.0, // Spacing between items vertically
                        childAspectRatio: 150 / 120, // Width/Height ratio
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return SpaceInfoScreen(
                                space: spaces[index],
                              );
                            }));
                          },
                          child: Container(
                              height: 120.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(spaces[index].image ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 11, vertical: 11),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      spaces[index].title ?? '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      '${spaces[index].postCount} posts',
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        );
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
