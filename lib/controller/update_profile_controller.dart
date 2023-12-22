import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/api/account/account_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:fooddelivery_fe/utils/text_controller.dart';
import 'package:fooddelivery_fe/utils/validate_input.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  // TextEditingController emailController = TextEditingController();
  UpdateProfileController();
  final textControllers = TextControllers();
  final validate = ValidateInput();

  DateTime? date;

  final isFullNameDropdown = false.obs;
  final isPhoneNumberDropDown = false.obs;
  final isBirthDayDropDown = false.obs;
  final birthDayExpansionTileController = ExpansionTileController();
  final phoneNumberExpansionTileController = ExpansionTileController();
  final fullnameExpansionTileController = ExpansionTileController();

  late AccountApi _accountApi;
  late AccountController _accountController;

  @override
  void onInit() {
    super.onInit();
    _accountController = Get.find<AccountController>();
    _accountApi = AccountApi();
    fetchCurrent();
  }

  void observeDropdowns() {
    isFullNameDropdown.listen((expanded) {
      if (expanded) {
        isPhoneNumberDropDown.value = false;
        isBirthDayDropDown.value = false;
        birthDayExpansionTileController.collapse();
        phoneNumberExpansionTileController.collapse();
      }
    });

    isPhoneNumberDropDown.listen((expanded) {
      if (expanded) {
        isFullNameDropdown.value = false;
        isBirthDayDropDown.value = false;
        birthDayExpansionTileController.collapse();
        fullnameExpansionTileController.collapse();
      }
    });

    isBirthDayDropDown.listen((expanded) {
      if (expanded) {
        isFullNameDropdown.value = false;
        isPhoneNumberDropDown.value = false;
        fullnameExpansionTileController.collapse();
        phoneNumberExpansionTileController.collapse();
      }
    });
  }

  Future<void> fetchCurrent() async {
    await _accountController.fetchCurrentUser();
    if (_accountController.accountSession.value != null) {
      AccountModel currentAccount = _accountController.accountSession.value!;
      textControllers.txtFullNameUpdateController.text =
          currentAccount.fullName.toString();
      textControllers.txtPhoneNumberUpdateController.text =
          currentAccount.phoneNumber.toString();
      print(textControllers.txtPhoneNumberUpdateController.text);
      date =
          _accountController.accountSession.value?.birthday ?? DateTime.now();
    }
  }

  @override
  void onClose() {
    super.onClose();
    validate.isValidFullnameUpdate.value =
        validate.isValidPhonenumberUpdate.value = true;
    textControllers.clearUpdateText();
    date = null;
  }

  String? validateFullname(String? fullname) {
    if (fullname == null || fullname.isEmpty) {
      validate.isValidFullnameUpdate.value = false;
      return 'Họ tên không được trống!';
    }
    validate.isValidFullnameUpdate.value = true;
    return null;
  }

  String? validatePhonenumber(String? phonenumber) {
    if (phonenumber == null || phonenumber.isEmpty) {
      validate.isValidPhonenumberUpdate.value = false;
      return 'Số điện thoại không được trống!';
    }
    RegExp regex = RegExp(r'^(84|0)[35789]([0-9]{8})$');
    if (!regex.hasMatch(phonenumber)) {
      return 'Số điện thoại không đúng định dạng!';
    }
    validate.isValidPhonenumberUpdate.value = true;
    return null;
  }

  Future<String> updateAccount() async {
    if (_accountController.accountSession.value != null) {
      AccountModel updatedAccount = _accountController.accountSession.value!;
      if (date != null) {
        updatedAccount.birthday = date;
      } else {
        updatedAccount.birthday = updatedAccount.birthday;
      }
      updatedAccount.fullName =
          textControllers.txtFullNameUpdateController.text;
      updatedAccount.phoneNumber =
          textControllers.txtPhoneNumberUpdateController.text;
      ResponseBaseModel respone =
          await _accountApi.updateAccount(updatedAccount);
      if (respone.message == 'Success') {
        await _accountController
            .storedUserToSharedRefererces(AccountModel.fromJson(respone.data))
            .whenComplete(() => fetchCurrent());

        return "Success";
      }
      return respone.message.toString();
    }
    return "Unknown";
  }

  Future<ResponseBaseModel> changeEmail(String newEmail) async {
    ResponseBaseModel response = ResponseBaseModel();
    if (_accountController.accountSession.value != null) {
      if (newEmail != "${_accountController.accountSession.value?.email}") {
        final response = await _accountApi.changeEmail(
            "${_accountController.accountSession.value?.accountID}",
            "${_accountController.accountSession.value?.email}",
            newEmail);
        await _accountController.fetchCurrentUser();
        return response;
      }
      response.message = "IsCurrent";
      response.data = "Bạn không thể cập nhật email hiện tại";
      return response;
    }
    response.message = "Fail";
    return response;
  }
}
