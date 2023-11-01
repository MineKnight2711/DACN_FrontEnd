import 'package:fooddelivery_fe/api/account/account_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/category_controller.dart';
import 'package:fooddelivery_fe/controller/login_controller.dart';
import 'package:get/get.dart';

class MainController {
  static initializeControllers() async {
    Get.put(LoginController());
    Get.put(CategoryController());
    final AccountController accountController = Get.find();
    accountController.accountSession.value =
        await accountController.getUserFromSharedPreferences();
    // Get.put(HomeScreenController());
  }
}
