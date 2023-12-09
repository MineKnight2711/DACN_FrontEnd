import 'package:flutter/material.dart';
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

Future<void> showDelayedLoadingAnimation(
  BuildContext context,
  String animationPath,
  double size,
  int? delayInSeconds,
) async {
  showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Lottie.asset(animationPath, width: size, height: size),
          ),
        );
      });

  // Wait if delay specified
  if (delayInSeconds != null && delayInSeconds > 0) {
    return await Future.delayed(Duration(seconds: delayInSeconds))
        .whenComplete(() => Get.back());
  }
}
