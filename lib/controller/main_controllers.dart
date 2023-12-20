import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/account_voucher_controller.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/controller/category_controller.dart';
import 'package:fooddelivery_fe/controller/dish_controller.dart';
import 'package:fooddelivery_fe/controller/favorite_controller.dart';
import 'package:fooddelivery_fe/controller/language_controller.dart';
import 'package:fooddelivery_fe/controller/login_controller.dart';
import 'package:fooddelivery_fe/controller/notification_controller.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/bottom_tab_bar/bottom_tabbar_controller.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class MainController {
  static initializeControllers() async {
    Get.put(NotificationController());
    Get.put(LoginController());
    Get.put(CategoryController());
    Get.put(DishController());
    Get.put(CartController());
    Get.put(FavoriteController());
    Get.put(BottomTabBarController());
    final languageController = Get.put(LanguageController());
    await languageController.fetchCurrentLocale();
    initializeDateFormatting(
        languageController.currentLocale.value.toString(), null);
    final accountVoucherController = Get.put(AccountVoucherController());
    final accountController = Get.find<AccountController>();
    await accountController.fetchCurrentUser();
    accountController.accountSession.value =
        await accountController.getUserFromSharedPreferences();
    await accountVoucherController.getAllAccountVouchers();
    // Get.put(HomeScreenController());
  }

  static WebViewController initController() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    return controller;
  }
}
