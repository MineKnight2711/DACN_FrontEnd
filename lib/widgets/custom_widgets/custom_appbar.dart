import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showLeading, centeredTitle;
  final VoidCallback? onPressed;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  final Color? backGroundColor;
  final Color? leadingColor;
  const CustomAppBar(
      {super.key,
      this.title,
      this.showLeading = true,
      this.onPressed,
      this.bottom,
      this.actions,
      this.backGroundColor,
      this.leadingColor,
      this.centeredTitle = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backGroundColor ?? AppColors.orange100,
      elevation: 0,
      centerTitle: centeredTitle,
      leading: showLeading
          ? Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: onPressed ??
                    () {
                      Navigator.pop(context);
                    },
                child: Icon(Icons.arrow_back,
                    color: leadingColor ?? AppColors.white100),
              ),
            )
          : null,
      actions: actions,
      title: Text(
        title ?? "",
        style: GoogleFonts.nunito(
          color: AppColors.white100,
          fontSize: CustomMediaQuerry.mediaAspectRatio(context, 1 / 37),
          fontWeight: FontWeight.w500,
        ),
      ),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}
