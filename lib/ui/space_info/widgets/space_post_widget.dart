import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../domain/entities/post.dart';
import '../../../domain/entities/space_details.dart';
import '../../theme/app_colors.dart';

class SpacePostWidget extends StatelessWidget {
  final SpaceDetails? spaceDetails;
  final Post? post;

  const SpacePostWidget({
    super.key,
    required this.spaceDetails,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(999)),
                child: Image.network(
                  spaceDetails?.image ?? '',
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    spaceDetails?.title ?? '',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    '10 may, 10:15',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Text(post?.description ?? ''),
          const SizedBox(
            height: 2,
          ),
          Image.network(post?.image ?? ''),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(999),
                  ),
                  color: AppColors.backgroundColor,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                child: Row(
                  children: [
                    const Icon(
                      Icons.favorite,
                      color: AppColors.red,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(post?.likesCount.toString() ?? '0')
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Share.share("https://uniconnect.kz/post/142");
                },
                child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(999)),
                      color: AppColors.backgroundColor),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.reply,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('0')
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(999)),
                    color: AppColors.backgroundColor),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                child: Row(
                  children: [
                    const Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(post?.likesCount.toString() ?? '0')
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
