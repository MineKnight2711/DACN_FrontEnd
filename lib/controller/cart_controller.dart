import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  RxDouble caculateItemTotal(CartModel item) {
    RxDouble itemTotal = 0.0.obs;
    if (item.dish != null && item.quantity != null) {
      double dishPrice = item.dish?.price ?? 0.0;
      int quantity = item.quantity ?? 0;

      itemTotal.value = dishPrice * quantity;
    }

    return itemTotal;
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

  RxDouble calculateListCartHeight() {
    RxDouble listCartHeight = 0.0.obs;

    listCartHeight.value = ((listCart.value.length + 1) * (80.h + 20.h)) + 50.h;
    return listCartHeight;
  }

  void updateCart(CartModel cart, int newQuantity) {
    final cartFound =
        listCart.value.firstWhereOrNull((item) => item.cartID == cart.cartID);

    if (cartFound != null) {
      cartFound.quantity = newQuantity;
      final index = listCart.value.indexOf(cartFound);
      listCart.value[index] = cartFound;
      listCart.refresh();
    }
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
        calculateTotal();
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

  Future<String?> deleteCartItem(CartModel cart) async {
    ResponseBaseModel? responseBaseModel =
        await cartApi.deleteItem("${cart.cartID}");
    Logger().i("Logger cart : ${responseBaseModel?.data}");
    if (responseBaseModel?.message == "Success") {
      listCart.value.remove(cart);
      getAccountCart();
      calculateTotal();
      return "Success";
    }
    return responseBaseModel?.message;
  }
}
