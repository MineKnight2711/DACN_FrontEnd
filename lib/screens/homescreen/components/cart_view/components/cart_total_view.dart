import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_button.dart';
import 'package:google_fonts/google_fonts.dart';

class CartTotalView extends StatelessWidget {
  final double cartTotal;
  final bool checkOutEnable;
  final VoidCallback checkoutPressed;
  final VoidCallback? deleteCartPressed;
  const CartTotalView({
    super.key,
    required this.cartTotal,
    required this.checkoutPressed,
    this.deleteCartPressed,
    required this.checkOutEnable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
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
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 40.w,
                ),
                Text(
                  tr("cart.total"),
                  style: GoogleFonts.roboto(fontSize: 20.r),
                ),
                // SizedBox(
                //   width: 20.w,
                // ),
                Text(
                  DataConvert().formatCurrency(cartTotal),
                  style: GoogleFonts.roboto(fontSize: 20.r),
                ),

                deleteCartPressed != null
                    ? Material(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.transparent,
                        child: SizedBox(
                          width: 40.w,
                          height: 50.h,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            splashColor: AppColors.dark5,
                            onTap: deleteCartPressed,
                            child: Icon(
                              CupertinoIcons.delete_simple,
                              color: AppColors.orange100,
                              size: 25.r,
                            ),
                          ),
                        ),
                      )
                    : const Card(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10.h),
              child: RoundIconButton(
                  enabled: checkOutEnable,
                  size: 70.r,
                  title: tr("cart.order"),
                  onPressed: checkoutPressed),
            ),
          ),
        ],
      ),
    );
  }
}
