// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
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
  final addressController = Get.find<AddressController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Thêm địa chỉ mới",
        onPressed: () {
          Get.back();

          addressController.refresh();
        },
        actions: [
          Obx(
            () => Visibility(
              visible: addressController.selectedProvince.value != null ||
                  addressController.selectedDistrict.value != null ||
                  addressController.selectedWard.value != null ||
                  addressController
                      .textControllers.value.txtDetails.text.isNotEmpty ||
                  addressController.textControllers.value.txtDetails.text != "",
              child: IconButton(
                splashRadius: 20.r,
                onPressed: () {
                  addressController.refresh();
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
                    enable: addressController.selectedProvince.value == null,
                    title: addressController.selectedProvince.value != null
                        ? "${addressController.selectedProvince.value?.name}"
                        : "Chọn tỉnh/thành phố",
                    listDropDown: addressController.listProvince,
                    onItemSelected: (province) {
                      addressController.getProvince(province.code);
                      print(addressController.selectedProvince.value?.name);
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
                    enable: addressController.selectedDistrict.value == null &&
                        addressController.selectedProvince.value != null,
                    title: addressController.selectedDistrict.value != null
                        ? "${addressController.selectedDistrict.value?.name}"
                        : "Chọn quận/huyện",
                    listDropDown: addressController.listDistrict,
                    onItemSelected: (value) {
                      addressController.getDistrict(value.code);
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
                    enable: addressController.selectedProvince.value != null &&
                        addressController.selectedDistrict.value != null &&
                        addressController.selectedWard.value == null,
                    title: addressController.selectedWard.value != null
                        ? "${addressController.selectedWard.value?.name}"
                        : "Chọn phường/xã",
                    listDropDown: addressController.listWard,
                    onItemSelected: (value) {
                      addressController.selectedWard.value = value;
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
                      addressController.textControllers.value.txtDetails,
                  onChanged: (value) {
                    addressController.details.value = value ?? "";
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
                      addressController.textControllers.value.txtAddressName,
                  onChanged: (value) {
                    addressController.addressName.value = value ?? "";
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
                      addressController.textControllers.value.txtReceiverName,
                  onChanged: (value) {
                    addressController.receiverName.value = value ?? "";
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
                      addressController.textControllers.value.txtReceiverPhone,
                  onChanged: (value) {
                    addressController.receiverPhone.value = value ?? "";
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
                        value: addressController.isDefaultAddress.value,
                        onChanged: (value) {
                          addressController.isDefaultAddress.value = value;
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
                  enabled: addressController.selectedProvince.value != null &&
                      addressController.selectedDistrict.value != null &&
                      addressController.selectedWard.value != null &&
                      addressController.details.value != "" &&
                      addressController.addressName.value != "" &&
                      addressController.receiverName.value != "" &&
                      addressController.receiverPhone.value != "",
                  size: 90.r,
                  title: "Lưu",
                  onPressed: () async {
                    showLoadingAnimation(
                        context, "assets/animations/loading.json", 180);
                    AddressModel newAddress = AddressModel();
                    newAddress.details = addressController.details.value;
                    newAddress.ward =
                        addressController.selectedWard.value?.name;
                    newAddress.district =
                        addressController.selectedDistrict.value?.name;
                    newAddress.province =
                        addressController.selectedProvince.value?.name;
                    newAddress.addressName =
                        addressController.addressName.value;
                    newAddress.receiverName =
                        addressController.receiverName.value;
                    newAddress.receiverPhone =
                        addressController.receiverPhone.value;
                    newAddress.defaultAddress =
                        addressController.isDefaultAddress.value;
                    String? result = await addressController
                        .saveAddress(newAddress)
                        .whenComplete(
                          () => Navigator.pop(context),
                        );
                    if (result == "Success") {
                      showCustomSnackBar(context, "Thông báo",
                          "Thêm địa chỉ thành công", ContentType.success, 2);
                      addressController.getAllAddress();
                      Get.back();
                      addressController.refresh();
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
