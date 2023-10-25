import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/screens/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // MainController.initializeControllers();
  // await initializeDateFormatting('vi_VN', null);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      path: 'assets/translations', //
      fallbackLocale: const Locale('en', 'US'),
      startLocale: const Locale('vi', 'VN'),
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
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: 'home_screen',
      debugShowCheckedModeBanner: false,
      routes: {
        'home_screen': (context) => HomeScreen(),
      },
    );
  }
}
