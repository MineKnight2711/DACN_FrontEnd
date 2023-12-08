import 'package:fooddelivery_fe/api/orders/order_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/model/order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  late OrderApi _orderApi;
  late AccountController _accountController;
  RxList<OrderModel> listOrder = <OrderModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    _orderApi = OrderApi();
    _accountController = Get.find<AccountController>();
  }

  Future<void> getAccountOrders() async {
    if (_accountController.accountSession.value != null) {
      final response = await _orderApi.getAccountOrders(
          "${_accountController.accountSession.value?.accountID}");
      if (response.message == "Success") {
        final ordersJson = response.data as List<dynamic>;
        listOrder.value =
            ordersJson.map((order) => OrderModel.fromJson(order)).toList();
      }
    }
  }
}
