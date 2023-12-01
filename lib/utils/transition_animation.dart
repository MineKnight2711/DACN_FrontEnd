import 'package:flutter/material.dart';
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
