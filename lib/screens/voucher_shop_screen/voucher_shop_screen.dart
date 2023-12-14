// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/voucher_controller.dart';
import 'package:fooddelivery_fe/screens/voucher_shop_screen/components/sorting_voucher_popups_menu.dart';
import 'package:fooddelivery_fe/screens/voucher_shop_screen/components/voucher_item.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_message.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';

class VoucherShopScreen extends GetView {
  final voucherController = Get.find<VoucherController>();
  final accountController = Get.find<AccountController>();
  VoucherShopScreen({super.key});
  Future<bool> onRefesh() async {
    await accountController.fetchCurrentUser();
    await voucherController.getAllVoucher();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Get.back();
        },
        title: "Đổi voucher",
        actions: [SortingPopupMenu(voucherController: voucherController)],
      ),
      body: RefreshIndicator(
        onRefresh: onRefesh,
        child: NoGlowingScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/point.png"),
                  Column(
                    children: [
                      Text(
                        "Số điểm hiện tại của bạn",
                        style: CustomFonts.customGoogleFonts(fontSize: 14.r),
                      ),
                      Obx(
                        () => Text(
                          "${accountController.accountSession.value?.points}",
                          style: CustomFonts.customGoogleFonts(fontSize: 14.r),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Obx(() {
                if (voucherController.listVoucher.isNotEmpty) {
                  return Column(
                    children: voucherController.listVoucher
                        .map(
                          (voucher) => VoucherItem(
                            getVoucher: () async {
                              showLoadingAnimation(context,
                                  "assets/animations/loading.json", 180);
                              String result = await voucherController
                                  .saveVoucherToAccount(
                                      "${accountController.accountSession.value?.accountID}",
                                      "${voucher.voucherID}")
                                  .whenComplete(() {
                                Get.back();
                                accountController.fetchCurrentUser();
                              });
                              switch (result) {
                                case "Success":
                                  showCustomSnackBar(
                                      context,
                                      "Thông báo",
                                      "Thêm voucher thành công!",
                                      ContentType.success,
                                      2);
                                  break;
                                case "NotEnoughPoints":
                                  showCustomSnackBar(
                                      context,
                                      "Thông báo",
                                      "Bạn chưa đủ điểm để nhận voucher này!",
                                      ContentType.failure,
                                      2);
                                  break;
                                case "DuplicatedVoucher":
                                  showCustomSnackBar(
                                      context,
                                      "Thông báo",
                                      "Bạn đã có voucher này rồi!",
                                      ContentType.failure,
                                      2);
                                  break;
                                default:
                                  showCustomSnackBar(
                                      context,
                                      "Lỗi ",
                                      "Lỗi chưa xác định!\nChi tiết :$result",
                                      ContentType.failure,
                                      2);
                                  break;
                              }
                            },
                            voucher: voucher,
                          ),
                        )
                        .toList(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
