import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/controller/login_controller.dart';
import 'package:fooddelivery_fe/screens/login_signup/login_header.dart';
import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_input_textfield.dart';
import 'package:fooddelivery_fe/widgets/default_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/mediaquery.dart';

class LoginSreen extends StatelessWidget {
  LoginSreen({super.key});
  final loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Navigator.pop(context);
        },
        backGroundColor: Colors.transparent,
        leadingColor: Colors.white,
      ),
      extendBodyBehindAppBar: true,
      body: Column(children: [
        Container(
          height: CustomMediaQuery.mediaHeight(context, 4),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/LTM.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(300, 60),
              bottomRight: Radius.elliptical(300, 60),
            ),
          ),
        ),
        Container(
          height: 100.0,
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Chào mừng trở lại!",
              style:
                  GoogleFonts.roboto(fontSize: 30, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: CustomInputTextField(
            labelText: 'Email',
            controller: loginController.emailController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: CustomInputTextField(
            labelText: 'Mật khẩu',
            controller: loginController.passwordController,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: DefaultButton(
            text: 'Đăng nhập',
            fontSize: 20,
            press: () {},
          ),
        ),
      ]),
    );
  }
}
