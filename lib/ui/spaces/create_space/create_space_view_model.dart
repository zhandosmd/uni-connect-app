import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_connect/domain/api_client/api_client.dart';

class CreateSpaceViewModel extends ChangeNotifier {
  bool isLoading = false;

  final ImagePicker picker = ImagePicker();
  XFile? pickedImage;
  final apiClient = ApiClient();

  void onTapPickImage() async {
    pickedImage = await picker.pickImage(source: ImageSource.gallery);

    notifyListeners();
  }

  void onTapDeletePhoto() {
    pickedImage = null;

    notifyListeners();
  }

  Future<void> createSpace(String title, String description) async {
    isLoading = true;
    notifyListeners();
    await apiClient.createSpace(
      title: title,
      description: description,
      image: pickedImage == null ? null : File(pickedImage!.path),
    );
    isLoading = false;
    notifyListeners();
  }
}
