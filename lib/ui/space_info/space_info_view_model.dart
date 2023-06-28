import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/domain/api_client/api_client.dart';
import 'package:uni_connect/domain/entities/space_details.dart';
import 'package:uni_connect/ui/space_info/create_post/create_post_screen.dart';

import 'create_post/create_post_view_model.dart';

class SpacePost {
  final String text;
  final String imageUrl;
  final String date;
  final String likeCounts;
  final String replyCounts;
  final String viewCounts;

  SpacePost({
    required this.text,
    required this.imageUrl,
    required this.date,
    required this.likeCounts,
    required this.replyCounts,
    required this.viewCounts,
  });
}

class SpaceInfoViewModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  SpaceDetails? spaceDetails;
  bool isLoading = true;

  void changeIsLoading(bool isLoading) async {
    await Future.delayed(const Duration(milliseconds: 100));
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future<void> getSpaceDetails(String? id) async {
    spaceDetails = await _apiClient.getSpaceDetails(id);
  }

  List<SpacePost> spacePosts = [
    SpacePost(
        text:
            'If all nodes in the graph are scattered across the screen, it will become hard to follow the lines between them. The approach I took is based on the paper "A technique for drawing directed graphs (1993)". It is a technique based on finding a (local) minimum in the number of crossing edges, as visualized below. My implementation consists out of three steps: (1) rank all nodes, (2) optimize the order of the nodes, and (3) determine the position of each node.',
        imageUrl: 'assets/images/im_graph-example-1.png',
        likeCounts: '1',
        replyCounts: '0',
        viewCounts: '2',
        date: '10 may, 10:15'),
    SpacePost(
        text:
            'Competitive programming is a sport where contestants solve algorithmic problems within a time limit using a programming language of their choice. It tests problem-solving skills, knowledge of algorithms, and ability to write efficient code.',
        imageUrl: 'assets/images/im_Competitive-Programming.png',
        likeCounts: '2',
        replyCounts: '0',
        viewCounts: '3',
        date: '8 may, 08:15'),
    SpacePost(
        text:
            'The example graph used before has two crossing edges. By applying the above heuristic, we can optimize this by applying two mutations, as visualized above. When we swap nodes 2 and 3, we are getting the same score of 2. This means to apply the mutation and continue. Nodes 2 and 9 cannot be swapped, as it worsens the score of the graph.',
        imageUrl: 'assets/images/im_graph-example-3.png',
        likeCounts: '1',
        replyCounts: '1',
        viewCounts: '5',
        date: '5 may, 16:15'),
    SpacePost(
        text:
            'Graphs can be: Undirected: if for every pair of connected nodes, you can go from one node to the other in both directions.Directed: if for every pair of connected nodes, you can only go from one node to another in a specific direction. We use arrows instead of simple lines to represent directed edges.',
        imageUrl: 'assets/images/im_type_graphs.png',
        likeCounts: '1',
        replyCounts: '0',
        viewCounts: '4',
        date: '1 may, 14:15'),
  ];

  void showCreatePost(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ChangeNotifierProvider(
          create: (_) => CreatePostViewModel(),
          child: const CreatePostScreen(),
        );
      },
    );
  }
}
