import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fooddelivery_fe/api/base_url.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';

class AccountVoucherApi {
  Future<ResponseBaseModel> saveVoucherToAccount(
      String accountId, String voucherId) async {
    final accountVoucher = <String, String>{
      "accountId": accountId,
      "voucherId": voucherId,
    };
    final verifiedResponse = await http.post(
      Uri.parse(ApiUrl.apiAccountVoucher),
      body: accountVoucher,
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
