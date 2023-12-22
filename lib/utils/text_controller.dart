import 'package:flutter/material.dart';

class TextControllers {
  final txtFullNameSignUp = TextEditingController();
  final txtPasswordSignUp = TextEditingController();
  final txtPasswordLogin = TextEditingController();
  final txtConfirmPasswordSignUp = TextEditingController();
  final txtEmailSignUp = TextEditingController();
  final txtPhoneSignUp = TextEditingController();
  final txtEmailLogin = TextEditingController();
  final txtEmailUpdate = TextEditingController();
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

  void clearLoginText() {
    txtEmailLogin.clear();
    txtPasswordLogin.clear();
  }

  void clearUpdateText() {
    txtFullNameUpdateController.clear();
    txtPhoneNumberUpdateController.clear();
  }
}

class AddressTextController {
  final txtDetails = TextEditingController();
  final txtAddressName = TextEditingController();
  final txtReceiverName = TextEditingController();
  final txtReceiverPhone = TextEditingController();
  void clearText() {
    txtDetails.clear();
    txtAddressName.clear();
    txtReceiverName.clear();
    txtReceiverPhone.clear();
  }
}

class UpdateAddressTextController {
  final txtProvince = TextEditingController();
  final txtDistrict = TextEditingController();
  final txtWard = TextEditingController();
  final txtDetails = TextEditingController();
  final txtAddressName = TextEditingController();
  final txtReceiverName = TextEditingController();
  final txtReceiverPhone = TextEditingController();
  void clearText() {
    txtProvince.clear();
    txtDistrict.clear();
    txtWard.clear();
    txtDetails.clear();
    txtAddressName.clear();
    txtReceiverName.clear();
    txtReceiverPhone.clear();
  }
}
