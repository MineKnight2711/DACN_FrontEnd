// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/controller/register_controller.dart';
import 'package:fooddelivery_fe/screens/login_signup/login_screen.dart';
import 'package:fooddelivery_fe/utils/mediaquery.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:fooddelivery_fe/widgets/datetime_picker.dart';
import 'package:fooddelivery_fe/widgets/gender_chose.dart';
import 'package:fooddelivery_fe/widgets/custom_message.dart';

import 'package:fooddelivery_fe/widgets/round_button.dart';
import 'package:fooddelivery_fe/widgets/round_textfield.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final registerController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 64,
              ),
              Text(
                "Sign Up",
                style: TextStyle(
                    color: TextColor.primaryText,
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                "Add your details to sign up",
                style: TextStyle(
                    color: TextColor.secondaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 25,
              ),
              RoundTextfield(
                hintText: "Họ và tên",
                controller:
                    registerController.textControllers.txtFullNameSignUp,
                onChanged: registerController.validateFullname,
              ),
              BirthdayDatePickerWidget(
                initialDate: DateTime.now(),
                onChanged: (value) {
                  registerController.selectedBirthDay = value;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              GenderSelectionWidget(
                onChanged: (value) {
                  registerController.selectedGender.value = value;
                },
                size: CustomMediaQuery.mediaAspectRatio(context, 0.27),
              ),
              const SizedBox(
                height: 25,
              ),
              RoundTextfield(
                hintText: "Email",
                controller: registerController.textControllers.txtEmailSignUp,
                keyboardType: TextInputType.emailAddress,
                onChanged: registerController.validateEmail,
              ),
              const SizedBox(
                height: 25,
              ),
              RoundTextfield(
                hintText: "Số điện thoại",
                controller: registerController.textControllers.txtPhoneSignUp,
                keyboardType: TextInputType.phone,
                onChanged: registerController.validatePhonenumber,
              ),
              const SizedBox(
                height: 25,
              ),
              RoundTextfield(
                hintText: "Password",
                controller:
                    registerController.textControllers.txtPasswordSignUp,
                obscureText: true,
                onChanged: registerController.validatePassword,
              ),
              const SizedBox(
                height: 25,
              ),
              RoundTextfield(
                hintText: "Confirm Password",
                controller:
                    registerController.textControllers.txtConfirmPasswordSignUp,
                obscureText: true,
                onChanged: registerController.validateReenterPassword,
              ),
              const SizedBox(
                height: 25,
              ),
              Obx(
                () => RoundButton(
                    enabled: registerController.validate.isSignUpValid.value,
                    title: tr("Sign Up"),
                    onPressed: () async {
                      String? result = await registerController.register();
                      if (result == "Success") {
                        showCustomSnackBar(context, "Thông báo",
                            "Đăng ký thành công!", ContentType.success);
                        slideInTransitionReplacement(context, LoginScreen());
                      } else {
                        showCustomSnackBar(context, "Lỗi", "Đăng ký thất bại",
                            ContentType.failure);
                      }
                    }),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  slideInTransitionReplacement(context, LoginScreen());
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Already have an Account? ",
                      style: TextStyle(
                          color: TextColor.secondaryText,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Login",
                      style: TextStyle(
                          color: TextColor.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
