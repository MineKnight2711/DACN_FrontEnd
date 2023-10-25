import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/controller/login_controller.dart';
import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/screens/login_signup/login_screen.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  final AccountModel? accountModel;
  HomeScreen({super.key, this.accountModel});
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Hello World!",
              style: GoogleFonts.nunito(color: Colors.red, fontSize: 24),
            ),
          ),
          Obx(() {
            if (loginController.accountRespone.value != null) {
              return Column(
                children: [
                  Text("${loginController.accountRespone.value?.email}"),
                  Text("${loginController.accountRespone.value?.fullName}"),
                  ElevatedButton(
                    onPressed: () {
                      slideInTransition(context, LoginScreen());
                    },
                    child: const Text("Đăng xuất <-"),
                  ),
                ],
              );
            }
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.put(LoginController());
                  slideInTransition(context, LoginScreen());
                },
                child: const Text("Đăng nhập ->"),
              ),
            );
          }),
        ],
      ),
    );
  }
}
