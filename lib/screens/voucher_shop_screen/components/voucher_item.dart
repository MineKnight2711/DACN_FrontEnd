import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/model/voucher_model.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';

class VoucherItem extends StatelessWidget {
  final VoucherModel voucher;
  final Function()? getVoucher;
  const VoucherItem({super.key, required this.voucher, this.getVoucher});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(6.w),
        child: Row(
          children: [
            Image.asset(
              "assets/images/voucher_banner.png",
              width: 60.w,
            ),
            SizedBox(
              width: 5.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${voucher.voucherName}",
                    style: CustomFonts.customGoogleFonts(fontSize: 14.r),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Giảm ",
                          style: CustomFonts.customGoogleFonts(
                            fontSize: 13.r,
                            color: AppColors.dark20,
                          ),
                        ),
                        TextSpan(
                          text: voucher.type == "Percent"
                              ? "${voucher.discountPercent} %"
                              : voucher.type == "Amount"
                                  ? DataConvert().formatCurrency(double.parse(
                                      voucher.discountAmount.toString()))
                                  : "",
                          style: CustomFonts.customGoogleFonts(
                              fontSize: 13.r, color: Colors.green),
                        ),
                        TextSpan(
                          text: " trên đơn hàng",
                          style: CustomFonts.customGoogleFonts(
                            fontSize: 13.r,
                            color: AppColors.dark20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Từ ${DataConvert().formattedNormalDate(voucher.startDate)}",
                    style: CustomFonts.customGoogleFonts(
                      fontSize: 13.r,
                      color:
                          (voucher.startDate?.isBefore(DateTime.now()) ?? false)
                              ? Colors.green
                              : Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    "Đến ${DataConvert().formattedNormalDate(voucher.expDate)}",
                    style: CustomFonts.customGoogleFonts(fontSize: 13.r),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: getVoucher,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    alignment: Alignment.center,
                    height: 30.h,
                    width: 70.w,
                    child: Text(
                      "Múc",
                      textAlign: TextAlign.center,
                      style: CustomFonts.customGoogleFonts(
                          fontSize: 14.r, color: Colors.blue),
                    ),
                  ),
                ),
                Text(
                  "${voucher.pointsRequired} điểm",
                  style: CustomFonts.customGoogleFonts(fontSize: 14.r),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
