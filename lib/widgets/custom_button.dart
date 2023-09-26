import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/constant.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final bool enabled;

  final double? fontSize;

  const DefaultButton({
    Key? key,
    required this.text,
    required this.press,
    this.enabled = true,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: mainButtonColor,
        ),
        onPressed: enabled ? press : null,
        child: Text(
          text,
          style: GoogleFonts.nunito(
              fontWeight: FontWeight.w500, fontSize: fontSize),
        ),
      ),
    );
  }
}
