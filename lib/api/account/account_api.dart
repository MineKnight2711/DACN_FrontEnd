import 'dart:convert';

import 'package:fooddelivery_fe/api/base_url.dart';
import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:http/http.dart' as http;

class AccountApi {
  Future<ResponseBaseModel?> register(AccountModel account) async {
    final response = await http.post(
      Uri.parse(ApiUrl.apiCreateAccount),
      body: account.toJson(),
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

  Future<ResponseBaseModel?> login(String email, String password) async {
    final response = await http.get(
      Uri.parse("${ApiUrl.apiLogin}/$email?password=$password"),
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
