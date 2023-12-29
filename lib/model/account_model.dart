import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

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
  int? points;
  String? tier;
  int? lifetimePoints;
  AccountModel(
      {this.accountID,
      this.password,
      this.fullName,
      this.email,
      this.birthday,
      this.gender,
      this.imageUrl,
      this.phoneNumber,
      this.role,
      this.points,
      this.lifetimePoints,
      this.tier});
  factory AccountModel.fromJson(Map<String, dynamic> json) {
    String? birthdayString = json['birthday'] as String?;
    return AccountModel(
      accountID: json['accountID'],
      fullName: json['fullName'],
      birthday: (birthdayString != "" && birthdayString != null)
          ? DateFormat('yyyy-MM-dd').parse(birthdayString)
          : DateTime.now(),
      email: json['email'],
      gender: json['gender'] as String?,
      imageUrl: json['imageUrl'],
      phoneNumber: json['phoneNumber'] as String?,
      points: json['points'] as int?,
      lifetimePoints: json['lifetimePoints'] as int?,
      tier: json['tier'] as String?,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountID': accountID,
      'fullName': fullName,
      'birthday': birthday != null
          ? DateFormat("yyyy-MM-dd").format(birthday!)
          : DateTime.now(),
      'email': email,
      'gender': gender,
      'imageUrl': imageUrl ?? "",
      'phoneNumber': phoneNumber,
      'points': points ?? 0,
      'lifetimePoints': lifetimePoints ?? 0,
      'tier': tier ?? ''
    };
  }

  Map<String, dynamic> newAccountToJson() {
    return {
      'accountID': accountID,
      'fullName': fullName,
      'birthday': birthday != null
          ? DateFormat("yyyy-MM-dd").format(birthday!)
          : DateTime.now(),
      'email': email,
      'gender': gender,
      'imageUrl': imageUrl ?? "",
      'phoneNumber': phoneNumber,
    };
  }

  Map<String, dynamic> updateToJson() {
    return {
      'accountID': accountID,
      'fullName': fullName,
      'birthday': birthday != null
          ? DateFormat("yyyy-MM-dd").format(birthday!)
          : DateTime.now(),
      'phoneNumber': phoneNumber,
    };
  }

  Map<String, dynamic> googleRegisterToJson() {
    return {
      'fullName': fullName,
      'email': email,
      'birthday': DateFormat("yyyy-MM-dd").format(DateTime.now()),
      'imageUrl': imageUrl,
    };
  }
}
