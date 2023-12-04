import 'dart:convert';

import 'package:fooddelivery_fe/api/base_url.dart';
import 'package:fooddelivery_fe/model/favorite_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:http/http.dart' as http;

class FavoriteApi {
  Future<ResponseBaseModel> getAccountFavoriteDish(
      String dishId, String accountId) async {
    final Uri uri =
        Uri.parse('${ApiUrl.apiFavorite}?dishID=$dishId&accountID=$accountId');
    final response = await http.get(
      uri,
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

  Future<ResponseBaseModel> addToFavorite(FavoriteModel favorite) async {
    final response = await http.post(
      Uri.parse(ApiUrl.apiFavorite),
      body: favorite.toJson(),
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

  Future<ResponseBaseModel> unFavorite(String dishId, String accountId) async {
    final Uri uri =
        Uri.parse('${ApiUrl.apiFavorite}?dishID=$dishId&accountID=$accountId');
    final response = await http.delete(
      uri,
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
