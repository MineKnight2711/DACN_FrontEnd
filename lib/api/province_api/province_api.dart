import 'dart:convert';

import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:http/http.dart' as http;

class ProvinceApi {
  Future<ResponseBaseModel> apiSearchProvince(String province) async {
    String url = 'https://provinces.open-api.vn/api/p/search/?q=$province';
    final response = await http.get(Uri.parse(url));
    ResponseBaseModel responseModel = ResponseBaseModel();
    if (response.statusCode == 200) {
      final listProvinceJson =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      responseModel.message = "Success";
      responseModel.data = listProvinceJson;
      return responseModel;
    }
    responseModel.message = "Fail";
    return responseModel;
  }

  Future<ResponseBaseModel> apiSearchDistrict(String district) async {
    String url = 'https://provinces.open-api.vn/api/d/search/?q=$district';
    final response = await http.get(Uri.parse(url));
    ResponseBaseModel responseModel = ResponseBaseModel();
    if (response.statusCode == 200) {
      final listProvinceJson =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      responseModel.message = "Success";
      responseModel.data = listProvinceJson;
      return responseModel;
    }
    responseModel.message = "Fail";
    return responseModel;
  }

  Future<ResponseBaseModel> apiSearchWard(String ward) async {
    String url = 'https://provinces.open-api.vn/api/w/search/?q=$ward';
    final response = await http.get(Uri.parse(url));
    ResponseBaseModel responseModel = ResponseBaseModel();
    if (response.statusCode == 200) {
      final listProvinceJson =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      responseModel.message = "Success";
      responseModel.data = listProvinceJson;
      return responseModel;
    }
    responseModel.message = "Fail";
    return responseModel;
  }

  Future<ResponseBaseModel> getAllProvine() async {
    String url = 'https://provinces.open-api.vn/api/p/';
    final response = await http.get(Uri.parse(url));
    ResponseBaseModel responseModel = ResponseBaseModel();
    if (response.statusCode == 200) {
      final listProvinceJson =
          jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
      responseModel.message = "Success";
      responseModel.data = listProvinceJson;
      return responseModel;
    }
    responseModel.message = "Fail";
    return responseModel;
  }

  Future<ResponseBaseModel> getProvince(int provinceCode) async {
    String url = 'https://provinces.open-api.vn/api/p/$provinceCode?depth=2';
    final response = await http.get(Uri.parse(url));
    ResponseBaseModel responseModel = ResponseBaseModel();
    if (response.statusCode == 200) {
      final provinceJson = jsonDecode(utf8.decode(response.bodyBytes));
      responseModel.message = "Success";
      responseModel.data = provinceJson;
      return responseModel;
    }
    responseModel.message = "Faill";
    return responseModel;
  }

  Future<ResponseBaseModel> getDistrict(int provindeCode) async {
    String url = "https://provinces.open-api.vn/api/d/$provindeCode?depth=2";
    final response = await http.get(Uri.parse(url));
    ResponseBaseModel responseModel = ResponseBaseModel();
    if (response.statusCode == 200) {
      final districtJson = jsonDecode(utf8.decode(response.bodyBytes));
      responseModel.message = "Success";
      responseModel.data = districtJson;
      return responseModel;
    }
    responseModel.message = "Faill";
    return responseModel;
  }

  // Future<ResponseBaseModel> getWard(String ward, int districtCode) async {
  //   String url =
  //       'https://provinces.open-api.vn/api/w/search/?q=$ward&d=$districtCode';
  //   final response = await http.get(Uri.parse(url));
  //   ResponseBaseModel responseModel = ResponseBaseModel();
  //   if (response.statusCode == 200) {
  //     final listWardJson =
  //         jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>;
  //     listWard.value = listWardJson
  //         .map(
  //           (wardMap) => Ward.fromJson(wardMap),
  //         )
  //         .toList();
  //   }
  //   responseModel.message = "Faill";
  //   return responseModel;
  // }
}
