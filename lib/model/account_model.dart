import 'package:intl/intl.dart';

class AccountModel {
  String? accountID;
  String? password;
  String? fullName;
  String? email;
  DateTime? birthday;
  String? gender;
  String? imageUrl;
  String? phoneNumber;

  AccountModel({
    this.accountID,
    this.password,
    this.fullName,
    this.email,
    this.birthday,
    this.gender,
    this.imageUrl,
    this.phoneNumber,
  });
  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      accountID: json['accountID'],
      fullName: json['fullName'],

      birthday: DateFormat('yyyy-MM-dd').parse(json['birthday']),
      // isFingerPrintAuthentication: json["isFingerPrintAuthentication"],
      email: json['email'],
      gender: json['gender'],
      imageUrl: json['imageUrl'],
      phoneNumber: json['phoneNumber'],
    );
  }

  // Convert the User object to a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'accountID': accountID,
      'fullName': fullName,
      'password': password,
      'birthday':
          birthday != null ? DateFormat("yyyy-MM-dd").format(birthday!) : '',
      // 'isFingerPrintAuthentication': isFingerPrintAuthentication.toString(),
      'email': email,
      'gender': gender,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
    };
  }
}