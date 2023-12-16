import 'dart:convert';

import 'package:fooddelivery_fe/api/base_url.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class MapApi {
  final goongApiKey = "1D1TShB6BE7zzAKPIlT7GF61V0wa6KnsO8UAnl1P";

  Future<ResponseBaseModel> getLocationByID(String placeId) async {
    Logger().i("Id dia diem $placeId");
    final Uri uri = Uri.parse(
        "${ApiUrl.apiGoongMapBaseUrl}/Place/Detail?place_id=$placeId&api_key=$goongApiKey");
    final response = await http.get(uri);
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (response.statusCode == 200) {
      Logger()
          .i("Loggg dia diem ${jsonDecode(utf8.decode(response.bodyBytes))}");
      responseBase.data = jsonDecode(utf8.decode(response.bodyBytes));
      responseBase.message = "Success";
      return responseBase;
    }
    responseBase.message = 'Error';
    return responseBase;
  }

  Future<ResponseBaseModel> getLocationByLatitude(
      String lat, String longLat) async {
    final Uri uri = Uri.parse(
        "${ApiUrl.apiGoongMapBaseUrl}/Geocode?latlng=$lat,$longLat&api_key=$goongApiKey");
    final response = await http.get(uri);
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (response.statusCode == 200) {
      responseBase.data = jsonDecode(utf8.decode(response.bodyBytes));
      responseBase.message = "Success";
      return responseBase;
    }
    responseBase.message = 'Error';
    return responseBase;
  }

  Future<ResponseBaseModel> getPredictLocation(String predictString) async {
    final response = await http.get(
      Uri.parse(
          "${ApiUrl.apiGoongMapBaseUrl}/Place/AutoComplete?api_key=$goongApiKey&input=$predictString"),
    );
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (response.statusCode == 200) {
      responseBase.data = jsonDecode(utf8.decode(response.bodyBytes));
      responseBase.message = "Success";
      return responseBase;
    }
    responseBase.message = 'Error';
    return responseBase;
  }
}
