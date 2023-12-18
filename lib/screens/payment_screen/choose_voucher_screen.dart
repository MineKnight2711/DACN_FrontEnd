import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/account_voucher_controller.dart';
import 'package:fooddelivery_fe/controller/transaction_controller.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/voucher_coupon.dart';
import 'package:fooddelivery_fe/widgets/empty_widget.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';

class ChooseVoucherScreen extends GetView {
  final TransactionController transactionController;
  ChooseVoucherScreen({super.key, required this.transactionController});

  final accountVoucherController = Get.find<AccountVoucherController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Get.back();
        },
        title: "Voucher của bạn",
      ),
      body: NoGlowingScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Obx(() {
          if (accountVoucherController.listAccountVoucher.isNotEmpty) {
            return Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sẵn sàng sử dụng",
                    style: CustomFonts.customGoogleFonts(fontSize: 16.r),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Column(
                  children: accountVoucherController.listAccountVoucher
                      .map((accountVoucher) => Container(
                            margin: EdgeInsets.symmetric(vertical: 5.w),
                            child: GestureDetector(
                              onTap: () {
                                transactionController.selectedVoucher.value =
                                    accountVoucher.voucher;
                                Get.back();
                              },
                              child: VoucherCoupon(
                                size: 0.8,
                                imagePath: "assets/images/voucher_banner.png",
                                voucherName:
                                    "${accountVoucher.voucher.voucherName}",
                                startDate: DataConvert()
                                    .formattedDateOnlyDayAndMonth(
                                        accountVoucher.voucher.startDate),
                                expDate: DataConvert()
                                    .formattedDateOnlyDayAndMonth(
                                        accountVoucher.voucher.expDate),
                                discount: accountVoucher.voucher.type ==
                                        "Amount"
                                    ? " ${DataConvert().formatCurrency(accountVoucher.voucher.discountAmount!)}"
                                    : accountVoucher.voucher.type == "Percent"
                                        ? " ${accountVoucher.voucher.discountPercent}%"
                                        : "",
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
            );
          }
          return Container(
            color: Colors.white10,
            height: 0.8.sh,
            width: 1.sw,
            child: EmptyWidget(
              assetsAnimations: "cat_sleep",
              tilte: tr("discount.no_voucher"),
            ),
          );
        }),
      )),
    );
  }
}
