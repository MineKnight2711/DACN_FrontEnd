import 'dart:convert';

import 'package:intl/intl.dart';

import '../model/category_model.dart';

class DataConvert {
  List<CategoryModel> parseCategoryList(dynamic responseBody) {
    final List<dynamic> categoryList = responseBody['data'];
    return categoryList.map((json) => CategoryModel.fromJson(json)).toList();
  }

  List<String> encodeListImages(String imagesList) {
    List<String> result = [];
    String encode = jsonEncode(imagesList);
    String str = encode
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll('"', '')
        .replaceAll('\\', '')
        .replaceAll('altu003dmedia', 'alt=media');

    result = str.split(',');
    return result;
  }

  String simplifyAddress(String address) {
    String result = address.replaceAll("-", "\n");
    return result;
  }

  String simplifyAddress2(String address) {
    String result = address.replaceAll("-", ", ");
    return result;
  }

  List<String> splitAddress(String address) {
    List<String> addressParts = address.split('-');
    return addressParts;
  }

  String formatCurrency(double value) {
    final currentcy = NumberFormat('#,##0', 'ID');
    String result =
        "${currentcy.format(double.parse(value.toStringAsFixed(0)))} đ";
    return result;
  }

  String formattedOrderDate(DateTime orderDate) {
    String amPm = orderDate.hour < 12 ? "AM" : "PM  ";
    // int hour =
    //     orderDate.hour < 12 ? orderDate.hour : orderDate.hour - 12;
    return DateFormat("dd/MM/yyyy 'lúc' h:mm '$amPm' ", 'vi_VN')
        .format(orderDate);
  }
}
