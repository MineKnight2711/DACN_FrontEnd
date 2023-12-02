import 'dart:convert';

import 'package:fooddelivery_fe/api/address_api/address_api.dart';
import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/model/address_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AddressController extends GetxController {
  RxList<AddressModel> listAddress = <AddressModel>[].obs;
  late AddressApi addressApi;
  @override
  void onInit() {
    super.onInit();
    addressApi = AddressApi();
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
}
