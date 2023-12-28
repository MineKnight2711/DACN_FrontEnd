import 'dart:convert';

import 'package:fooddelivery_fe/api/base_url.dart';
import 'package:fooddelivery_fe/model/cart_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:http/http.dart' as http;

class CartApi {
  Future<ResponseBaseModel?> getCartByAccount(String accountId) async {
    final response = await http.get(
      Uri.parse("${ApiUrl.apiCart}/get-by-accountId/$accountId"),
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

  Future<ResponseBaseModel> addToCart(CartModel cartModel) async {
    final response = await http.post(
      Uri.parse(ApiUrl.apiCart),
      body: cartModel.toJson(),
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

  Future<ResponseBaseModel> updateCart(String cartId, int newQuantity) async {
    Uri uri = Uri.parse('${ApiUrl.apiCart}/$cartId?newQuantity=$newQuantity');
    final response = await http.put(uri);
    ResponseBaseModel responseBase = ResponseBaseModel();
    if (response.statusCode == 200) {
      responseBase = ResponseBaseModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)));
      return responseBase;
    }
    responseBase.message = 'Error';
    return responseBase;
  }

  Future<ResponseBaseModel?> deleteItem(String cartItemId) async {
    final response = await http.delete(
      Uri.parse("${ApiUrl.apiCart}/$cartItemId"),
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

  Future<ResponseBaseModel> clearCart(List<String> listCartId) async {
    print(jsonEncode(listCartId));
    final response = await http.delete(
      Uri.parse(ApiUrl.apiClearCart),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(listCartId),
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
