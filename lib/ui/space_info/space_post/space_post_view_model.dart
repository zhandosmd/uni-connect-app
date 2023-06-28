import 'package:flutter/cupertino.dart';
import 'package:uni_connect/domain/api_client/api_client.dart';
import 'package:uni_connect/domain/entities/post_details.dart';

class SpacePostViewModel extends ChangeNotifier {
  PostDetails? postDetails;
  final apiClient = ApiClient();
  bool isLoading = false;

  Future<void> getPostDetails(String? postId) async {
    isLoading = true;
    notifyListeners();
    postDetails = await apiClient.getPostDetails(postId);
    isLoading = false;
    notifyListeners();
  }

  Future<void> commentPost(
      String? spaceId, String? postId, String comment) async {
    await apiClient.commentPost(spaceId, postId, comment);
    await getPostDetails(postId);
  }
}
