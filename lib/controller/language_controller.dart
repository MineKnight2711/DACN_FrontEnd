import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  Rx<Locale> currentLocale = Rx<Locale>(const Locale('vi', 'VN'));

  @override
  void onInit() {
    super.onInit();
    fetchCurrentLocale();
  }

  Future<void> fetchCurrentLocale() async {
    currentLocale.value = await getSavedLocale();
    update();
  }

  Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_locale', locale.toString());
    currentLocale.value = locale;
    Get.find<LanguageController>().currentLocale.value = locale;
    update();
  }

  Future<Locale> getSavedLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String localeString = prefs.getString('selected_locale') ?? '';

    if (localeString.isNotEmpty) {
      List<String> splitLocale = localeString.split('_');
      if (splitLocale.length == 2) {
        return Locale(splitLocale[0], splitLocale[1]);
      }
    }

    return const Locale('vi', 'VN');
  }
}
