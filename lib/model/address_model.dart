import 'package:fooddelivery_fe/model/account_model.dart';

class AddressModel {
  String addressID;
  String ward;
  String district;
  String province;
  String details;
  String addressName;
  String receiverName;
  String receiverPhone;
  bool defaultAddress;
  AccountModel account;
  AddressModel({
    required this.addressID,
    required this.ward,
    required this.district,
    required this.province,
    required this.details,
    required this.addressName,
    required this.receiverName,
    required this.receiverPhone,
    required this.defaultAddress,
    required this.account,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
        addressID: json['addressID'],
        ward: json['ward'],
        district: json['district'],
        province: json['province'],
        details: json['details'],
        addressName: json['addressName'],
        receiverName: json['receiverName'],
        receiverPhone: json['receiverPhone'],
        defaultAddress: json['defaultAddress'],
        account: AccountModel.fromJson(json['account']));
  }

  Map<String, dynamic> toJson() {
    return {
      'ward': ward,
      'district': district,
      'province': province,
      'details': details,
      'addressName': addressName,
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'defaultAddress': defaultAddress,
    };
  }
}
