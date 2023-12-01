import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/controller/main_controllers.dart';
import 'package:fooddelivery_fe/screens/homescreen/homescreen.dart';
import 'package:fooddelivery_fe/screens/login_signup/login_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MainController.initializeControllers();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      path: 'assets/translations', //
      fallbackLocale: const Locale('en', 'US'),
      startLocale: const Locale('en', 'US'),
      child: const ScreenUtilInit(
          designSize: Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          child: AppFood()),
    ),
  );
}

class AppFood extends StatelessWidget {
  const AppFood({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: 'home_screen',
      debugShowCheckedModeBanner: false,
      routes: {
        'home_screen': (context) => HomeScreen(),
        'login_screen': (context) => LoginScreen(),
      },
    );
  }
}
