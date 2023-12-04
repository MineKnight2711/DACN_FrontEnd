import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';

class FavoriteModel {
  String? favoriteID;
  AccountModel? account;
  DishModel? dish;

  FavoriteModel({
    this.favoriteID,
    this.account,
    this.dish,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      favoriteID: json['favoriteID'],
      account: AccountModel.fromJson(json['account']),
      dish: DishModel.fromJson(json['dish']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountID': account?.accountID,
      'dishID': dish?.dishID,
    };
  }
}
