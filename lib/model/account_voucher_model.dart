import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/model/voucher_model.dart';

class AccountVoucherModel {
  AccountModel account;
  VoucherModel voucher;

  AccountVoucherModel({required this.account, required this.voucher});

  factory AccountVoucherModel.fromJson(Map<String, dynamic> json) {
    return AccountVoucherModel(
      account: AccountModel.fromJson(json['account']),
      voucher: VoucherModel.fromJson(json['voucher']),
    );
  }
}
