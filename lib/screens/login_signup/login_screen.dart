import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/config/constant.dart';
import 'package:fooddelivery_fe/controller/login_controller.dart';
import 'package:fooddelivery_fe/controller/register_controller.dart';
import 'package:fooddelivery_fe/screens/homescreen/homescreen.dart';
import 'package:fooddelivery_fe/screens/login_signup/register_screen.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_input_textfield.dart';
import 'package:fooddelivery_fe/widgets/custom_button.dart';
import 'package:fooddelivery_fe/widgets/message.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/mediaquery.dart';
import 'components/login_google_button.dart';
import 'components/no_account_line.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/login_banner.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(300, 70),
              bottomRight: Radius.elliptical(300, 70),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Chào mừng trở lại!",
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
                labelText: 'Email',
                controller: loginController.emailController,
              ),
              SizedBox(
                height: CustomMediaQuery.mediaHeight(context, 50),
              ),
              CustomInputTextField(
                labelText: 'Mật khẩu',
                controller: loginController.passwordController,
              ),
              SizedBox(
                height: CustomMediaQuery.mediaHeight(context, 30),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  child: Text(
                    "Quên mật khẩu ?",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: mainButtonColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: CustomMediaQuery.mediaHeight(context, 20),
              ),
              DefaultButton(
                text: 'Đăng nhập',
                fontSize: 20,
                press: () async {
                  String? result = await loginController.login(
                      loginController.emailController.text,
                      loginController.passwordController.text);
                  if (result == "Success") {
                    CustomSuccessMessage.showMessage("Đăng nhập thành công!");
                    // ignore: use_build_context_synchronously
                    fadeInTransitionReplacement(context, HomeScreen());
                  } else if (result == "AccountNotFound") {
                    CustomErrorMessage.showMessage("Không tìm thấy tài khoản!");
                  } else {
                    CustomErrorMessage.showMessage("Lỗi không xác định!");
                  }
                },
              ),
              SizedBox(
                height: CustomMediaQuery.mediaHeight(context, 50),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "hoặc",
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: CustomMediaQuery.mediaHeight(context, 50),
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: Image.asset("assets/icons/google.png"),
              // ),
              LoginWithGoogleButton(
                  buttonIconAssets: "assets/icons/google.png",
                  onPressed: () {},
                  buttonText: "Tiếp tục với google"),
              SizedBox(
                height: CustomMediaQuery.mediaHeight(context, 30),
              ),
              NoAccountLine(
                onTap: () {
                  Get.put(RegisterController());
                  slideInTransition(context, RegisterScreen());
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
