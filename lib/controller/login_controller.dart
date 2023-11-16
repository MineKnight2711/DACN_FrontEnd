// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/api/account/account_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/register_controller.dart';
import 'package:fooddelivery_fe/model/account_model.dart';

import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:fooddelivery_fe/utils/text_controller.dart';
import 'package:fooddelivery_fe/utils/validate_input.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  TextControllers textControllers = TextControllers();
  ValidateInput validate = ValidateInput();
  late AccountApi _accountApi;
  late AccountController _accountController;

  @override
  void onInit() {
    super.onInit();
    _accountApi = AccountApi();
    _accountController = Get.put(AccountController());
  }

  void refesh() {
    textControllers.clearText();
    validate.setDefaultValues();
  }

  Future<String?> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: textControllers.txtEmailLogin.text,
              password: textControllers.txtPasswordLogin.text);
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
      case "INVALID_LOGIN_CREDENTIALS":
        return "Email hoặc mật khẩu không hợp lệ";
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
        registerController.textControllers.txtFullNameSignUp.text =
            "${user.displayName}";
        registerController.textControllers.txtEmailSignUp.text =
            "${user.email}";
        registerController.imageUrl = "${user.photoURL}";
        return "SignUpSuccess";
      } else if (accountReceived == "Success") {
        return "LoginSuccess";
      }
    }
    return "Fail";
  }

  //Kiểm tra email hợp lệ
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      validate.isValidEmailLogin.value = false;
      return 'Email không được trống';
    }
    //Đây là Regex cho đa số trường hợp email, tuy nhiên vẫn có một số ngoại lệ như sau:
    //huynhphuocdat.siu@résumé.com đây là trường hợp email hợp lệ nhưng sẽ không match được regex này vì không hỗ trợ các ký tự nằm ngoài bảng mã ASCII
    //Thêm 1 trường hợp nữa là <datcute2711@yahoo.com> đây vẫn là 1 email hợp lệ nhưng cũng không match regex vì không hỗ trợ dấu < và >
    // RegExp emailRegex =
    //     RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    //Còn đây là regex cho riêng gmail
    RegExp gmailRegex = RegExp(
        r'[\w]*@*[a-z]*\.*[\w]{5,}(\.)*(com)*(@gmail\.com)',
        multiLine: true);
    if (!gmailRegex.hasMatch(email)) {
      validate.isValidEmailLogin.value = false;
      return 'Email không đúng định dạng';
    }

    validate.isValidEmailLogin.value = true;

    return null;
  }

  //Kiểm tra mật khẩu hợp lệ
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      validate.isValidPasswordLogin.value = false;
      return 'Mật khẩu không được trống';
    }
    validate.isValidPasswordLogin.value = true;

    return null;
  }
}
