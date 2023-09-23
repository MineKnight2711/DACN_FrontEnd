import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/controller/login_controller.dart';
import 'package:fooddelivery_fe/screens/login_signup/login_screen.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              "Hello World!",
              style: GoogleFonts.nunito(color: Colors.red, fontSize: 24),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.put(LoginController());
              slideInTransition(context, LoginSreen());
            },
            child: const Text("Đăng nhập ->"),
          ),
        ],
      ),
    );
  }
}
