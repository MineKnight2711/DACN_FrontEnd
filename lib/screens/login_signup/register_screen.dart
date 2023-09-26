import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/controller/register_controller.dart';
import 'package:fooddelivery_fe/screens/login_signup/complete_register_screen.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/mediaquery.dart';
import '../../widgets/custom_input_textfield.dart';
import '../../widgets/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final registerController = Get.find<RegisterController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        backGroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Tạo tài khoản mới!",
              style: GoogleFonts.roboto(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: CustomMediaQuery.mediaHeight(context, 30),
          ),
          CustomInputTextField(
            labelText: 'Họ và tên',
            controller: registerController.fullNameController,
          ),
          SizedBox(
            height: CustomMediaQuery.mediaHeight(context, 50),
          ),
          CustomInputTextField(
            labelText: 'Email',
            controller: registerController.emailController,
          ),
          SizedBox(
            height: CustomMediaQuery.mediaHeight(context, 50),
          ),
          CustomPasswordTextfield(
            labelText: 'Mật khẩu',
            controller: registerController.passwordController,
          ),
          SizedBox(
            height: CustomMediaQuery.mediaHeight(context, 30),
          ),
          DefaultButton(
            text: 'Tiếp tục',
            fontSize: 20,
            press: () {
              slideInTransition(context, CompleteRegisterScreen());
            },
          ),
        ]),
      ),
    );
  }
}
