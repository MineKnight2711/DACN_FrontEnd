import 'dart:convert';

import 'package:fooddelivery_fe/api/base_url.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:http/http.dart' as http;

class PaymentApi {
  Future<ResponseBaseModel> getAllPayMent() async {
    final response = await http.get(
      Uri.parse(ApiUrl.apiPayment),
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
