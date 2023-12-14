import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/api/orders/order_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/model/order_model.dart';
import 'package:fooddelivery_fe/model/review_order_dto.dart';
import 'package:get/get.dart';

class RatingOrderController extends GetxController {
  late OrderApi _orderApi;
  late AccountController _accountController;
  RxList<OrderDetailsDTO> listCompleteOrder = <OrderDetailsDTO>[].obs;
  RxList<OrderDetailsDTO> listRatedOrder = <OrderDetailsDTO>[].obs;
  TextEditingController feedBackController = TextEditingController();
  RxDouble score = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _orderApi = OrderApi();
    _accountController = Get.find<AccountController>();
  }

  @override
  void refresh() {
    super.refresh();
    score.value = 0.0;
    scoreChangingResult(score.value);
    feedBackController.clear();
    getAllCompleteOrder();
  }

  void scoreChanging(double updateScore) {
    score.value = updateScore;
    print(score.value);
    scoreChangingResult(score.value);
  }

  // void getOrderByStatus(String status) {
  //   switch (status) {
  //     case "Đã hoàn tất":
  //       listCompleteOrder.value = listOrder
  //           .where(
  //               (orderDetails) => orderDetails.order?.status == "Đã hoàn tất")
  //           .toList();
  //       break;
  //     case "Đã đánh giá":
  //       listRatedOrder.value = listOrder
  //           .where(
  //               (orderDetails) => orderDetails.order?.status == "Đã đánh giá")
  //           .toList();
  //       break;

  //     default:
  //   }
  // }

  RxString scoreChangingResult(double updatedScore) {
    RxString result = "".obs;
    if (updatedScore >= 1 && updatedScore < 2) {
      result.value =
          "Xin lỗi về trải nghiệm không tốt của bạn\nHãy cho chúng tôi biết nên cải thiện điều gì ở phần phản hồi😭";
    } else if (updatedScore >= 2 && updatedScore < 3) {
      result.value =
          'Bạn có điều chưa hài lòng ở chúng tôi?\nXin hãy phản hồi bên dưới😓';
    } else if (updatedScore >= 3 && updatedScore < 4) {
      result.value =
          'Cám ơn phản hồi của bạn , hãy cho chúng tôi biết thêm điều gì khiến bạn chưa hài lòng về đơn hàng bên dưới nhé😄';
    } else if (updatedScore >= 4 && updatedScore < 5) {
      result.value =
          'Chúng tôi rất vui vì trải nghiệm của bạn là rất tốt\nHãy cho chúng tôi biết ý kiến đóng góp của bạn \nĐể chúng tôi có thể hoàn thiện hơn nữa nhé😍😍';
    } else if (updatedScore == 5) {
      result.value =
          'Fanstatic!, Wonderful!, Significant!\nMagnificent!, Out standing!, World Class!😎😎😎';
    } else {
      result.value = "";
    }
    return result;
  }

  Future<void> getAllCompleteOrder() async {
    if (_accountController.accountSession.value != null) {
      final response = await _orderApi.getAccountOrdersByStatus(
          "${_accountController.accountSession.value?.accountID}",
          "Đã thanh toán");
      if (response.message == "Success") {
        final orderDetailsJson = response.data as List<dynamic>;

        listCompleteOrder.value = orderDetailsJson
            .map((orderDetails) => OrderDetailsDTO.fromJson(orderDetails))
            .toList();
      }
    }
  }

  Future<void> getAllRatedOrder() async {
    if (_accountController.accountSession.value != null) {
      final response = await _orderApi.getAccountOrdersByStatus(
          "${_accountController.accountSession.value?.accountID}",
          "Đã đánh giá");
      if (response.message == "Success") {
        final orderDetailsJson = response.data as List<dynamic>;

        listRatedOrder.value = orderDetailsJson
            .map((orderDetails) => OrderDetailsDTO.fromJson(orderDetails))
            .toList();
      }
    }
  }

  Future<String> rateOrder(String orderId) async {
    ReviewOrderDTO dto = ReviewOrderDTO(
      orderId: orderId,
      score: score.value,
      feedback: feedBackController.text,
    );
    final response = await _orderApi.rateOrder(dto);
    return response.message ?? '';
  }
}
