import 'package:fooddelivery_fe/api/address_api/address_api.dart';
import 'package:fooddelivery_fe/api/province_api/province_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/model/address_model.dart';
import 'package:fooddelivery_fe/utils/text_controller.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../api/province_api/model/province_model.dart';

class AddressController extends GetxController {
  late AddressApi addressApi;
  late ProvinceApi provinceApi;
  final accountController = Get.find<AccountController>();

  RxList<AddressModel> listAddress = <AddressModel>[].obs;

  RxList<Province> listProvince = <Province>[].obs;
  RxList<District> listDistrict = <District>[].obs;
  RxList<Ward> listWard = <Ward>[].obs;

  RxList<SearchedProvinceDistrictWard> listSearchProvince =
      <SearchedProvinceDistrictWard>[].obs;
  RxList<SearchedProvinceDistrictWard> listSearchDistrict =
      <SearchedProvinceDistrictWard>[].obs;
  RxList<SearchedProvinceDistrictWard> listSearchWard =
      <SearchedProvinceDistrictWard>[].obs;

  Rx<Province?> selectedProvince = Rx<Province?>(null);
  Rx<District?> selectedDistrict = Rx<District?>(null);
  Rx<Ward?> selectedWard = Rx<Ward?>(null);

  final textControllers = AddressTextController().obs;

  final updateAddressTextControllers = UpdateAddressTextController();

  RxBool isDefaultAddress = false.obs;

  RxString details = "".obs;
  RxString addressName = "".obs;
  RxString receiverName = "".obs;
  RxString receiverPhone = "".obs;
  @override
  void onInit() {
    super.onInit();
    addressApi = AddressApi();
    provinceApi = ProvinceApi();
  }

  @override
  void refresh() {
    textControllers.value.clearText();
    updateAddressTextControllers.clearText();
    listProvince.clear();
    listDistrict.clear();
    listWard.clear();
    listSearchDistrict.clear();
    listSearchProvince.clear();
    listSearchWard.clear();
    isDefaultAddress.value = false;
    details.value =
        addressName.value = receiverName.value = receiverPhone.value = "";
    selectedProvince.value = selectedDistrict.value = selectedWard.value = null;
    getAllProvine();
  }

  void bondDropDownList(String textFieldTap) {
    switch (textFieldTap) {
      case "province":
        listSearchDistrict.clear();
        listSearchWard.clear();
        break;
      case "district":
        listSearchProvince.clear();
        listSearchWard.clear();
        break;
      case "ward":
        listSearchProvince.clear();
        listSearchDistrict.clear();
        break;
      default:
        listSearchProvince.clear();
        listSearchDistrict.clear();
        listSearchWard.clear();
    }
  }

  Future<void> searchProvince(String province) async {
    final response = await provinceApi.apiSearchProvince(province);
    if (response.message == "Success") {
      final listProvinceJson = response.data as List<dynamic>;
      listSearchProvince.value = listProvinceJson
          .map(
            (provinceMap) => SearchedProvinceDistrictWard.fromJson(provinceMap),
          )
          .take(10)
          .toList();
    }
  }

  Future<void> searchDistrict(String district) async {
    final response = await provinceApi.apiSearchDistrict(district);
    if (response.message == "Success") {
      final listDistrictJson = response.data as List<dynamic>;
      listSearchDistrict.value = listDistrictJson
          .map(
            (districtMap) => SearchedProvinceDistrictWard.fromJson(districtMap),
          )
          .take(10)
          .toList();
    }
  }

  Future<void> searchWard(String ward) async {
    final response = await provinceApi.apiSearchWard(ward);
    if (response.message == "Success") {
      final listWardJson = response.data as List<dynamic>;
      listSearchWard.value = listWardJson
          .map(
            (wardMap) => SearchedProvinceDistrictWard.fromJson(wardMap),
          )
          .take(10)
          .toList();
    }
  }

  void getAllAddress() {
    if (accountController.accountSession.value != null) {
      getListAddressByAccountId(
          "${accountController.accountSession.value?.accountID}");
    }
  }

  Future<void> getAllProvine() async {
    final response = await provinceApi.getAllProvine();
    if (response.message == "Success") {
      final listProvinceJson = response.data as List<dynamic>;
      listProvince.value = listProvinceJson
          .map(
            (provinceMap) => Province.fromJson(provinceMap),
          )
          .toList();
    }
  }

  Future<void> getProvince(int provinceCode) async {
    final response = await provinceApi.getProvince(provinceCode);
    if (response.message == "Success") {
      final provinceJson = response.data;
      selectedProvince.value = Province.fromJson(provinceJson);
      listDistrict.value = selectedProvince.value?.districts ?? [];
    }
  }

  Future<void> getDistrict(int provinceCode) async {
    final response = await provinceApi.getDistrict(provinceCode);
    if (response.message == "Success") {
      final provinceJson = response.data;
      selectedDistrict.value = District.fromJson(provinceJson);
      listWard.value = selectedDistrict.value?.wards ?? [];
    }
  }

  Future<List<AddressModel>?> getListAddressByAccountId(
      String accountId) async {
    final response = await addressApi.getListAddressByAccountId(accountId);
    if (response.message == "Success") {
      final addressReceived = response.data as List<dynamic>;
      listAddress.value = addressReceived
          .map(
            (address) => AddressModel.fromJson(address),
          )
          .toList();
      Logger().i("Loggggg api address ${listAddress.length}");
      return listAddress;
    }
    return null;
  }

  Future<String?> saveAddress(AddressModel address) async {
    final response = await addressApi.saveAddress(
        "${accountController.accountSession.value?.accountID}", address);
    return response.message;
  }

  Future<String?> updateAddress(AddressModel address) async {
    final response = await addressApi.updateAddress(
        "${accountController.accountSession.value?.accountID}", address);
    return response.message;
  }

  Future<String?> deleteAddress(String addressID) async {
    final response = await addressApi.deleteAddress(addressID);
    return response.message;
  }

  void fetchCurrent(AddressModel add) {
    updateAddressTextControllers.txtWard.text = add.ward ?? "";
    updateAddressTextControllers.txtDistrict.text = add.district ?? "";
    updateAddressTextControllers.txtProvince.text = add.province ?? "";
    updateAddressTextControllers.txtDetails.text = add.details ?? "";
    updateAddressTextControllers.txtAddressName.text = add.addressName ?? "";
    updateAddressTextControllers.txtReceiverName.text = add.receiverName ?? "";
    updateAddressTextControllers.txtReceiverPhone.text =
        add.receiverPhone ?? "";
    isDefaultAddress.value = add.defaultAddress ?? false;
  }
}
