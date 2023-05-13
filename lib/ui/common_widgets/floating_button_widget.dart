import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class FloatingButtonWidget extends StatelessWidget {
  final String text;
  final Widget? child;
  final void Function() onTap;
  const FloatingButtonWidget({Key? key, required this.text, required this.onTap, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: const BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Center(
          child: child ?? Text(
            text,
            style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700
            ),
          ),
        ),
      ),
    );
  }
}
