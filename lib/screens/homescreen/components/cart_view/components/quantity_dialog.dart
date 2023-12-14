import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_button.dart';
import 'package:fooddelivery_fe/widgets/quantity_chooser.dart';
import 'package:google_fonts/google_fonts.dart';

class QuantityDialog extends StatelessWidget {
  final int currentQuantity;
  final Function(int) onQuantityChanged;
  final VoidCallback onNoQuantity;
  const QuantityDialog({
    super.key,
    required this.currentQuantity,
    required this.onQuantityChanged,
    required this.onNoQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dialogBackgroundColor: AppColors.white100,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[800],
          ),
        ),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Mời chọn số lượng",
          style: GoogleFonts.roboto(fontSize: 16.r),
        ),
        content: QuantityChooser(
            currentQuantity: currentQuantity,
            onQuantityChanged: onQuantityChanged),
        actions: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(bottom: 20.r),
              height: 30.h,
              width: 110.w,
              child: RoundIconButton(
                // size: 60.r,
                title: "OK",
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
