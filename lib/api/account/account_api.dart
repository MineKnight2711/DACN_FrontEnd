import 'dart:convert';
import 'dart:io';

import 'package:fooddelivery_fe/api/base_url.dart';
import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AccountApi {
  Future<ResponseBaseModel?> registerGoogle(AccountModel account) async {
    final response = await http.post(
      Uri.parse(ApiUrl.apiCreateAccount),
      body: account.googleRegisterToJson(),
    );
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (response.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'ConnectError';
    return responseBase;
  }

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
    responseBase.message = 'ConnectError';
    return responseBase;
  }

  Future<ResponseBaseModel?> login(String email) async {
    final response = await http.get(
      Uri.parse("${ApiUrl.apiLoginWithEmail}/$email"),
    );
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (response.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'ConnectError';
    return responseBase;
  }

  Future<ResponseBaseModel> changeImage(
      String accountId, File imageFile) async {
    ResponseBaseModel responseBase = ResponseBaseModel();
    final url = Uri.parse('${ApiUrl.apiChangeImage}/$accountId');

    final request = http.MultipartRequest('PUT', url);
    MultipartFile pic =
        await http.MultipartFile.fromPath("image", imageFile.path);
    request.files.add(pic);
    final response = await request.send();
    if (response.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(await response.stream.bytesToString()));
      return responseBase;
    } else {
      responseBase.message = 'ConnectError';
      return responseBase;
    }
  }

  Future<ResponseBaseModel> updateAccount(AccountModel account) async {
    final response = await http.put(
      Uri.parse(ApiUrl.apiUpdateAccount),
      body: account.updateToJson(),
    );
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (response.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'ConnectError';
    return responseBase;
  }
}
