import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/api/account/account_api.dart';
import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  late AccountApi accountApi;
  @override
  void onInit() {
    super.onInit();
    accountApi = AccountApi();
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  RxString selectedGender = "".obs;
  DateTime? selectedBirthDay;
  Future<String?> register() async {
    AccountModel newAccount = AccountModel();
    newAccount.accountID = "";
    newAccount.fullName = fullNameController.text;
    newAccount.password = passwordController.text;
    newAccount.birthday = selectedBirthDay;
    newAccount.email = emailController.text;
    newAccount.gender = selectedGender.value;
    newAccount.phoneNumber = phoneController.text;
    newAccount.imageUrl = "";
    ResponseBaseModel? responseBaseModel =
        await accountApi.register(newAccount);
    if (responseBaseModel?.message == "Success") {
      return "Success";
    }
    return responseBaseModel?.message;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
