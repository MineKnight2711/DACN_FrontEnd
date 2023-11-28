import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CartTotalView extends StatelessWidget {
  final CartController cartController;
  const CartTotalView({
    super.key,
    required this.cartController,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 90.h,
        width: 400.w,
        decoration: const BoxDecoration(
          color: AppColors.gray15,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Tổng tiền :",
                    style: GoogleFonts.roboto(fontSize: 22),
                  ),
                  Obx(
                    () => Text(
                      DataConvert().formatCurrency(
                          cartController.calculateTotal().value),
                      style: GoogleFonts.roboto(fontSize: 22),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 40),
                    backgroundColor: AppColors.orange100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Đặt mua",
                    style: GoogleFonts.roboto(fontSize: 18),
                  ),
                  onPressed: () {
                    // button action
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
