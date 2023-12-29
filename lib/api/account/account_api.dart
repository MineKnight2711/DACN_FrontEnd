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

  Future<ResponseBaseModel> createAccount(AccountModel account) async {
    print(account.newAccountToJson());
    final response = await http.post(
      Uri.parse(ApiUrl.apiCreateAccount),
      body: account.newAccountToJson(),
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
      Uri.parse("${ApiUrl.apiGetAccountWithEmail}/$email"),
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

  Future<ResponseBaseModel> register(String email, String password) async {
    Map<String, String> requestBody = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(ApiUrl.apiSignUpWithFireBase),
      body: requestBody,
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

  Future<ResponseBaseModel> signIn(String email, String password) async {
    Map<String, String> requestBody = {
      'email': email,
      'password': password,
    };
    final signInResponse = await http
        .post(Uri.parse(ApiUrl.apiSignInWithFireBase), body: requestBody);
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (signInResponse.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(signInResponse.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'ConnectError';
    return responseBase;
  }

  Future<ResponseBaseModel> verifiedEmail(String email, String idToken) async {
    final verifiedResponse = await http.post(
      Uri.parse("${ApiUrl.apiVerifiedEmail}?email=$email&idToken=$idToken"),
    );
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (verifiedResponse.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(verifiedResponse.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'ConnectError';
    return responseBase;
  }

  Future<ResponseBaseModel> signout(String userId) async {
    final signOutResponse = await http.post(
      Uri.parse("${ApiUrl.apiSignOut}/$userId"),
    );
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (signOutResponse.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(signOutResponse.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'ConnectError';
    return responseBase;
  }

  Future<ResponseBaseModel> changeEmail(
      String accountId, String email, String newEmail) async {
    final verifiedResponse = await http.put(
      Uri.parse(
          "${ApiUrl.apiChangeEmail}/$accountId?email=$email&newEmail=$newEmail"),
    );
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (verifiedResponse.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(verifiedResponse.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'ConnectError';
    return responseBase;
  }

  Future<ResponseBaseModel> changePassword(String email, String newPass) async {
    final verifiedResponse = await http.put(
      Uri.parse("${ApiUrl.apiChangePassword}/$email?newPassword=$newPass"),
    );
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (verifiedResponse.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(verifiedResponse.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'ConnectError';
    return responseBase;
  }
}
