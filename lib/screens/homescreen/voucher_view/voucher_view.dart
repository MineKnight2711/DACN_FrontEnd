// ignore_for_file: use_build_context_synchronously,

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/account_voucher_controller.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_message.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/voucher_coupon.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';

class VoucherView extends StatelessWidget {
  final AccountVoucherController accountVoucherController;
  const VoucherView({super.key, required this.accountVoucherController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: NoGlowingScrollView(
        child: Column(
          children: [
            Obx(() {
              if (accountVoucherController.listAccountVoucher.isNotEmpty) {
                return Column(
                  children: [
                    Text(
                      "Voucher của bạn",
                      style: CustomFonts.customGoogleFonts(fontSize: 16.r),
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
                              ))
                          .toList(),
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
            Obx(() {
              if (accountVoucherController.listAccountVoucherExp.isNotEmpty) {
                return Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Đã hết hạn :((\nCác voucher đã hết hạn và không thể sử dụng",
                        style: CustomFonts.customGoogleFonts(
                            fontSize: 16.r, color: Colors.red),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Column(
                      children: accountVoucherController.listAccountVoucherExp
                          .map((accountVoucher) => Slidable(
                                endActionPane: ActionPane(
                                    extentRatio: 0.3,
                                    motion: const DrawerMotion(),
                                    children: [
                                      SlidableAction(
                                        borderRadius: BorderRadius.circular(20),
                                        foregroundColor: Colors.red,
                                        icon: Icons.delete,
                                        label: "Xoá",
                                        onPressed: (context) async {
                                          String result =
                                              await accountVoucherController
                                                  .deleteVoucher(
                                                      "${accountVoucher.voucher.voucherID}");
                                          if (result == "Success") {
                                            await accountVoucherController
                                                .getAllAccountVouchers();
                                            showCustomSnackBar(
                                                context,
                                                "Thông báo",
                                                "Đã xoá voucher",
                                                ContentType.success,
                                                2);
                                          } else {
                                            showCustomSnackBar(
                                                context,
                                                "Lỗi",
                                                "Có lỗi xảy ra!",
                                                ContentType.failure,
                                                2);
                                          }
                                        },
                                      ),
                                    ]),
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 5.w),
                                  child: VoucherCoupon(
                                    size: 0.8,
                                    imagePath:
                                        "assets/images/voucher_banner.png",
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
                                        : accountVoucher.voucher.type ==
                                                "Percent"
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
              return const Card();
            }),
          ],
        ),
      ),
    );
  }
}
