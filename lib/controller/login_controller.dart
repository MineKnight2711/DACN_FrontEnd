// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/api/account/account_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/register_controller.dart';
import 'package:fooddelivery_fe/model/account_model.dart';

import 'package:fooddelivery_fe/model/respone_base_model.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late AccountApi _accountApi;
  late AccountController _accountController;

  @override
  void onInit() {
    super.onInit();
    _accountApi = AccountApi();
    _accountController = Get.put(AccountController());
  }

  void refesh() {
    emailController.clear();
    passwordController.clear();
  }

  Future<String?> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      if (userCredential.user != null) {
        return await getAccountFromDatabase(email);
      }
      return "AuthenticationFail";
    } on FirebaseAuthException catch (error) {
      return catchFirebaseAuthException(error.code);
    }
  }

  String catchFirebaseAuthException(String errorCode) {
    print(errorCode);
    switch (errorCode) {
      case "invalid-email":
        return "Email không hợp lệ!";
      case "wrong-password":
        return "Sai mật khẩu hoặc tài khoản không có mật khẩu\nNếu tài khoản của bạn đã liên kết với google hãy dùng chức năng bên dưới .";
      case "user-not-found":
        return "Tài khoản không tồn tại.";
      case "user-disabled":
        return "Tài khoản bị khoá.";
      case "too-many-requests":
        return "Sai mật khẩu quá nhiều lần vui lòng đợi 30 giây";
      case "requires-recent-login":
        return "Yêu cầu đăng nhập gần đây để thực hiện thao tác nhạy cảm.";
      case "operation-not-allowed":
        return "Không thể đăng nhập vui lòng liên hệ người phát triển.";
      default:
        return "Lỗi chưa xác định.";
    }
  }

  Future<String> getAccountFromDatabase(String email) async {
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

  Future<String?> signInWithGoogle() async {
    GoogleSignInAccount? googleUser =
        await GoogleSignIn().signIn().onError((error, stackTrace) {
      error.printError();
      return null;
    });
    if (googleUser == null) {
      return 'CancelSignIn';
    }

    GoogleSignInAuthentication? googleAuth = await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    var user = userCredential.user;

    if (user != null) {
      String accountReceived = await getAccountFromDatabase("${user.email}");
      if (accountReceived == "AccountNotFound" ||
          accountReceived != "Success") {
        final registerController = Get.put(RegisterController());
        registerController.fullNameController.text = "${user.displayName}";
        registerController.emailController.text = "${user.email}";
        registerController.imageUrl = "${user.photoURL}";
        return "SignUpSuccess";
      } else if (accountReceived == "Success") {
        return "LoginSuccess";
      }
    }
    return "Fail";
  }
}
