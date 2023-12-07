import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

void showLoadingAnimation(
    BuildContext context, String animationPath, double size) {
  showDialog(
    context: context,
    builder: (context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Lottie.asset(animationPath, width: size, height: size),
        ),
      );
    },
  );
}

void showDelayedLoadingAnimation(
  BuildContext context,
  String animationPath,
  double size,
  int? delayInSeconds,
) async {
  showDialog(
    context: context,
    builder: (context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: Center(
            child: Lottie.asset(animationPath, width: size, height: size),
          ),
        ),
      );
    },
  );

  // Check if delayInSeconds is provided and wait for that duration
  if (delayInSeconds != null && delayInSeconds > 0) {
    await Future.delayed(Duration(seconds: delayInSeconds))
        .whenComplete(() => Get.back());
  }
}
