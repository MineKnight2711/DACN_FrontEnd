import 'dart:convert';

import 'package:fooddelivery_fe/api/base_url.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:fooddelivery_fe/model/transaction_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class TransactionApi {
  final headers = <String, String>{
    'Content-Type': 'application/json',
    'X-Api-Key':
        "\$2a\$10\$CL1Hl1P/RBMh4wR4themGuQRkIuvGgOz/OOYOuXByXJ3fH84XLjFK",
    'X-Client-Id':
        "\$2a\$10\$RFxfUKtO1roIyye0zxfETuRfNmHJiIdX5uSwy9uzcuriFCdnCw93W",
  };
  Future<ResponseBaseModel> performVietQRTransaction(
      TransactionModel transaction) async {
    Logger().i("Log transaction model :${transaction.toVietQRJson()}");
    final response = await http.post(
      Uri.parse(ApiUrl.apiTransactionVietQR),
      headers: headers,
      body: jsonEncode(transaction.toVietQRJson()),
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

  Future<ResponseBaseModel> performCODTransaction(
      TransactionModel newTransaction) async {
    Logger().i("Log transaction model :${newTransaction.toCODJson()}");
    final response = await http.post(
      Uri.parse(ApiUrl.apiTransactionCOD),
      headers: headers,
      body: jsonEncode(newTransaction.toCODJson()),
    );
    Logger().i("Log response :${jsonDecode(utf8.decode(response.bodyBytes))}");
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
        "${ApiUrl.apiTransactionUpdate}?orderId=$orderId&paymentDetailsId=$paymentDetailsId");
    final response = await http.put(
      uri,
      headers: headers,
    );
    Logger().i("Log response :${jsonDecode(utf8.decode(response.bodyBytes))}");

    ResponseBaseModel responseBase = ResponseBaseModel();
    if (response.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'Error';
    return responseBase;
  }

  Future<ResponseBaseModel> cancelTransaction(
      String orderId, int paymentDetailsId) async {
    final Uri uri = Uri.parse(
        "${ApiUrl.apiTransactionCancel}?orderId=$orderId&paymentDetailsId=$paymentDetailsId");
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
