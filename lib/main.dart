import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/controller/language_controller.dart';
import 'package:fooddelivery_fe/controller/main_controllers.dart';
import 'package:fooddelivery_fe/screens/homescreen/homescreen.dart';
import 'package:fooddelivery_fe/screens/slpash_screen.dart';
import 'package:fooddelivery_fe/screens/test/cart_screen_stream_builder.dart';
import 'package:fooddelivery_fe/screens/test/test_notification.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  MainController.initializeControllers();
  await EasyLocalization.ensureInitialized();
  final languageController = Get.find<LanguageController>();
  runApp(
    Obx(
      () => EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
        path: 'assets/translations',
        fallbackLocale: languageController.currentLocale.value,
        startLocale: languageController.currentLocale.value,
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          child: Phoenix(child: const AppFood()),
        ),
      ),
    ),
  );
  await initializationSlpashScreen()
      .whenComplete(() => FlutterNativeSplash.remove());
}

Future<void> initializationSlpashScreen() async {
  return await Future.delayed(const Duration(seconds: 1));
}

class AppFood extends StatelessWidget {
  const AppFood({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: 'splash_screen',
      debugShowCheckedModeBanner: false,
      routes: {
        'home_screen': (context) => const HomeScreen(),
        'splash_screen': (context) => const SplashScreen(),
        'test_cart_screen': (context) => CartScreenRealtime(),
        'test_screen': (context) => TestNotificationScreen(),
      },
    );
  }
}
