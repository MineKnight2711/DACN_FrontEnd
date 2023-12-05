import 'dart:convert';

import 'package:fooddelivery_fe/api/base_url.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:fooddelivery_fe/model/transaction_model.dart';
import 'package:http/http.dart' as http;

class TransactionApi {
  Future<ResponseBaseModel> addToFavorite(TransactionModel transaction) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'X-Client-Id': "Test",
      'X-Api-Key': "Test",
    };
    final response = await http.post(
      Uri.parse(ApiUrl.apiFavorite),
      headers: headers,
      body: transaction.toJson(),
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
