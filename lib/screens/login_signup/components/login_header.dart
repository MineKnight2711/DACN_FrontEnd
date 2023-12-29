import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreenHeader extends StatelessWidget {
  const LoginScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Container(
          height: 1.sh / 3,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/LTM.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(70.0)),
          ),
        ),
      ],
    );
  }
}
