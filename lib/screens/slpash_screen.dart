import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/screens/homescreen/homescreen.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    simulateInitialDataLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: 0.6.sw,
            height: 0.35.sh,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              image: DecorationImage(
                  image: Image.asset("assets/images/background_crop_1000.jpg")
                      .image,
                  fit: BoxFit.cover),
            ),
          ),
        ));
  }

  Future<Timer> simulateInitialDataLoading() async {
    return Timer(
      const Duration(seconds: 2),
      () => Get.offAll(
        const HomeScreen(),
        transition: Transition.fadeIn,
        duration: const Duration(
          milliseconds: 1500,
        ),
      ),
    );
  }
}
