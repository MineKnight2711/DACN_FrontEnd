// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/api/province_api/model/province_model.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/address_controller.dart';
import 'package:fooddelivery_fe/controller/map_controller.dart';
import 'package:fooddelivery_fe/model/address_model.dart';
import 'package:fooddelivery_fe/screens/address_screen/components/province_dropdown.dart';
import 'package:fooddelivery_fe/screens/mapscreen/map_screen.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_button.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_message.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_textfield.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAddressScreen extends GetView {
  AddAddressScreen({super.key});
  final _addressController = Get.find<AddressController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: tr("address_screen.appbar.your_address"),
        onPressed: () {
          Get.back();
          Get.delete<MapController>();
          _addressController.refresh();
        },
        actions: [
          Obx(
            () => Visibility(
              visible: _addressController.selectedProvince.value != null ||
                  _addressController.selectedDistrict.value != null ||
                  _addressController.selectedWard.value != null ||
                  _addressController
                      .textControllers.value.txtDetails.text.isNotEmpty ||
                  _addressController.textControllers.value.txtDetails.text !=
                      "",
              child: IconButton(
                splashRadius: 20.r,
                onPressed: () {
                  _addressController.refresh();
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
              SizedBox(
                height: 10.h,
              ),
              TextButton.icon(
                onPressed: () async {
                  final _mapController = Get.put(MapController());
                  final result = await _mapController.findCurrentLocation();
                  if (result == "Success") {
                    Get.to(MapScreen(
                      onChooseAddress: (location) {
                        if (_mapController.selectedLocation.value != null) {
                          AddressModel _selectedAddress = AddressModel();
                          _selectedAddress.details = _mapController
                              .selectedLocation.value?.results.name;
                          _selectedAddress.ward = _mapController
                              .selectedLocation.value?.results.compound.commune;
                          _selectedAddress.district =
                              location.results.compound.district;
                          _selectedAddress.province =
                              location.results.compound.province;
                          _addressController.selectedAddress.value =
                              _selectedAddress;
                          _addressController.selectedWard.value = Ward(
                              code: 0,
                              name: "${location.results.compound.commune}");
                          _addressController.selectedDistrict.value = District(
                              code: 0,
                              name: "${location.results.compound.district}",
                              wards: []);
                          _addressController.selectedProvince.value = Province(
                              code: 0,
                              name: "${location.results.compound.province}",
                              districts: []);
                          Get.back(closeOverlays: false);
                          Get.delete<MapController>();
                        }
                      },
                    ), transition: Transition.upToDown);
                  } else {
                    showCustomSnackBar(context, "Thông báo",
                        "Vui lòng bật định vị!", ContentType.help, 2);
                  }
                },
                icon: const Icon(Icons.location_history),
                label: Obx(
                  () => Text(
                    _addressController.selectedAddress.value != null
                        ? "${_addressController.selectedAddress.value?.details}, ${_addressController.selectedAddress.value?.ward}, ${_addressController.selectedAddress.value?.district}, ${_addressController.selectedAddress.value?.province}"
                        : tr("address_screen.choose_on_map"),
                    maxLines: 2,
                    style: CustomFonts.customGoogleFonts(fontSize: 16.r),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                alignment: Alignment.center,
                child: Obx(
                  () => ProvinceDropdown(
                    enable: _addressController.selectedProvince.value == null,
                    title: _addressController.selectedProvince.value != null
                        ? "${_addressController.selectedProvince.value?.name}"
                        : tr("address_screen.select_province_city"),
                    listDropDown: _addressController.listProvince,
                    onItemSelected: (province) {
                      _addressController.getProvince(province.code);
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
                    enable: _addressController.selectedDistrict.value == null &&
                        _addressController.selectedProvince.value != null,
                    title: _addressController.selectedDistrict.value != null
                        ? "${_addressController.selectedDistrict.value?.name}"
                        : tr("address_screen.select_district"),
                    listDropDown: _addressController.listDistrict,
                    onItemSelected: (value) {
                      _addressController.getDistrict(value.code);
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
                    enable: _addressController.selectedProvince.value != null &&
                        _addressController.selectedDistrict.value != null &&
                        _addressController.selectedWard.value == null,
                    title: _addressController.selectedWard.value != null
                        ? "${_addressController.selectedWard.value?.name}"
                        : tr("address_screen.select_ward"),
                    listDropDown: _addressController.listWard,
                    onItemSelected: (value) {
                      _addressController.selectedWard.value = value;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(
                () => RoundTextfield(
                  hintText: tr("address_screen.enter_house_number_street"),
                  controller:
                      _addressController.textControllers.value.txtDetails,
                  onChanged: (value) {
                    _addressController.details.value = value ?? "";
                  },
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(
                () => RoundTextfield(
                  hintText: tr("address_screen.enter_address_name"),
                  controller:
                      _addressController.textControllers.value.txtAddressName,
                  onChanged: (value) {
                    _addressController.addressName.value = value ?? "";
                  },
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(
                () => RoundTextfield(
                  hintText: tr("address_screen.enter_recipient_name"),
                  controller:
                      _addressController.textControllers.value.txtReceiverName,
                  onChanged: (value) {
                    _addressController.receiverName.value = value ?? "";
                  },
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Obx(
                () => RoundTextfield(
                  hintText: tr("address_screen.enter_recipient_phone_number"),
                  controller:
                      _addressController.textControllers.value.txtReceiverPhone,
                  onChanged: (value) {
                    _addressController.receiverPhone.value = value ?? "";
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
                    Text(tr("address_screen.set_as_default_address"),
                        style: GoogleFonts.roboto(fontSize: 16.r)),
                    Transform.scale(
                      scale: 1.2,
                      child: Switch(
                        activeColor: AppColors.orange100,
                        value: _addressController.isDefaultAddress.value,
                        onChanged: (value) {
                          _addressController.isDefaultAddress.value = value;
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
                  enabled: _addressController.selectedProvince.value != null &&
                      _addressController.selectedDistrict.value != null &&
                      _addressController.selectedWard.value != null &&
                      _addressController.details.value != "" &&
                      _addressController.addressName.value != "" &&
                      _addressController.receiverName.value != "" &&
                      _addressController.receiverPhone.value != "",
                  size: 90.r,
                  title: tr("address_screen.new_address_button"),
                  onPressed: () async {
                    showLoadingAnimation(
                        context, "assets/animations/loading.json", 180);
                    AddressModel newAddress = AddressModel();
                    newAddress.details = _addressController.details.value;
                    newAddress.ward =
                        _addressController.selectedWard.value?.name;
                    newAddress.district =
                        _addressController.selectedDistrict.value?.name;
                    newAddress.province =
                        _addressController.selectedProvince.value?.name;
                    newAddress.addressName =
                        _addressController.addressName.value;
                    newAddress.receiverName =
                        _addressController.receiverName.value;
                    newAddress.receiverPhone =
                        _addressController.receiverPhone.value;
                    newAddress.defaultAddress =
                        _addressController.isDefaultAddress.value;
                    String? result = await _addressController
                        .saveAddress(newAddress)
                        .whenComplete(
                          () => Get.back(),
                        );
                    if (result == "Success") {
                      showCustomSnackBar(context, "Thông báo",
                          "Thêm địa chỉ thành công", ContentType.success, 2);
                      _addressController.getAllAddress();
                      Get.back();
                      _addressController.refresh();
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
