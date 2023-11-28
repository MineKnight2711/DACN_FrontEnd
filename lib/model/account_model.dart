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
  String? role;

  AccountModel(
      {this.accountID,
      this.password,
      this.fullName,
      this.email,
      this.birthday,
      this.gender,
      this.imageUrl,
      this.phoneNumber,
      this.role});
  factory AccountModel.fromJson(Map<String, dynamic> json) {
    String? birthdayString = json['birthday'] as String?;
    return AccountModel(
      accountID: json['accountID'],
      fullName: json['fullName'],
      birthday: (birthdayString != "" && birthdayString != null)
          ? DateFormat('yyyy-MM-dd').parse(birthdayString)
          : null,
      email: json['email'],
      gender: json['gender'] as String?,
      imageUrl: json['imageUrl'],
      phoneNumber: json['phoneNumber'] as String?,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountID': accountID,
      'fullName': fullName,
      'birthday':
          birthday != null ? DateFormat("yyyy-MM-dd").format(birthday!) : '',
      'email': email,
      'gender': gender,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
    };
  }

  Map<String, dynamic> googleRegisterToJson() {
    return {
      'fullName': fullName,
      'email': email,
      'imageUrl': imageUrl,
    };
  }
}
