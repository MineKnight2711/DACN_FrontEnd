import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/api/account/account_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  late AccountApi _accountApi;
  late AccountController _accountController;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  RxString selectedGender = "".obs;
  DateTime? selectedBirthDay;
  String imageUrl = "";

  @override
  void onInit() {
    super.onInit();
    _accountApi = AccountApi();
    _accountController = Get.find();
  }

  @override
  void onClose() {
    super.onClose();
    _accountApi = AccountApi();
    imageUrl = "";
    selectedGender.value = "";
    selectedBirthDay = null;
    fullNameController.clear();
    passwordController.clear();
    emailController.clear();
    phoneController.clear();
  }

  Future<String> saveSignInUserToDatabase() async {
    AccountModel newAccount = AccountModel();
    newAccount.accountID = "";
    newAccount.fullName = fullNameController.text;
    newAccount.password = passwordController.text;
    newAccount.birthday = selectedBirthDay;
    newAccount.email = emailController.text;
    newAccount.gender = selectedGender.value;
    newAccount.phoneNumber = phoneController.text;
    newAccount.imageUrl = imageUrl;
    ResponseBaseModel? responseBaseModel =
        await _accountApi.register(newAccount);
    if (responseBaseModel?.message == "Success") {
      return "Success";
    }
    return responseBaseModel?.message ?? "";
  }

  Future<String?> register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      if (userCredential.user != null) {
        return await saveSignInUserToDatabase();
      }
      return "AuthenticationFail";
    } on FirebaseAuthException catch (error) {
      String? errorMessage = catchFirebaseAuthError(error);
      return errorMessage;
    }
  }

  String? catchFirebaseAuthError(FirebaseAuthException error) {
    String? errorMessage;
    switch (error.code) {
      case "invalid-email":
        errorMessage = "Email không đúng định dạng.";
        break;
      case "email-already-in-use":
        errorMessage = "Địa chỉ email đã được sử dụng bởi một tài khoản khác.";
        break;
      case "too-many-requests":
        errorMessage = "Quá nhiều yêu cầu (thử lại sau 30s)";
        break;
      case "operation-not-allowed":
        errorMessage = "Thao tác này không thể thực hiện!";
        break;
      default:
        errorMessage = "Lỗi chưa xác định.";
    }
    return errorMessage;
  }

  Future<String> getAccountByEmail(String email) async {
    ResponseBaseModel? responseBaseModel = await _accountApi.login(email);
    if (responseBaseModel?.message == "Success") {
      _accountController.accountSession.value =
          AccountModel.fromJson(responseBaseModel?.data);
      await _accountController.storedUserToSharedRefererces(
          AccountModel.fromJson(responseBaseModel?.data));

      return "Success";
    }
    return responseBaseModel?.message ?? "";
  }
}
