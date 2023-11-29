import 'package:get/get.dart';

class ValidateInput {
  final _isSignUpValid = RxBool(false);
  final _isLoginValid = RxBool(false);

  RxBool isValidEmailSignUp = false.obs;
  RxBool isValidPasswordSignUp = false.obs;
  RxBool isValidConfirmPasswordSignUp = false.obs;
  RxBool isValidFullnameSignUp = false.obs;
  RxBool isValidPhonenumberSignUp = false.obs;
  RxBool isValidEmailLogin = false.obs;
  RxBool isValidPasswordLogin = false.obs;

  RxBool isValidFullnameUpdate = true.obs;
  RxBool isValidPhonenumberUpdate = true.obs;

  RxBool get isLoginValid {
    _isLoginValid.value = isValidEmailLogin.value && isValidPasswordLogin.value;
    return _isLoginValid;
  }

  RxBool get isSignUpValid {
    _isSignUpValid.value = isValidEmailSignUp.value &&
        isValidPasswordSignUp.value &&
        isValidConfirmPasswordSignUp.value &&
        isValidFullnameSignUp.value &&
        isValidPhonenumberSignUp.value;
    return _isSignUpValid;
  }

  void setDefaultValues() {
    _isSignUpValid.value = _isLoginValid.value = isValidEmailSignUp.value =
        isValidPasswordSignUp.value = isValidConfirmPasswordSignUp.value =
            isValidFullnameSignUp.value = isValidPhonenumberSignUp.value =
                isValidEmailLogin.value = isValidPasswordLogin.value = false;
  }
}
