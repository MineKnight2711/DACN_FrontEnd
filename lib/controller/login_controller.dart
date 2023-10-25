import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/api/account/account_api.dart';
import 'package:fooddelivery_fe/model/account_model.dart';

import 'package:fooddelivery_fe/model/respone_base_model.dart';

import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Rx<AccountModel?> accountRespone = Rx<AccountModel?>(null);

  Future<String?> login(String email, String password) async {
    AccountApi accountApi = AccountApi();
    ResponseBaseModel? responseBaseModel =
        await accountApi.login(email, password);
    if (responseBaseModel?.message == "Success") {
      accountRespone.value = AccountModel.fromJson(responseBaseModel?.data);
      return "Success";
    }
    return responseBaseModel?.message;
  }
}
