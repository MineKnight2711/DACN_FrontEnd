import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/transaction_controller.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:get/get.dart';

class PaymentDetailsBox extends StatelessWidget {
  final TransactionController transactionController;
  final double cartTotal;
  final double finalTotal;
  final int itemAmount;

  const PaymentDetailsBox(
      {super.key,
      required this.cartTotal,
      required this.itemAmount,
      required this.transactionController,
      required this.finalTotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr("payment.payment_details"),
          style: CustomFonts.customGoogleFonts(
              fontSize: 16.r, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr("payment.payment_details"),
              style: CustomFonts.customGoogleFonts(fontSize: 14.r),
            ),
            Text(
              DataConvert().formatCurrency(cartTotal),
              style: CustomFonts.customGoogleFonts(fontSize: 14.r),
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr("payment.dishes(amount)"),
              style: CustomFonts.customGoogleFonts(fontSize: 14.r),
            ),
            Text(
              itemAmount.toString(),
              style: CustomFonts.customGoogleFonts(fontSize: 14.r),
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr("payment.discount"),
              style: CustomFonts.customGoogleFonts(fontSize: 14.r),
            ),
            Obx(
              () => Text(
                transactionController.selectedVoucher.value != null
                    ? transactionController.selectedVoucher.value?.type ==
                            "Percent"
                        ? '${transactionController.selectedVoucher.value?.discountPercent}%'
                        : transactionController.selectedVoucher.value?.type ==
                                "Amount"
                            ? DataConvert().formatCurrency(transactionController
                                    .selectedVoucher.value?.discountAmount ??
                                0.0)
                            : ""
                    : 'Không có',
                style: CustomFonts.customGoogleFonts(fontSize: 14.r),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        const Divider(color: AppColors.gray100),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr("payment.total"),
              style: CustomFonts.customGoogleFonts(fontSize: 18.r),
            ),
            Text(
              DataConvert().formatCurrency(finalTotal),
              style: CustomFonts.customGoogleFonts(fontSize: 18.r),
            ),
          ],
        ),
      ],
    );
  }
}
