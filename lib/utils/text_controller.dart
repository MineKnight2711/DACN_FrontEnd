import 'package:flutter/material.dart';

class TextControllers {
  final txtFullNameSignUp = TextEditingController();
  final txtPasswordSignUp = TextEditingController();
  final txtPasswordLogin = TextEditingController();
  final txtConfirmPasswordSignUp = TextEditingController();
  final txtEmailSignUp = TextEditingController();
  final txtPhoneSignUp = TextEditingController();
  final txtEmailLogin = TextEditingController();
  final txtPhoneLogin = TextEditingController();

  final txtFullNameUpdateController = TextEditingController();
  final txtPhoneNumberUpdateController = TextEditingController();

  void clearText() {
    txtFullNameSignUp.clear();
    txtPasswordSignUp.clear();
    txtPasswordLogin.clear();
    txtConfirmPasswordSignUp.clear();
    txtEmailSignUp.clear();
    txtPhoneSignUp.clear();
    txtEmailLogin.clear();
    txtPhoneLogin.clear();
  }

  void clearUpdateText() {
    txtFullNameUpdateController.clear();
    txtPhoneNumberUpdateController.clear();
  }
}
