import 'dart:convert';
import 'package:fooddelivery_fe/model/address_model.dart';
import 'package:http/http.dart' as http;
import 'package:fooddelivery_fe/api/base_url.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';

class AddressApi {
  Future<ResponseBaseModel> getListAddressByAccountId(String accountId) async {
    final response = await http.get(
      Uri.parse("${ApiUrl.apiAddress}/$accountId"),
    );
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (response.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'Error';
    return responseBase;
  }

  Future<ResponseBaseModel> saveAddress(
      String accountId, AddressModel address) async {
    final response = await http.post(
        Uri.parse("${ApiUrl.apiAddress}/$accountId"),
        body: address.toJson());

    ResponseBaseModel responseBase = ResponseBaseModel();
    if (response.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'Error';
    return responseBase;
  }

  Future<ResponseBaseModel> deleteAddress(accountId) async {
    final response = await http.delete(
      Uri.parse("${ApiUrl.apiAddress}/$accountId"),
    );
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (response.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'Error';
    return responseBase;
  }
}
