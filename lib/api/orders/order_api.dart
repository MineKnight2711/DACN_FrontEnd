import 'dart:convert';

import 'package:fooddelivery_fe/api/base_url.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:fooddelivery_fe/model/review_order_dto.dart';
import 'package:http/http.dart' as http;

class OrderApi {
  Future<ResponseBaseModel> getAccountOrders(String accountId) async {
    final response = await http.get(
      Uri.parse("${ApiUrl.apiOrder}/$accountId"),
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

  Future<ResponseBaseModel> getAccountOrdersByStatus(
      String accountId, String orderStatus) async {
    final response = await http.get(
      Uri.parse(
          "${ApiUrl.apiOrderByStatus}/$accountId?orderState=$orderStatus"),
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

  Future<ResponseBaseModel> rateOrder(ReviewOrderDTO dto) async {
    final response = await http.put(
      Uri.parse(ApiUrl.apiRateOrder),
      body: dto.toJson(),
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
