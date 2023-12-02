import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/address_controller.dart';
import 'package:fooddelivery_fe/screens/address_screen/add_address_screen.dart';
import 'package:fooddelivery_fe/screens/address_screen/components/address_item.dart';
import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_button.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';

class AddressListScreen extends GetView {
  AddressListScreen({super.key});
  final accountController = Get.find<AccountController>();
  final addressController = Get.find<AddressController>();
  Future<void> refresh() async {
    await addressController.getListAddressByAccountId(
        "${accountController.accountSession.value?.accountID}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Get.delete<AddressController>();
          Navigator.pop(context);
        },
        showLeading: true,
        title: "Địa chỉ của bạn",
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: NoGlowingScrollView(
          child: Obx(() {
            if (addressController.listAddress.isNotEmpty) {
              return Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: addressController.listAddress
                        .map(
                          (add) => AddressItem(
                            add: add,
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 80.h,
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: RoundIconButton(
          size: 90.r,
          title: "Thêm địa chỉ",
          onPressed: () {
            Get.to(() => AddAddressScreen(), transition: Transition.downToUp);
          },
        ),
      ),
    );
  }
}
