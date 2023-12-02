import 'package:fooddelivery_fe/model/account_model.dart';

class AddressModel {
  String? addressID;
  String? ward;
  String? district;
  String? province;
  String? details;
  String? addressName;
  String? receiverName;
  String? receiverPhone;
  bool? defaultAddress;
  AccountModel? account;
  AddressModel({
    this.addressID,
    this.ward,
    this.district,
    this.province,
    this.details,
    this.addressName,
    this.receiverName,
    this.receiverPhone,
    this.defaultAddress,
    this.account,
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
      'defaultAddress': defaultAddress.toString(),
    };
  }
}
