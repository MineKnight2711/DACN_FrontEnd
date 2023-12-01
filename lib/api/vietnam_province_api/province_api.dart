import 'dart:convert';

import 'package:fooddelivery_fe/api/vietnam_province_api/model/province_model.dart';
import 'package:fooddelivery_fe/utils/text_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ProvinceApi extends GetxController {
  RxList<Province> listProvince = <Province>[].obs;
  RxList<District> listDistrict = <District>[].obs;
  RxList<Ward> listWard = <Ward>[].obs;

  Rx<Province?> selectedProvince = Rx<Province?>(null);
  Rx<District?> selectedDistrict = Rx<District?>(null);
  Rx<Ward?> selectedWard = Rx<Ward?>(null);
  Rx<AddressTextController> textControllers = AddressTextController().obs;

  RxBool isProvinceDropDown = false.obs;
  RxBool isDistrictDropDown = false.obs;
  RxBool isWardDropDown = false.obs;
  RxString details = "".obs;
  @override
  void refresh() {
    textControllers.value.clearText();
    listProvince.clear();
    listDistrict.clear();
    listWard.clear();
    selectedProvince.value = selectedDistrict.value = selectedWard.value = null;
    getAllProvine();
  }

  String? searchWard(String? ward) {
    if (selectedDistrict.value != null) {
      getWard(ward.toString(), selectedDistrict.value!.code);
      return null;
    }
    return "Vui lòng chọn quận!";
  }

  // String? searchProvince(String? province) {
  //   getProvine(province.toString());
  //   return null;
  // }

  Future<void> getAllProvine() async {
    String url = 'https://provinces.open-api.vn/api/p/';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final listProvinceJson =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      listProvince.value = listProvinceJson
          .map(
            (provinceMap) => Province.fromJson(provinceMap),
          )
          .toList();
    }
  }

  Future<void> getProvince(int provinceCode) async {
    String url = 'https://provinces.open-api.vn/api/p/$provinceCode?depth=2';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Logger()
          .i("Loggggggg tỉnh ${jsonDecode(utf8.decode(response.bodyBytes))}");
      selectedProvince.value =
          Province.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      listDistrict.value = selectedProvince.value?.districts ?? [];
    }
  }

  Future<void> getDistrict(int provindeCode) async {
    String url = "https://provinces.open-api.vn/api/d/$provindeCode?depth=2";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Logger().i(
          "Loggggggg quận/huyện ${jsonDecode(utf8.decode(response.bodyBytes))}");
      selectedDistrict.value =
          District.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      listWard.value = selectedDistrict.value?.wards ?? [];
    }
  }

  Future<void> getWard(String ward, int districtCode) async {
    String url =
        'https://provinces.open-api.vn/api/w/search/?q=$ward&d=$districtCode';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final listWardJson =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      listWard.value = listWardJson
          .map(
            (wardMap) => Ward.fromJson(wardMap),
          )
          .toList();
    }
  }
}
