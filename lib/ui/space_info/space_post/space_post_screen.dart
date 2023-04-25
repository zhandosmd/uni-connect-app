import 'package:flutter/material.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

import '../space_info_screen.dart';
import '../space_info_view_model.dart';

class Comment{
  final String name;
  final String date;
  final String comment;
  final String imageUrl;

  Comment({
    required this.name,
    required this.date,
    required this.comment,
    required this.imageUrl,
  });
}

class SpacePostScreen extends StatelessWidget {
  final SpacePost spacePost;
  SpacePostScreen({Key? key, required this.spacePost}) : super(key: key);
  final List<Comment> comments = [
    Comment(
      name: 'Pavel Durov',
      date: '10 may, 15:12',
      comment: 'Oh, good to know!',
      imageUrl: 'assets/images/im_post_ava_1.jpg',
    ),
    Comment(
      name: 'Robert Martin',
      date: '10 may, 18:54',
      comment: 'Come on guys, use some SOLID on it',
      imageUrl: 'assets/images/im_post_ava_2.png',
    ),
    Comment(
      name: 'Narikbi Maksut',
      date: '11 may, 09:12',
      comment: 'Very interesting topic!!',
      imageUrl: 'assets/images/im_post_ava_3.jpeg',
    ),
    Comment(
      name: 'Amanchik',
      date: '11 may, 10:54',
      comment: 'Lol, this topic was on my interview on Google!',
      imageUrl: 'assets/images/im_post_ava_4.jpeg',
    ),
    Comment(
      name: 'Pavel Durov',
      date: '10 may, 15:12',
      comment: 'Oh, good to know!',
      imageUrl: 'assets/images/im_post_ava_1.jpg',
    ),
    Comment(
      name: 'Robert Martin',
      date: '10 may, 18:54',
      comment: 'Come on guys, use some SOLID on it',
      imageUrl: 'assets/images/im_post_ava_2.png',
    ),
    Comment(
      name: 'Narikbi Maksut',
      date: '11 may, 09:12',
      comment: 'Very interesting topic!!',
      imageUrl: 'assets/images/im_post_ava_3.jpeg',
    ),
    Comment(
      name: 'Amanchik',
      date: '11 may, 10:54',
      comment: 'Lol, this topic was on my interview on Google!',
      imageUrl: 'assets/images/im_post_ava_4.jpeg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child: const Icon(Icons.chevron_left, color: Colors.white,)
                  ),
                  const Text('Post', style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w500
                  ),),
                  const SizedBox(width: 24,)
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    SpacePostWidget(
                        spacePost: spacePost
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: const [
                        SizedBox(width: 16,),
                        Text('10 Comments', style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500
                        ),),
                        Spacer(),
                        Text('Interesting at first'),
                        Icon(Icons.arrow_drop_down, color: Colors.white,),
                        SizedBox(width: 16,),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return PostCommentWidget(
                            comment: comments[index],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 15,);
                        },
                        itemCount: comments.length,
                      ),
                    ),
                    const SizedBox(height: 80,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(208, 208, 208, 1.0),
                borderRadius: BorderRadius.circular(999)
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Center(
                child: TextField(
                  cursorColor: AppColors.mainColor,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  ),
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5,),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(999)
            ),
            child: const Icon(Icons.add_comment, color: Colors.white, size: 18,),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class PostCommentWidget extends StatelessWidget {
  final Comment comment;
  const PostCommentWidget({
    super.key,
    required this.comment
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(999)),
          child: Image.asset(comment.imageUrl, height: 50, width: 50, fit: BoxFit.cover,)
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(comment.name, style: const TextStyle(
                fontSize: 12,
              ),),
              const SizedBox(height: 5,),
              Text(comment.comment, style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500
              ),),
              const SizedBox(height: 5,),
              Text(comment.date, style: const TextStyle(
                fontSize: 12, color: Colors.grey
              ),),
            ],
          ),
        )
      ],
    );
  }
}
