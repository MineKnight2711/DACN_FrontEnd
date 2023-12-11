import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  final String assetsAnimations, tilte;
  const EmptyWidget(
      {super.key, required this.assetsAnimations, required this.tilte});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tilte,
            style: CustomFonts.customGoogleFonts(fontSize: 16.r),
          ),
          SizedBox(
            height: 15.h,
          ),
          LottieBuilder.asset("assets/animations/$assetsAnimations.json",
              width: 200.w),
        ],
      ),
    );
  }
}
