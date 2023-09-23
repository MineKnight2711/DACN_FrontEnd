import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/utils/mediaquery.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreenHeader extends StatelessWidget {
  const LoginScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Container(
          height: CustomMediaQuery.mediaHeight(context, 3),
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
