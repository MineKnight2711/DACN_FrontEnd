import 'package:fooddelivery_fe/api/payment/payment_api.dart';
import 'package:fooddelivery_fe/model/payment_model.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  late PaymentApi paymentApi;
  RxList<PaymentModel> listPayment = <PaymentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    paymentApi = PaymentApi();
  }

  @override
  void refresh() {
    super.refresh();
  }

  Future<void> getAllListPayment() async {
    final response = await paymentApi.getAllPayMent();
    if (response.message == "Success") {
      final receivedListPaymentJson = response.data as List<dynamic>;
      listPayment.value = receivedListPaymentJson
          .map((payment) => PaymentModel.fromJson(payment))
          .toList();
    }
  }
}
