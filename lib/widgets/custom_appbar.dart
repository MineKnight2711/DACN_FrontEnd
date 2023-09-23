import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/utils/mediaquery.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showLeading;
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
      this.leadingColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backGroundColor ?? Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: showLeading
          ? Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                onTap: onPressed ??
                    () {
                      Navigator.pop(context);
                    },
                child:
                    Icon(Icons.arrow_back, color: leadingColor ?? Colors.black),
              ),
            )
          : null,
      actions: actions,
      title: Text(
        title ?? "",
        style: GoogleFonts.nunito(
          color: Colors.black,
          fontSize: CustomMediaQuery.mediaAspectRatio(context, 1 / 37),
          fontWeight: FontWeight.w500,
        ),
      ),
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
