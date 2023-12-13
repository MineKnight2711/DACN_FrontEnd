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

  String formattedNormalDate(DateTime? orderDate) {
    if (orderDate != null) {
      return DateFormat("dd/MM/yyyy", 'vi_VN').format(orderDate);
    }
    return "Undefined";
  }

  String formattedOrderDate(DateTime? orderDate) {
    if (orderDate != null) {
      String amPm = orderDate.hour < 12 ? "AM" : "PM  ";
      return DateFormat("dd/MM/yyyy 'lúc' h:mm '$amPm' ", 'vi_VN')
          .format(orderDate);
    }
    return "Undefined";
  }

  String removeDiacritics(String text) {
    //Chuyển hoá chuỗi có dấu thành không dấu để hỗ trợ tìm kiếm sử dụng regex
    return text.replaceAllMapped(
        RegExp(
            r'[àáảãạăắằẳẵặâấầẩẫậèéẻẽẹêếềểễệìíỉĩịòóỏõọôốồổỗộơớờởỡợùúủũụưứừửữựỳỵỷỹđ]'),
        (match) => _diacriticToPlain[match.group(0)] ?? '');
  }

  //Bảng chuyển đổi
  final _diacriticToPlain = {
    'à': 'a',
    'á': 'a',
    'ả': 'a',
    'ã': 'a',
    'ạ': 'a',
    'ă': 'a',
    'ắ': 'a',
    'ằ': 'a',
    'ẳ': 'a',
    'ẵ': 'a',
    'ặ': 'a',
    'â': 'a',
    'ấ': 'a',
    'ầ': 'a',
    'ẩ': 'a',
    'ẫ': 'a',
    'ậ': 'a',
    'è': 'e',
    'é': 'e',
    'ẻ': 'e',
    'ẽ': 'e',
    'ẹ': 'e',
    'ê': 'e',
    'ế': 'e',
    'ề': 'e',
    'ể': 'e',
    'ễ': 'e',
    'ệ': 'e',
    'ì': 'i',
    'í': 'i',
    'ỉ': 'i',
    'ĩ': 'i',
    'ị': 'i',
    'ò': 'o',
    'ó': 'o',
    'ỏ': 'o',
    'õ': 'o',
    'ọ': 'o',
    'ô': 'o',
    'ố': 'o',
    'ồ': 'o',
    'ổ': 'o',
    'ỗ': 'o',
    'ộ': 'o',
    'ơ': 'o',
    'ớ': 'o',
    'ờ': 'o',
    'ở': 'o',
    'ỡ': 'o',
    'ợ': 'o',
    'ù': 'u',
    'ú': 'u',
    'ủ': 'u',
    'ũ': 'u',
    'ụ': 'u',
    'ư': 'u',
    'ứ': 'u',
    'ừ': 'u',
    'ử': 'u',
    'ữ': 'u',
    'ự': 'u',
    'ỳ': 'y',
    'ỵ': 'y',
    'ỷ': 'y',
    'ỹ': 'y',
    'đ': 'd'
  };
}
