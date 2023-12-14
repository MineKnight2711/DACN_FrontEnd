import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundIconButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final Color? color;
  final Color? titleColor;
  final double fontSize, size;
  final FontWeight fontWeight;
  final bool enabled;
  final String iconPath;
  const RoundIconButton(
      {super.key,
      required this.title,
      this.color = AppColors.orange100,
      this.fontSize = 12,
      this.fontWeight = FontWeight.w500,
      required this.onPressed,
      this.size = 40,
      this.enabled = true,
      this.iconPath = '',
      this.titleColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 3,
      height: size * 0.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: enabled ? onPressed : null,
        child: iconPath == ''
            ? Text(
                title,
                style: GoogleFonts.roboto(
                    fontSize: 16.r,
                    color: enabled ? AppColors.white100 : AppColors.dark80),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    iconPath,
                    height: 18.h,
                  ),
                  Text(
                    title,
                    style: GoogleFonts.roboto(
                      fontSize: 18.r,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
