import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_connect/domain/api_client/api_client.dart';

import '../../profile/my_events/create_event/modal_sheets/date_picker_sheet.dart';

class CreatePostViewModel extends ChangeNotifier {
  bool isLoading = false;

  final ImagePicker picker = ImagePicker();
  DateTime? pickedDate;
  List<XFile> pickedImages = [];
  final apiClient = ApiClient();

  void onTapPickImage() async {
    pickedImages = await picker.pickMultiImage();

    notifyListeners();
  }

  void onTapDeletePhoto(int index) {
    pickedImages = List<XFile>.from(pickedImages)..removeAt(index);

    notifyListeners();
  }

  void showDatePickerSheet(BuildContext createContext) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: createContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return DatePickerSheet(
          createContext: createContext,
        );
      },
    );
  }

  Future<void> createSpace(String description) async {
    isLoading = true;
    notifyListeners();
    // apiClient.createSpace(
    //   title: title,
    //   description: description,
    //   image: pickedImage == null ? null : File(pickedImage!.path),
    // );
    isLoading = false;
    notifyListeners();
  }
}
