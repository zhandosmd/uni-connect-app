import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uni_connect/domain/api_client/api_client.dart';

import 'modal_sheets/date_picker_sheet.dart';

class CreateEventViewModel extends ChangeNotifier {
  int currentTab = 0;
  bool isLoading = false;

  /// STEP 1
  DateTime? pickedDate;
  TimeOfDay? pickedTime;
  String? title;
  String? description;

  /// STEP 2
  final ImagePicker picker = ImagePicker();
  List<XFile> pickedImages = [];
  XFile? pickedStoryImage;

  final apiClient = ApiClient();

  // STEP 3
  String? cardNumber;
  String? price;
  String? ticketCount;

  void changeCurrentTab(int currentTab) {
    this.currentTab = currentTab;
    notifyListeners();
  }

  void saveFirstStep(String title, String description) {
    this.title = title;
    this.description = description;
    notifyListeners();
  }

  void saveThirdStep(String cardNumber, String price, String ticketCount) {
    this.cardNumber = cardNumber;
    this.price = price;
    this.ticketCount = ticketCount;

    notifyListeners();
  }

  void onTapNextPage() {
    if (currentTab < 2) {
      currentTab++;
      notifyListeners();
    } else {}
  }

  void onTapCancel(BuildContext context) {
    if (currentTab > 0) {
      currentTab--;
      notifyListeners();
    } else {
      Navigator.of(context).pop();
    }
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

  void changePickedDate(DateTime pickedDate) {
    this.pickedDate = pickedDate;
    notifyListeners();
  }

  void changePickedTime(TimeOfDay? pickedTime) {
    this.pickedTime = pickedTime;
    notifyListeners();
  }

  void onTapPickImage() async {
    pickedImages = List<XFile>.from(pickedImages)
      ..addAll(await picker.pickMultiImage());

    notifyListeners();
  }

  void onTapDeletePhoto(int index) {
    pickedImages = List<XFile>.from(pickedImages)..removeAt(index);

    notifyListeners();
  }

  void onTapPickStories() async {
    pickedStoryImage = await picker.pickImage(source: ImageSource.gallery);

    notifyListeners();
  }

  void onTapDeleteStories() {
    pickedStoryImage = null;

    notifyListeners();
  }

  Future<void> createEvent() async {
    List<File> fileImages = [];
    for (XFile image in pickedImages) {
      fileImages.add(File(image.path));
    }
    if (pickedStoryImage != null) {
      fileImages.add(File(pickedStoryImage!.path));
    }

    isLoading = true;
    notifyListeners();
    await apiClient.createEvent(
      title: title ?? '',
      date: DateFormat('MM.dd.yyyy').format(pickedDate ?? DateTime.now()),
      time: '${pickedTime?.hour}:${pickedTime?.minute}',
      description: description ?? '',
      cardNumber: cardNumber ?? '',
      price: price ?? '',
      ticketCount: ticketCount ?? '',
      images: fileImages,
    );
    isLoading = false;
    notifyListeners();
  }
}
