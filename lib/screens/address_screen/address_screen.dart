import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/api/vietnam_province_api/province_api.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/screens/address_screen/components/list_ward_district_province.dart';
import 'package:fooddelivery_fe/screens/address_screen/components/province_dropdown.dart';
import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_textfield.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';

class DropdownManager {
  String? _openDropdownTag;

  void openDropdown(String dropDownTag) {
    if (_openDropdownTag != null) {
      // Close the previously open one
      // (Logic to do this later)
    }

    _openDropdownTag = dropDownTag;

    // Open logic
  }

  void closeDropdown(String dropDownTag) {
    _openDropdownTag = null;

    // Close logic
  }

  bool isOpen(String dropDownTag) {
    return _openDropdownTag == dropDownTag;
  }
}

class AddressScreen extends GetView {
  AddressScreen({super.key});
  final provinceApi = Get.find<ProvinceApi>();
  final dropDownManager = DropdownManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Địa chỉ của bạn",
        onPressed: () {
          Navigator.pop(context);

          provinceApi.refresh();
        },
        actions: [
          Obx(
            () => Visibility(
              visible: provinceApi.selectedProvince.value != null ||
                  provinceApi.selectedDistrict.value != null ||
                  provinceApi.selectedWard.value != null ||
                  provinceApi
                      .textControllers.value.txtDetails.text.isNotEmpty ||
                  provinceApi.textControllers.value.txtDetails.text != "",
              child: IconButton(
                splashRadius: 20.r,
                onPressed: () {
                  provinceApi.refresh();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Obx(
            //   () => RoundTextfield(
            //     enable: provinceApi.selectedProvince.value == null,
            //     hintText: "Nhập tỉnh..",
            //     controller: provinceApi.textControllers.value.txtProvince,
            //     onChanged: provinceApi.searchProvince,
            //   ),
            // ),
            Container(
              alignment: Alignment.center,
              width: 200.w,
              child: Obx(
                () => ProvinceDropdown(
                  enable: provinceApi.selectedProvince.value == null,
                  title: provinceApi.selectedProvince.value != null
                      ? "${provinceApi.selectedProvince.value?.name}"
                      : "Chọn tỉnh/thành phố",
                  listDropDown: provinceApi.listProvince,
                  onItemSelected: (province) {
                    provinceApi.getProvince(province.code);
                    print(provinceApi.selectedProvince.value?.name);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              alignment: Alignment.center,
              width: 200.w,
              child: Obx(
                () => ProvinceDropdown(
                  enable: provinceApi.selectedDistrict.value == null &&
                      provinceApi.selectedProvince.value != null,
                  title: provinceApi.selectedDistrict.value != null
                      ? "${provinceApi.selectedDistrict.value?.name}"
                      : "Chọn quận/huyện",
                  listDropDown: provinceApi.listDistrict,
                  onItemSelected: (value) {
                    provinceApi.getDistrict(value.code);
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              alignment: Alignment.center,
              width: 200.w,
              child: Obx(
                () => ProvinceDropdown(
                  enable: provinceApi.selectedProvince.value != null &&
                      provinceApi.selectedDistrict.value != null &&
                      provinceApi.selectedWard.value == null,
                  title: provinceApi.selectedWard.value != null
                      ? "${provinceApi.selectedWard.value?.name}"
                      : "Chọn phường/xã",
                  listDropDown: provinceApi.listWard,
                  onItemSelected: (value) {
                    provinceApi.selectedWard.value = value;
                    print(value.name);
                  },
                ),
              ),
            ),

            // Obx(
            //   () {
            //     if (provinceApi.listProvince.isNotEmpty) {
            //       return Container(
            //         height: 120,
            //         margin: const EdgeInsets.only(top: 5),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             color: AppColors.gray15),
            //         child: ListProvince(provinceApi: provinceApi),
            //       );
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),

            // Obx(
            //   () => RoundTextfield(
            //     enable: provinceApi.selectedProvince.value != null &&
            //         provinceApi.selectedDistrict.value == null,
            //     hintText: "Nhập quận..",
            //     controller: provinceApi.textControllers.value.txtDistrict,
            //     onChanged: provinceApi.searchDistrict,
            //   ),
            // ),
            // Obx(
            //   () {
            //     if (provinceApi.listDistrict.isNotEmpty) {
            //       return Container(
            //         height: 120,
            //         margin: const EdgeInsets.only(top: 5),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             color: AppColors.gray15),
            //         child: ListDistrict(provinceApi: provinceApi),
            //       );
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // Obx(
            //   () => RoundTextfield(
            //     enable: provinceApi.selectedProvince.value != null &&
            //         provinceApi.selectedDistrict.value != null &&
            //         provinceApi.selectedWard.value == null,
            //     hintText: "Nhập phường..",
            //     controller: provinceApi.textControllers.value.txtWard,
            //     onChanged: provinceApi.searchWard,
            //   ),
            // ),
            // Obx(
            //   () {
            //     if (provinceApi.listWard.isNotEmpty) {
            //       return Container(
            //         height: 120,
            //         margin: const EdgeInsets.only(top: 5),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10),
            //             color: AppColors.gray15),
            //         child: ListWard(provinceApi: provinceApi),
            //       );
            //     }
            //     return const SizedBox.shrink();
            //   },
            // ),
            SizedBox(
              height: 30.h,
            ),
            Obx(
              () => Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: RoundTextfield(
                  enable: provinceApi.selectedProvince.value != null &&
                      provinceApi.selectedDistrict.value != null &&
                      provinceApi.selectedWard.value != null,
                  hintText: "Nhập số nhà/ đường..",
                  controller: provinceApi.textControllers.value.txtDetails,
                  onChanged: (value) {
                    provinceApi.details.value = value ?? "";
                  },
                ),
              ),
            ),
            Obx(() => Text(
                "${provinceApi.details.value}, ${provinceApi.selectedWard.value?.name}, ${provinceApi.selectedDistrict.value?.name}, ${provinceApi.selectedProvince.value?.name}"))
          ],
        ),
      ),
    );
  }
}

// class ProvinceCombobox extends StatelessWidget {
//   ProvinceCombobox({super.key});
//   final provinceApi = Get.find<ProvinceApi>();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () {
//         if (provinceApi.listProvince.isNotEmpty) {
//           return DropdownButton(
//             menuMaxHeight: 200.h,
//             isExpanded: true,
//             hint: provinceApi.selectedProvince.value != null
//                 ? Text('${provinceApi.selectedProvince.value?.name}')
//                 : const Text('Chọn tỉnh'),
//             onChanged: (value) {
//               provinceApi.selectedProvince.value = value;
//             },
//             items: provinceApi.listProvince.map((province) {
//               return DropdownMenuItem(
//                 value: province,
//                 child: Text(province.name),
//               );
//             }).toList(),
//           );
//         }
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );
//   }
// }
