import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/screens/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // MainController.initializeControllers();
  // await initializeDateFormatting('vi_VN', null);
  runApp(
    MaterialApp(
      initialRoute: 'home_screen',
      debugShowCheckedModeBanner: false,
      routes: {
        'home_screen': (context) => HomeScreen(),
      },
    ),
  );
}
