import 'package:fooddelivery_fe/api/favorite/favorite_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';
import 'package:fooddelivery_fe/model/favorite_model.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  late FavoriteApi _favoriteApi;
  late AccountController _accountController;
  @override
  void onInit() {
    super.onInit();
    _favoriteApi = FavoriteApi();
    _accountController = Get.find<AccountController>();
  }

  Future<FavoriteModel?> getAccountFavoriteDish(String dishID) async {
    if (_accountController.accountSession.value != null) {
      final response = await _favoriteApi.getAccountFavoriteDish(
          dishID, "${_accountController.accountSession.value?.accountID}");
      if (response.message == "Success") {
        return FavoriteModel.fromJson(response.data);
      }
      return null;
    }
    return null;
  }

  Future<String> addToFavorite(DishModel dish) async {
    if (_accountController.accountSession.value != null) {
      FavoriteModel newFavorite = FavoriteModel();
      newFavorite.account = _accountController.accountSession.value;
      newFavorite.dish = dish;
      final response = await _favoriteApi.addToFavorite(newFavorite);
      return response.message ?? "";
    }
    return "Fail";
  }

  Future<String> unFavorite(String dishID) async {
    if (_accountController.accountSession.value != null) {
      final response = await _favoriteApi.unFavorite(
          dishID, "${_accountController.accountSession.value?.accountID}");
      return response.message ?? "";
    }
    return "Fail";
  }
}
