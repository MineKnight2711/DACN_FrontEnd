import 'dart:convert';

import 'package:fooddelivery_fe/api/base_url.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:http/http.dart' as http;

class MapApi {
  Future<ResponseBaseModel?> getLocation(String predictString) async {
    if (predictString.isEmpty) return null;
    final response = await http.get(
      Uri.parse("${ApiUrl.apiMapListLocation}?address=$predictString"),
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

  Future<ResponseBaseModel?> getPredictLocation(String predictString) async {
    if (predictString.isEmpty) return null;
    final response = await http.get(
      Uri.parse("${ApiUrl.apiMapPredictLocation}?address=$predictString"),
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
