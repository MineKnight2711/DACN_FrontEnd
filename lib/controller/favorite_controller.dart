import 'package:fooddelivery_fe/api/favorite/favorite_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/dish_controller.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';
import 'package:fooddelivery_fe/model/favorite_model.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  late FavoriteApi _favoriteApi;
  late DishController _dishController;
  late AccountController _accountController;
  RxList<FavoriteModel> listFavorite = <FavoriteModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    _favoriteApi = FavoriteApi();
    _dishController = Get.find<DishController>();
    _accountController = Get.find<AccountController>();
  }

  bool isAccountLogin() {
    if (_accountController.accountSession.value != null) {
      return true;
    }
    return false;
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

  Future<void> getAccountListFavoriteDish() async {
    if (_accountController.accountSession.value != null) {
      final response = await _favoriteApi.getAccountListFavorite(
          "${_accountController.accountSession.value?.accountID}");
      if (response.message == "Success") {
        final favoritesJson = response.data as List<dynamic>;
        listFavorite.value =
            favoritesJson.map((f) => FavoriteModel.fromJson(f)).toList();
      }
    }
  }

  Future<String> addToFavorite(DishModel dish) async {
    if (_accountController.accountSession.value != null) {
      FavoriteModel newFavorite = FavoriteModel();
      newFavorite.account = _accountController.accountSession.value;
      newFavorite.dish = dish;
      final response = await _favoriteApi.addToFavorite(newFavorite);
      await _dishController.getAllDish();
      return response.message ?? "";
    }
    return "NotLogin";
  }

  Future<String> unFavorite(String dishID) async {
    if (_accountController.accountSession.value != null) {
      final response = await _favoriteApi.unFavorite(
          dishID, "${_accountController.accountSession.value?.accountID}");
      await _dishController.getAllDish();
      return response.message ?? "";
    }
    return "Fail";
  }
}
