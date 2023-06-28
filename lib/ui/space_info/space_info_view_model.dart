import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_connect/domain/api_client/api_client.dart';
import 'package:uni_connect/domain/entities/space_details.dart';
import 'package:uni_connect/ui/space_info/create_post/create_post_screen.dart';

import 'create_post/create_post_view_model.dart';

class SpaceInfoViewModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  SpaceDetails? spaceDetails;
  bool isLoading = false;

  Future<void> getSpaceDetails(String? id) async {
    isLoading = true;
    notifyListeners();
    spaceDetails = await _apiClient.getSpaceDetails(id);
    isLoading = false;
    notifyListeners();
  }

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
          child: CreatePostScreen(
            spaceId: spaceDetails?.id,
          ),
        );
      },
    );
  }
}
