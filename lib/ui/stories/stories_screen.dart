import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoriesScreen extends StatelessWidget {
  StoriesScreen ({Key? key}) : super(key: key);
  final StoryController controller = StoryController();

  @override
  Widget build(BuildContext context) {
    List<StoryItem> storyItems = [
      StoryItem.pageImage(url: "https://images.unsplash.com/photo-1553531384-cc64ac80f931?ixid=MnwxMjA3fDF8MHxzZWFyY2h8MXx8bW91bnRhaW58ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60", controller: controller),
      StoryItem.pageImage(url: "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg", controller: controller),
      StoryItem.pageImage(url: "https://images.unsplash.com/photo-1553531384-cc64ac80f931?ixid=MnwxMjA3fDF8MHxzZWFyY2h8MXx8bW91bnRhaW58ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60", controller: controller),
    ];

    return Scaffold(
      body: StoryView(
        storyItems: storyItems,
        controller: controller,
        repeat: true,
        onVerticalSwipeComplete: (direction) {
            if (direction == Direction.down) {
              Navigator.pop(context);
            }
          },
        )
    );
  }
}
