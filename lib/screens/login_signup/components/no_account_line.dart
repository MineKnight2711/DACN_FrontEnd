import 'package:flutter/widgets.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class NoAccountLine extends StatelessWidget {
  final Function() onTap;
  const NoAccountLine({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Chưa có tài khoản ?",
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            "Đăng ký",
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: AppColors.orange100,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
