// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/controller/vietname_province_controller/province_api_controller.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/address_controller.dart';
import 'package:fooddelivery_fe/model/address_model.dart';
import 'package:fooddelivery_fe/screens/address_screen/address_list_screen.dart';
import 'package:fooddelivery_fe/screens/address_screen/components/province_dropdown.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_button.dart';
import 'package:fooddelivery_fe/widgets/custom_message.dart';
import 'package:fooddelivery_fe/widgets/custom_textfield.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAddressScreen extends GetView {
  AddAddressScreen({super.key});
  final provinceController = Get.find<ProvinceController>();
  final addressController = Get.find<AddressController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Thêm địa chỉ mới",
        onPressed: () {
          Navigator.pop(context);

          provinceController.refresh();
        },
        actions: [
          Obx(
            () => Visibility(
              visible: provinceController.selectedProvince.value != null ||
                  provinceController.selectedDistrict.value != null ||
                  provinceController.selectedWard.value != null ||
                  provinceController
                      .textControllers.value.txtDetails.text.isNotEmpty ||
                  provinceController.textControllers.value.txtDetails.text !=
                      "",
              child: IconButton(
                splashRadius: 20.r,
                onPressed: () {
                  provinceController.refresh();
                },
                icon: const Icon(
                  Icons.refresh,
                  color: AppColors.dark80,
                ),
              ),
            ),
          ),
        ],
      ),
      body: NoGlowingScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Obx(
                  () => ProvinceDropdown(
                    enable: provinceController.selectedProvince.value == null,
                    title: provinceController.selectedProvince.value != null
                        ? "${provinceController.selectedProvince.value?.name}"
                        : "Chọn tỉnh/thành phố",
                    listDropDown: provinceController.listProvince,
                    onItemSelected: (province) {
                      provinceController.getProvince(province.code);
                      print(provinceController.selectedProvince.value?.name);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Obx(
                  () => ProvinceDropdown(
                    enable: provinceController.selectedDistrict.value == null &&
                        provinceController.selectedProvince.value != null,
                    title: provinceController.selectedDistrict.value != null
                        ? "${provinceController.selectedDistrict.value?.name}"
                        : "Chọn quận/huyện",
                    listDropDown: provinceController.listDistrict,
                    onItemSelected: (value) {
                      provinceController.getDistrict(value.code);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Align(
                alignment: Alignment.center,
                child: Obx(
                  () => ProvinceDropdown(
                    enable: provinceController.selectedProvince.value != null &&
                        provinceController.selectedDistrict.value != null &&
                        provinceController.selectedWard.value == null,
                    title: provinceController.selectedWard.value != null
                        ? "${provinceController.selectedWard.value?.name}"
                        : "Chọn phường/xã",
                    listDropDown: provinceController.listWard,
                    onItemSelected: (value) {
                      provinceController.selectedWard.value = value;
                      print(value.name);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(
                () => RoundTextfield(
                  hintText: "Nhập số nhà/ đường..",
                  controller:
                      provinceController.textControllers.value.txtDetails,
                  onChanged: (value) {
                    provinceController.details.value = value ?? "";
                  },
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(
                () => RoundTextfield(
                  hintText: "Nhập tên địa chỉ..",
                  controller:
                      provinceController.textControllers.value.txtAddressName,
                  onChanged: (value) {
                    provinceController.addressName.value = value ?? "";
                  },
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(
                () => RoundTextfield(
                  hintText: "Nhập tên người nhận..",
                  controller:
                      provinceController.textControllers.value.txtReceiverName,
                  onChanged: (value) {
                    provinceController.receiverName.value = value ?? "";
                  },
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(
                () => RoundTextfield(
                  hintText: "Nhập số điện thoại người nhận..",
                  controller:
                      provinceController.textControllers.value.txtReceiverPhone,
                  onChanged: (value) {
                    provinceController.receiverPhone.value = value ?? "";
                  },
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Đặt làm địa chỉ mặc định",
                        style: GoogleFonts.roboto(fontSize: 16.r)),
                    Transform.scale(
                      scale: 1.2,
                      child: Switch(
                        activeColor: AppColors.orange100,
                        value: provinceController.isDefaultAddress.value,
                        onChanged: (value) {
                          provinceController.isDefaultAddress.value = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(
                () => RoundIconButton(
                  enabled: provinceController.selectedProvince.value != null &&
                      provinceController.selectedDistrict.value != null &&
                      provinceController.selectedWard.value != null &&
                      provinceController.details.value != "" &&
                      provinceController.addressName.value != "" &&
                      provinceController.receiverName.value != "" &&
                      provinceController.receiverPhone.value != "",
                  size: 90.r,
                  title: "Lưu",
                  onPressed: () async {
                    showLoadingAnimation(
                        context, "assets/animations/loading.json", 180);
                    AddressModel newAddress = AddressModel();
                    newAddress.details = provinceController.details.value;
                    newAddress.ward =
                        provinceController.selectedWard.value?.name;
                    newAddress.district =
                        provinceController.selectedDistrict.value?.name;
                    newAddress.province =
                        provinceController.selectedProvince.value?.name;
                    newAddress.addressName =
                        provinceController.addressName.value;
                    newAddress.receiverName =
                        provinceController.receiverName.value;
                    newAddress.receiverPhone =
                        provinceController.receiverPhone.value;
                    newAddress.defaultAddress =
                        provinceController.isDefaultAddress.value;
                    String? result = await addressController
                        .saveAddress(newAddress)
                        .whenComplete(
                          () => Navigator.pop(context),
                        );
                    if (result == "Success") {
                      showCustomSnackBar(context, "Thông báo",
                          "Thêm địa chỉ thành công", ContentType.success, 2);
                      addressController.getAllAddress();
                      Get.off(AddressListScreen(),
                          transition: Transition.upToDown);
                      provinceController.refresh();
                    } else {
                      showCustomSnackBar(
                          context,
                          "Lỗi",
                          "Thêm địa chỉ thất bại\n Chi tiết:$result",
                          ContentType.failure,
                          2);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
