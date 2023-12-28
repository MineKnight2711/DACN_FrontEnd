import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/api/cart_api/cart_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/model/cart_model.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class CartController extends GetxController {
  late CartApi _cartApi;
  late AccountController _accountController;
  RxList<CartModel> listCart = <CartModel>[].obs;
  RxInt selectedQuantity = 1.obs;
  @override
  void onInit() {
    super.onInit();
    _cartApi = CartApi();
    _accountController = Get.find<AccountController>();
    getAccountCart();
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
    total.value = listCart.fold(0.0, (total, item) {
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
    if (listCart.isEmpty) {
      listCartHeight.value = 600.h;
      return listCartHeight;
    }
    listCartHeight.value = ((listCart.length + 1) * (80.h + 20.h)) + 50.h;
    return listCartHeight;
  }

  void updateCart(CartModel cart, int newQuantity) {
    final cartFound =
        listCart.firstWhereOrNull((item) => item.cartID == cart.cartID);

    if (cartFound != null) {
      cartFound.quantity = newQuantity;
      final index = listCart.indexOf(cartFound);
      listCart[index] = cartFound;
      listCart.refresh();
    }
  }

  Future<String> updateCartApi(String cartId, int newQuantity) async {
    final response = await _cartApi.updateCart(cartId, newQuantity);
    return response.message ?? '';
  }

  Future<void> getAccountCart() async {
    _accountController.fetchCurrentUser();
    if (_accountController.accountSession.value != null) {
      ResponseBaseModel? responseBaseModel = await _cartApi.getCartByAccount(
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

  Future<ResponseBaseModel> addToCart(DishModel? dish, int quantity) async {
    _accountController.fetchCurrentUser();

    if (_accountController.accountSession.value != null) {
      CartModel newCartItem = CartModel();
      newCartItem.quantity = quantity;
      newCartItem.dish = dish;
      newCartItem.account = _accountController.accountSession.value;
      final response = await _cartApi.addToCart(newCartItem);

      if (response.message == "Success") {
        getAccountCart();
        calculateTotal();
      }
      return response;
    }
    ResponseBaseModel newResponse = ResponseBaseModel();
    newResponse.message = "Unknown";
    newResponse.data = "Lỗi chưa xác định";
    return newResponse;
  }

  Future<String?> deleteCartItem(CartModel cart) async {
    ResponseBaseModel? responseBaseModel =
        await _cartApi.deleteItem("${cart.cartID}");
    Logger().i("Logger cart : ${responseBaseModel?.data}");
    if (responseBaseModel?.message == "Success") {
      listCart.remove(cart);
      getAccountCart();
      calculateTotal();
      return "Success";
    }
    return responseBaseModel?.message;
  }

  Future<String?> clearCart() async {
    List<String> listCartID = listCart.map((cart) => "${cart.cartID}").toList();
    final responseBaseModel = await _cartApi.clearCart(listCartID);
    if (responseBaseModel.message == "Success") {
      listCart.clear();

      return responseBaseModel.message;
    }
    return responseBaseModel.message;
  }
}
