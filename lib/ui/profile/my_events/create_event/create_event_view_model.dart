import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'modal_sheets/date_picker_sheet.dart';

class CreateEventViewModel extends ChangeNotifier{
  int currentTab = 0;
  DateTime? pickedDate;
  TimeOfDay? pickedTime;
  final ImagePicker picker = ImagePicker();
  List<XFile> pickedImages = [];

  void changeCurrentTab(int currentTab){
    this.currentTab = currentTab;
    notifyListeners();
  }

  void onTapNextPage(){
    if(currentTab < 2){
      currentTab++;
      notifyListeners();
    }else{
      // TODO push next page
    }
  }

  void onTapCancel(BuildContext context){
    if(currentTab > 0){
      currentTab--;
      notifyListeners();
    }else{
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
        return DatePickerSheet(createContext: createContext,);
      }
    );
  }

  void changePickedDate(DateTime pickedDate){
    this.pickedDate = pickedDate;
    notifyListeners();
  }

  void changePickedTime(TimeOfDay? pickedTime){
    this.pickedTime = pickedTime;
    notifyListeners();
  }

  void onTapPickImage() async{
    pickedImages = List<XFile>.from(pickedImages)..addAll(await picker.pickMultiImage());

    notifyListeners();
  }

  void onTapDeletePhoto(int index){
    pickedImages = List<XFile>.from(pickedImages)..removeAt(index);

    notifyListeners();
  }
}