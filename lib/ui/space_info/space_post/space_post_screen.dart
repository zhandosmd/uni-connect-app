import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/core/utils/date_formatter.dart';
import 'package:uni_connect/domain/entities/space_details.dart';
import 'package:uni_connect/ui/space_info/space_post/space_post_view_model.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';
import 'package:collection/collection.dart';

import '../../../domain/entities/post_details.dart';
import '../widgets/space_post_widget.dart';

class SpacePostScreen extends StatefulWidget {
  final SpaceDetails? spaceDetails;
  final String? postId;

  const SpacePostScreen({
    Key? key,
    required this.postId,
    required this.spaceDetails,
  }) : super(key: key);

  @override
  State<SpacePostScreen> createState() => _SpacePostScreenState();
}

class _SpacePostScreenState extends State<SpacePostScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<SpacePostViewModel>().getPostDetails(widget.postId);
    });
  }

  bool isLoadingComment = false;
  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((SpacePostViewModel vm) => vm.isLoading);
    final postDetails =
        context.select((SpacePostViewModel vm) => vm.postDetails);

    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const CircularProgressIndicator.adaptive()
            : Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: Navigator.of(context).pop,
                            child: const Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                            )),
                        const Text(
                          'Post',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 24,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          SpacePostWidget(
                            spaceDetails: widget.spaceDetails,
                            post: widget.spaceDetails?.posts?.firstWhereOrNull(
                                (element) => element.id == widget.postId),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                '${(postDetails?.commentsCount ?? 0).toString()} Comments',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const Spacer(),
                              const Text('Interesting at first'),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return PostCommentWidget(
                                  comment: postDetails?.comments?[index],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 15,
                                );
                              },
                              itemCount: postDetails?.comments?.length ?? 0,
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
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
                  borderRadius: BorderRadius.circular(999)),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: TextField(
                  controller: commentController,
                  cursorColor: AppColors.mainColor,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  ),
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () async {
              isLoadingComment = true;
              setState(() {});
              await context.read<SpacePostViewModel>().commentPost(
                    widget.spaceDetails?.id,
                    widget.postId,
                    commentController.text,
                  );
              isLoadingComment = false;
              setState(() {});
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(999)),
              child: isLoadingComment
                  ? const CircularProgressIndicator()
                  : const Icon(
                      Icons.add_comment,
                      color: Colors.white,
                      size: 18,
                    ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class PostCommentWidget extends StatelessWidget {
  final Comment? comment;
  const PostCommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (comment?.user?.image != null)
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(999)),
            child: Image.network(
              comment?.user?.image ?? '',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment?.user?.fullname ?? '',
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                comment?.text ?? '',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                dateFormat(DateTime.now()),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        )
      ],
    );
  }
}
