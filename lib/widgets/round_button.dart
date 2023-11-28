import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

enum RoundButtonType { bgPrimary, textPrimary }

class RoundButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final double fontSize;
  final double size;
  final bool enabled;
  const RoundButton(
      {super.key,
      required this.title,
      this.onPressed,
      this.fontSize = 16,
      required this.enabled,
      this.size = 40});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(size * 5, size),
        backgroundColor: AppColors.orange100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: enabled ? onPressed : null,
      child: Text(
        title,
        style: GoogleFonts.roboto(fontSize: 18),
      ),
    );
    // InkWell(
    //   onTap: enabled ? onPressed : null,
    //   child: Container(
    //     height: 56,
    //     alignment: Alignment.center,
    //     decoration: BoxDecoration(
    //       border: type == RoundButtonType.bgPrimary
    //           ? null
    //           : Border.all(color: TextColor.primary, width: 1),
    //       color: type == RoundButtonType.bgPrimary
    //           ? TextColor.primary
    //           : TextColor.white,
    //       borderRadius: BorderRadius.circular(28),
    //     ),
    //     child: Text(
    //       title,
    //       style: TextStyle(
    //           color: type == RoundButtonType.bgPrimary
    //               ? TextColor.white
    //               : TextColor.primary,
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.w600),
    //     ),
    //   ),
    // );
  }
}
