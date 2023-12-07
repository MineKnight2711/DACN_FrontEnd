import 'dart:convert';

import 'package:fooddelivery_fe/api/base_url.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:fooddelivery_fe/model/transaction_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class TransactionApi {
  final headers = <String, String>{
    'Content-Type': 'application/json',
    'X-Client-Id': "Test",
    'X-Api-Key': "Test",
  };
  Future<ResponseBaseModel> performTransaction(
      TransactionModel transaction) async {
    Logger().i("Log transaction model :${transaction.toJson()}");
    final response = await http.post(
      Uri.parse(ApiUrl.apiTransaction),
      headers: headers,
      body: jsonEncode(transaction.toJson()),
    );
    // Logger().i("Log transaction model :${transaction.toJson()}");
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (response.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'Error';
    return responseBase;
  }

  Future<ResponseBaseModel> updateTransaction(
      String orderId, int paymentDetailsId) async {
    final Uri uri = Uri.parse(
        "${ApiUrl.apiTransaction}?orderId=$orderId&paymentDetailsId=$paymentDetailsId");
    final response = await http.put(
      uri,
      headers: headers,
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
