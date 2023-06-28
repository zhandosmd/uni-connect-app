import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uni_connect/domain/entities/space_details.dart';
import 'package:uni_connect/ui/space_info/space_info_view_model.dart';
import 'package:uni_connect/ui/space_info/space_post/space_post_screen.dart';
import 'package:uni_connect/ui/space_info/widgets/space_post_widget.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import '../../domain/entities/space.dart';

class SpaceInfoScreen extends StatefulWidget {
  // final SpaceLocal space;
  final Space space;

  const SpaceInfoScreen({Key? key, required this.space}) : super(key: key);

  @override
  State<SpaceInfoScreen> createState() => _SpaceInfoScreenState();
}

class _SpaceInfoScreenState extends State<SpaceInfoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SpaceInfoViewModel>().getSpaceDetails(widget.space.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<SpaceInfoViewModel>();
    // final spacePosts = context.select((SpaceInfoViewModel vm) => vm.spacePosts);
    final isLoading = context.select((SpaceInfoViewModel vm) => vm.isLoading);
    final spaceDetails =
        context.select((SpaceInfoViewModel vm) => vm.spaceDetails);

    return Scaffold(
      body: isLoading
          ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Column(
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
                  SizedBox(
                    height: 130,
                    child: Stack(
                      children: [
                        Image.asset(
                          'assets/images/im_kz_acm_community.jpeg',
                          height: 130,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          left: 16,
                          child: SafeArea(
                            child: GestureDetector(
                                onTap: Navigator.of(context).pop,
                                child: const Icon(
                                  Icons.chevron_left,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(999)),
                                child: Image.network(
                                  widget.space.image ?? '',
                                  height: 80,
                                  width: 80,
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.space.title ?? '',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.done_all,
                                      color: Colors.grey,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'You subscribed',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '·',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '6.3K Subscribers',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () => model.showCreatePost(context),
                          child: Container(
                            height: 30,
                            decoration: const BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Suggest Post',
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Icon(
                                  Icons.post_add,
                                  color: Colors.white,
                                  size: 16,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return SpacePostScreen(
                                spaceDetails: spaceDetails,
                                postId: spaceDetails?.posts?[index].id);
                          }));
                        },
                        child: SpacePostWidget(
                          spaceDetails: spaceDetails,
                          post: spaceDetails?.posts?[index],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: spaceDetails?.posts?.length ?? 0,
                  ),
                ],
              ),
            ),
    );
  }
}
