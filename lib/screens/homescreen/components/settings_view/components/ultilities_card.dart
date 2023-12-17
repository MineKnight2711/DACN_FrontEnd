import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';

class ExtensionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onPressed;
  const ExtensionCard(
      {super.key, required this.icon, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        splashColor: AppColors.lightOrange,
        highlightColor: Colors.transparent,
        onTap: onPressed,
        child: Container(
          margin: EdgeInsets.all(16.r),
          height: 20.h,
          width: 200.w - 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                icon,
                color: AppColors.orange100,
                size: 24.r,
              ),
              Text(title, style: CustomFonts.customGoogleFonts(fontSize: 13.r)),
            ],
          ),
        ),
      ),
    );
  }
}
