import 'package:flutter/material.dart';
import 'package:uni_connect/ui/theme/app_colors.dart';

abstract class LoadingDialog{
  static Future<void> showLoadingDialog(BuildContext context) async {

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: AppColors.black,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator.adaptive(backgroundColor: Colors.white,),
                    SizedBox(height: 20,),
                    Text('Publishing event')
                  ],
                ),
              ),
            ),
          );
        }
    );
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pop();
  }
}