import 'package:firebase_auth/firebase_auth.dart';
import 'package:fooddelivery_fe/api/account/account_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:fooddelivery_fe/utils/text_controller.dart';
import 'package:fooddelivery_fe/utils/validate_input.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  late AccountApi _accountApi;
  late AccountController _accountController;

  ValidateInput validate = ValidateInput();
  TextControllers textControllers = TextControllers();

  RxString selectedGender = "".obs;
  DateTime? selectedBirthDay;

  @override
  void onInit() {
    super.onInit();
    _accountApi = AccountApi();
    _accountController = Get.find();
  }

  @override
  void refresh() {
    selectedGender.value = "";
    selectedBirthDay = null;
    textControllers.clearText();
    validate.setDefaultValues();
  }

  Future<String> saveSignInUserToDatabase() async {
    AccountModel newAccount = AccountModel();
    newAccount.accountID = "";
    newAccount.fullName = textControllers.txtFullNameSignUp.text;
    if (selectedBirthDay != null) {
      newAccount.birthday = selectedBirthDay;
    } else {
      newAccount.birthday = DateTime.now();
    }
    newAccount.email = textControllers.txtEmailSignUp.text;
    newAccount.gender = selectedGender.value;
    newAccount.phoneNumber = textControllers.txtPhoneSignUp.text;
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
              email: textControllers.txtEmailSignUp.text,
              password: textControllers.txtPasswordSignUp.text);
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

  //Kiểm tra email hợp lệ
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      validate.isValidEmailSignUp.value = false;
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
      validate.isValidEmailSignUp.value = false;
      return 'Email không đúng định dạng';
    }

    validate.isValidEmailSignUp.value = true;

    return null;
  }

  //Kiểm tra mật khẩu hợp lệ
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      validate.isValidPasswordSignUp.value = false;
      return 'Mật khẩu không được trống';
    }

    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*(),.?":{}|<>]).{8,}$');
    if (!regex.hasMatch(password)) {
      validate.isValidPasswordSignUp.value = false;
      return 'Mật khẩu phải chứa ít nhất:\n* 1 ký tự hoa,\n* 1 ký tự thường ,\n* 1 số,\n* 1 ký tự đặc biệt,\n* 8 ký tự';
    }

    validate.isValidPasswordSignUp.value = true;

    return null;
  }

  //Kiểm tra xác nhận mật khẩu hợp lệ
  String? validateReenterPassword(String? reenterpassword) {
    if (reenterpassword == null || reenterpassword.isEmpty) {
      validate.isValidConfirmPasswordSignUp.value = false;
      return 'Mật khẩu không được trống!';
    }
    if (reenterpassword != textControllers.txtPasswordSignUp.text) {
      validate.isValidConfirmPasswordSignUp.value = false;
      return 'Mật khẩu không khớp!';
    }
    validate.isValidConfirmPasswordSignUp.value = true;
    return null;
  }

  String? validateFullname(String? fullname) {
    if (fullname == null || fullname.isEmpty) {
      validate.isValidFullnameSignUp.value = false;
      return 'Họ tên không được trống!';
    }
    validate.isValidFullnameSignUp.value = true;
    return null;
  }

  String? validatePhonenumber(String? phonenumber) {
    if (phonenumber == null || phonenumber.isEmpty) {
      validate.isValidPhonenumberSignUp.value = false;
      return 'Số điện thoại không được trống!';
    }
    RegExp regex = RegExp(r'^(84|0)[35789]([0-9]{8})$');
    if (!regex.hasMatch(phonenumber)) {
      validate.isValidPhonenumberSignUp.value = false;
      return 'Số điện thoại không đúng định dạng!';
    }
    validate.isValidPhonenumberSignUp.value = true;
    return null;
  }
}
