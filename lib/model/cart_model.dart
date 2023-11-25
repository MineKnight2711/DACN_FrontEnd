import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';

class CartModel {
  String? cartID;
  DishModel? dish;
  AccountModel? account;
  int? quantity;
  double? total;

  CartModel({this.cartID, this.dish, this.account, this.quantity, this.total});
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      cartID: json['cartID'] as String,
      dish: DishModel.fromJson(json['dish']),
      account: AccountModel.fromJson(json['account']),
      quantity: json['quantity'] as int,
      total: json['total'] as double,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity.toString(),
      'accountID': account?.accountID,
      'dishID': dish?.dishID,
    };
  }
}
