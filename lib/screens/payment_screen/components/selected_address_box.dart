import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/transaction_controller.dart';
import 'package:fooddelivery_fe/screens/payment_screen/components/choose_address_screen.dart';
import 'package:get/get.dart';

class AccountAddress extends StatelessWidget {
  const AccountAddress({
    super.key,
    required this.transactionController,
  });

  final TransactionController transactionController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.h,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.dark100,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("payment.address_box.recipient_information"),
                    style: CustomFonts.customGoogleFonts(fontSize: 14.r),
                  ),
                  Obx(
                    () => Text(
                      "${transactionController.selectedAddress.value?.receiverName} | ${transactionController.selectedAddress.value?.receiverPhone}",
                      style: CustomFonts.customGoogleFonts(
                          fontSize: 13.r, color: AppColors.dark20),
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                label: Text(
                  tr("payment.address_box.address_edit"),
                  style: CustomFonts.customGoogleFonts(fontSize: 14.r),
                ),
                onPressed: () {
                  Get.to(ChooseAddressScreen(),
                      transition: Transition.rightToLeft);
                },
                icon: const Icon(
                  CupertinoIcons.pencil,
                  size: 18,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr("payment.address_box.address"),
                style: CustomFonts.customGoogleFonts(fontSize: 14.r),
              ),
              Text(
                "${transactionController.selectedAddress.value?.details}, ${transactionController.selectedAddress.value?.ward}, ${transactionController.selectedAddress.value?.district}, ${transactionController.selectedAddress.value?.province}",
                textAlign: TextAlign.justify,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: CustomFonts.customGoogleFonts(
                    fontSize: 13.r, color: AppColors.dark20),
              ),
            ],
          )
        ],
      ),
    );
  }
}
