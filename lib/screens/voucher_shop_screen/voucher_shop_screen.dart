import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/voucher_controller.dart';
import 'package:fooddelivery_fe/screens/voucher_shop_screen/components/voucher_item.dart';
import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
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
                            getVoucher: () {},
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
