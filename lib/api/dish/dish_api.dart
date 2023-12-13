import 'dart:convert';

import 'package:fooddelivery_fe/api/base_url.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';

import 'package:http/http.dart' as http;

class DishApi {
  Future<ResponseBaseModel?> getAllDish() async {
    final response = await http.get(
      Uri.parse(ApiUrl.apiDish),
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

  Future<ResponseBaseModel> findDishByCategoryID(String categoryId) async {
    final response = await http.get(
      Uri.parse("${ApiUrl.apiGetDishesByCategoryID}/$categoryId"),
    );
    ResponseBaseModel responseBase = ResponseBaseModel();
    print(jsonDecode(utf8.decode(response.bodyBytes)));
    if (response.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'Error';
    return responseBase;
  }
}
