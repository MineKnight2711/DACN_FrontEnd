import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/account_voucher_controller.dart';
import 'package:fooddelivery_fe/controller/payment_controller.dart';
import 'package:fooddelivery_fe/controller/transaction_controller.dart';
import 'package:fooddelivery_fe/screens/payment_screen/choose_voucher_screen.dart';
import 'package:fooddelivery_fe/screens/payment_screen/components/payment_method_dialog.dart';
import 'package:get/get.dart';

class PaymentMethodAndVoucher extends StatelessWidget {
  final TransactionController transactionController;
  final PaymentController paymentController;
  final AccountVoucherController accountVoucherController;
  const PaymentMethodAndVoucher(
      {super.key,
      required this.transactionController,
      required this.paymentController,
      required this.accountVoucherController});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => PaymentDialog(
                    transactionController: transactionController,
                    paymentController: paymentController),
              );
            },
            label: Obx(
              () => Text(
                transactionController.selectedPayment.value != null
                    ? "${transactionController.selectedPayment.value?.paymentMethod}"
                    : tr("payment.choose_payment_methods"),
                style: CustomFonts.customGoogleFonts(fontSize: 14.r),
              ),
            ),
            icon: const Icon(CupertinoIcons.creditcard),
          ),
        ),
        Container(
          color: AppColors.dark100,
          width: 0.5.w,
          height: 20.h,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: () {
              accountVoucherController.getAllAccountVouchers();
              Get.to(
                () => ChooseVoucherScreen(
                    transactionController: transactionController),
                transition: Transition.rightToLeft,
              );
            },
            label: Obx(
              () => Text(
                transactionController.selectedVoucher.value != null
                    ? "${transactionController.selectedVoucher.value?.voucherName}"
                    : tr("payment.add_discount"),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: CustomFonts.customGoogleFonts(fontSize: 14.r),
              ),
            ),
            icon: const Icon(CupertinoIcons.tags),
          ),
        ),
      ],
    );
  }
}
