import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

import '../home/home_screen.dart';

class StoriesScreen extends StatelessWidget {
  final List<Story> stories;
  final int index;
  StoriesScreen ({Key? key, required this.stories, required this.index}) : super(key: key);
  final StoryController controller = StoryController();

  @override
  Widget build(BuildContext context) {
    List<StoryItem> storyItems = stories.mapIndexed((currentIndex, story) {
      return StoryItem.pageProviderImage(
        AssetImage(story.image),
        shown: currentIndex < index,
        caption: story.title
      );
    }).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: StoryView(
          storyItems: storyItems,
          controller: controller,
          repeat: true,
          onVerticalSwipeComplete: (direction) {
              if (direction == Direction.down) {
                Navigator.pop(context);
              }
            },
          ),
      )
    );
  }
}
