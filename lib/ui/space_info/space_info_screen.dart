import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uni_connect/ui/space_info/space_info_view_model.dart';
import 'package:uni_connect/ui/space_info/space_post/space_post_screen.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import '../../domain/entities/space.dart';

class SpaceInfoScreen extends StatefulWidget {
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
      context.read<SpaceInfoViewModel>().changeIsLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final spacePosts = context.select((SpaceInfoViewModel vm) => vm.spacePosts);
    final isLoading = context.select((SpaceInfoViewModel vm) => vm.isLoading);

    return Scaffold(
      body: isLoading
      ? SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator.adaptive(backgroundColor: Colors.white,)
          ],
        ),
      )
      : Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/im_kz_acm_community.jpeg',
                height: 130, width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 16,
                child: SafeArea(
                  child: GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child: const Icon(Icons.chevron_left, color: Colors.black,)
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(999)),
                      child: Image.asset(
                        widget.space.imageUrl,
                        height: 80,
                        width: 80,)
                    ),
                    const SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.space.name, style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500
                        ),),
                        const SizedBox(height: 10,),
                        Row(
                          children: const [
                            Icon(Icons.done_all, color: Colors.grey, size: 18,),
                            SizedBox(width: 10,),
                            Text('You subscribed', style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey,
                            ),),
                            SizedBox(width: 5,),
                            Text('·', style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey,
                            ),),
                            SizedBox(width: 5,),
                            Text('6.3K Subscribers', style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey,
                            ),),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: 30,
                    decoration: const BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Suggest Post', style: TextStyle(
                          fontSize: 12
                        ),),
                        SizedBox(width: 6,),
                        Icon(Icons.post_add, color: Colors.white, size: 16,)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return SpacePostScreen(
                              spacePost: spacePosts[index],
                              space: widget.space,
                            );
                          }
                        )
                      );
                    },
                    child: SpacePostWidget(
                      spacePost: spacePosts[index],
                      space: widget.space,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
                itemCount: spacePosts.length,
              )
            ),
          ),
        ],
      ),
    );
  }
}

class SpacePostWidget extends StatelessWidget {
  final SpacePost spacePost;
  final Space space;

  const SpacePostWidget({
    super.key,
    required this.spacePost,
    required this.space,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(999)),
                child: Image.asset(space.imageUrl, height: 50, width: 50,)
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('acm community sdu', style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500
                  ),),
                  SizedBox(height: 5,),
                  Text('10 may, 10:15', style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.gray
                  ),),
                ],
              )
            ],
          ),
          const SizedBox(height: 2,),
          Text(
            spacePost.text
          ),
          const SizedBox(height: 2,),
          Image.asset(spacePost.imageUrl),
          const SizedBox(height: 5,),
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(999)),
                  color: AppColors.backgroundColor
                ),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                child: Row(
                  children: [
                    const Icon(Icons.favorite, color: AppColors.red,),
                    const SizedBox(width: 5,),
                    Text(spacePost.likeCounts)
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Share.share("https://uniconnect.kz/post/142");
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(999)),
                    color: AppColors.backgroundColor
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  child: Row(
                    children: [
                      const Icon(Icons.reply, color: Colors.white,),
                      const SizedBox(width: 5,),
                      Text(spacePost.replyCounts)
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(999)),
                  color: AppColors.backgroundColor
                ),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                child: Row(
                  children: [
                    const Icon(Icons.remove_red_eye_outlined, color: Colors.white,),
                    const SizedBox(width: 5,),
                    Text(spacePost.viewCounts)
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5,),
        ],
      ),
    );
  }
}
