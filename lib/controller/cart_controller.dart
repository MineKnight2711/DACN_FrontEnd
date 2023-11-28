import 'package:fooddelivery_fe/api/cart_api/cart_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/model/cart_model.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CartController extends GetxController {
  late CartApi cartApi;
  late AccountController _accountController;
  Rx<List<CartModel>> listCart = Rx<List<CartModel>>([]);

  @override
  void onInit() {
    super.onInit();
    cartApi = CartApi();
    _accountController = Get.find<AccountController>();
  }

  RxDouble calculateTotal() {
    RxDouble total = 0.0.obs;
    total.value = listCart.value.fold(0.0, (total, item) {
      if (item.quantity != null && item.dish?.price != null) {
        double itemTotal = item.quantity! * item.dish!.price;

        return total + itemTotal;
      }

      return total;
    });
    return total;
  }

  Future<void> getAccountCart() async {
    _accountController.fetchCurrentUser();
    if (_accountController.accountSession.value != null) {
      ResponseBaseModel? responseBaseModel = await cartApi.getCartByAccount(
          "${_accountController.accountSession.value?.accountID}");
      if (responseBaseModel?.message == "Success") {
        final categoryReceived = responseBaseModel?.data as List<dynamic>;
        List<CartModel> categoriesList = categoryReceived
            .map(
              (categoryMap) => CartModel.fromJson(categoryMap),
            )
            .toList();
        listCart.value = categoriesList;
      }
    }
  }

  Future<String?> addToCart(DishModel dish, int quantity) async {
    _accountController.fetchCurrentUser();
    if (_accountController.accountSession.value != null) {
      CartModel newCartItem = CartModel();
      newCartItem.quantity = quantity;
      newCartItem.dish = dish;
      newCartItem.account = _accountController.accountSession.value;
      ResponseBaseModel? responseBaseModel =
          await cartApi.addToCart(newCartItem);
      Logger().i("Logger cart : ${responseBaseModel?.data}");
      if (responseBaseModel?.message == "Success") {
        calculateTotal();
        return "Success";
      }
      return responseBaseModel?.message;
    }
    return "NoAccount";
  }

  Future<String?> deleteCartItem(String cartItemId) async {
    ResponseBaseModel? responseBaseModel = await cartApi.deleteItem(cartItemId);
    Logger().i("Logger cart : ${responseBaseModel?.data}");
    if (responseBaseModel?.message == "Success") {
      calculateTotal();
      return "Success";
    }
    return responseBaseModel?.message;
  }
}
