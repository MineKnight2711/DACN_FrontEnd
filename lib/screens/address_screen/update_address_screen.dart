// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/controller/address_controller.dart';
import 'package:fooddelivery_fe/model/address_model.dart';
import 'package:fooddelivery_fe/screens/address_screen/components/list_search_address.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_button.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_message.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_textfield.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateAddressScreen extends StatelessWidget {
  final AddressModel address;
  final addressController = Get.find<AddressController>();
  UpdateAddressScreen({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          addressController.refresh();
          Get.back();
        },
        title: tr("address_screen.update_address"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(children: [
          RoundTextfield(
            onTap: () {
              addressController.bondDropDownList("province");
            },
            controller:
                addressController.updateAddressTextControllers.txtProvince,
            hintText: tr("address_screen.enter_province"),
            onChanged: (province) {
              addressController.searchProvince("$province");
              address.province = addressController
                  .updateAddressTextControllers.txtProvince.text;
            },
          ),
          Obx(() {
            if (addressController.listSearchProvince.isNotEmpty) {
              return ListSearchAddress(
                onItemSelected: (value) {
                  addressController.updateAddressTextControllers.txtProvince
                      .text = value.name;
                },
                listItem: addressController.listSearchProvince,
              );
            }
            return const SizedBox.shrink();
          }),
          SizedBox(
            height: 20.h,
          ),
          RoundTextfield(
            onTap: () {
              addressController.bondDropDownList("district");
            },
            controller:
                addressController.updateAddressTextControllers.txtDistrict,
            hintText: tr("address_screen.enter_district"),
            onChanged: (district) {
              addressController.searchDistrict("$district");
              address.district = addressController
                  .updateAddressTextControllers.txtDistrict.text;
            },
          ),
          Obx(() {
            if (addressController.listSearchDistrict.isNotEmpty) {
              return ListSearchAddress(
                onItemSelected: (value) {
                  addressController.updateAddressTextControllers.txtDistrict
                      .text = value.name;
                },
                listItem: addressController.listSearchDistrict,
              );
            }
            return const SizedBox.shrink();
          }),
          SizedBox(
            height: 20.h,
          ),
          RoundTextfield(
            onTap: () {
              addressController.bondDropDownList("ward");
            },
            controller: addressController.updateAddressTextControllers.txtWard,
            hintText: tr("address_screen.enter_ward"),
            onChanged: (ward) {
              addressController.searchWard("$ward");
              address.ward =
                  addressController.updateAddressTextControllers.txtWard.text;
            },
          ),
          Obx(() {
            if (addressController.listSearchWard.isNotEmpty) {
              return ListSearchAddress(
                onItemSelected: (value) {
                  addressController.updateAddressTextControllers.txtWard.text =
                      value.name;
                },
                listItem: addressController.listSearchWard,
              );
            }
            return const SizedBox.shrink();
          }),
          SizedBox(
            height: 20.h,
          ),
          RoundTextfield(
            onTap: () {
              addressController.bondDropDownList("");
            },
            controller:
                addressController.updateAddressTextControllers.txtDetails,
            hintText: tr("address_screen.enter_house_number_street"),
            onChanged: (details) {
              address.details = details;
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          RoundTextfield(
            onTap: () {
              addressController.bondDropDownList("");
            },
            controller:
                addressController.updateAddressTextControllers.txtAddressName,
            hintText: tr("address_screen.enter_address_name"),
            onChanged: (addressName) {
              address.addressName = addressName;
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          RoundTextfield(
            onTap: () {
              addressController.bondDropDownList("");
            },
            controller:
                addressController.updateAddressTextControllers.txtReceiverName,
            hintText: tr("address_screen.enter_recipient_name"),
            onChanged: (receiverName) {
              address.receiverName = receiverName;
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          RoundTextfield(
            onTap: () {
              addressController.bondDropDownList("");
            },
            controller:
                addressController.updateAddressTextControllers.txtReceiverPhone,
            hintText: tr("address_screen.enter_recipient_phone_number"),
            onChanged: (receiverPhone) {
              address.receiverPhone = receiverPhone;
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          Visibility(
            visible: address.defaultAddress == false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tr("address_screen.set_as_default_address"),
                    style: GoogleFonts.roboto(fontSize: 16.r)),
                Transform.scale(
                  scale: 1.2,
                  child: Obx(
                    () => Switch(
                      activeColor: AppColors.orange100,
                      value: addressController.isDefaultAddress.value,
                      onChanged: (value) {
                        addressController.isDefaultAddress.value = value;
                        address.defaultAddress = value;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          RoundIconButton(
            size: 80.r,
            title: tr("address_screen.update_address"),
            onPressed: () async {
              showLoadingAnimation(
                  context, "assets/animations/loading.json", 180);

              String? result =
                  await addressController.updateAddress(address).whenComplete(
                        () => Navigator.pop(context),
                      );
              if (result == "Success") {
                showCustomSnackBar(context, "Thông báo",
                    "Cập nhật địa chỉ thành công", ContentType.success, 2);
                addressController.getAllAddress();
                Get.back();
                addressController.refresh();
              } else {
                showCustomSnackBar(
                    context,
                    "Lỗi",
                    "Cập nhật địa chỉ thất bại\n Chi tiết:$result",
                    ContentType.failure,
                    2);
              }
            },
          )
        ]),
      ),
    );
  }
}
