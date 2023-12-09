import 'package:fooddelivery_fe/api/orders/order_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/model/order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  late OrderApi _orderApi;
  late AccountController _accountController;
  RxList<OrderDetailsDTO> listOrder = <OrderDetailsDTO>[].obs;
  RxList<OrderDetailsDTO> listOnWaitOrder = <OrderDetailsDTO>[].obs;
  RxList<OrderDetailsDTO> listCompleteOrder = <OrderDetailsDTO>[].obs;
  RxList<OrderDetailsDTO> listOnDeliverOrder = <OrderDetailsDTO>[].obs;
  RxList<OrderDetailsDTO> listCancelOrder = <OrderDetailsDTO>[].obs;
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
        final orderDetailsJson = response.data as List<dynamic>;
        listOrder.value = orderDetailsJson
            .map((orderDetails) => OrderDetailsDTO.fromJson(orderDetails))
            .toList();
        listOnWaitOrder.value = listOrder
            .where((orderDetails) =>
                orderDetails.order?.status == "Chờ thanh toán")
            .toList();
      }
    }
  }

  void getOrderByStatus(String status) {
    switch (status) {
      case "Chờ thanh toán":
        listOnWaitOrder.value = listOrder
            .where((orderDetails) =>
                orderDetails.order?.status == "Chờ thanh toán")
            .toList();
        break;
      case "Đang thực hiện":
        listOnDeliverOrder.value = listOrder
            .where((orderDetails) =>
                orderDetails.order?.status == "Đang thực hiện")
            .toList();
        break;
      case "Đã hoàn tất":
        listCompleteOrder.value = listOrder
            .where(
                (orderDetails) => orderDetails.order?.status == "Đã hoàn tất")
            .toList();
        break;
      case "Đã huỷ":
        listCancelOrder.value = listOrder
            .where((orderDetails) => orderDetails.order?.status == "Đã huỷ")
            .toList();
        break;
      default:
    }
  }
}
