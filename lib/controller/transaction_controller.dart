import 'package:fooddelivery_fe/api/transaction/transaction_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/address_controller.dart';
import 'package:fooddelivery_fe/model/address_model.dart';
import 'package:fooddelivery_fe/model/cart_model.dart';
import 'package:fooddelivery_fe/model/payment_model.dart';
import 'package:fooddelivery_fe/model/transaction_response.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:fooddelivery_fe/model/transaction_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TransactionController extends GetxController {
  late TransactionApi _transactionApi;
  late AccountController _accountController;
  late AddressController _addressController;
  RxList<AddressModel> listAddress = <AddressModel>[].obs;
  Rx<AddressModel> selectedAddress = AddressModel().obs;
  Rx<PaymentModel?> selectedPayment = Rx<PaymentModel?>(null);
  @override
  void onInit() {
    super.onInit();
    _transactionApi = TransactionApi();
    _accountController = Get.find<AccountController>();
    _addressController = Get.put(AddressController());
  }

  Future<void> getAccountListAddress() async {
    if (_accountController.accountSession.value != null) {
      listAddress.value = await _addressController.getListAddressByAccountId(
              "${_accountController.accountSession.value?.accountID}") ??
          [];
      Logger().i("Loggggg list address :${listAddress.length}");
      AddressModel? defaultAddress = listAddress.firstWhereOrNull(
        (address) => address.defaultAddress.toString() == "true",
      );
      if (defaultAddress != null) {
        selectedAddress.value = defaultAddress;
      }
    }
  }

  List<DishItem> convertCartDishesToListDishItem(List<CartModel> cartList) {
    List<DishItem> dishItemList = cartList.map((cart) {
      return DishItem(
        dishId: cart.dish?.dishID,
        quantity: cart.quantity,
      );
    }).toList();

    return dishItemList;
  }

  Future<ResponseBaseModel> performTransaction(
      List<CartModel> dishes, double amount) async {
    ResponseBaseModel responseBaseModel = ResponseBaseModel();
    if (_accountController.accountSession.value != null) {
      if (selectedPayment.value != null &&
          selectedPayment.value?.paymentMethod != "COD") {
        OrderDTO newOrder = OrderDTO();
        newOrder.deliveryInfo =
            "${selectedAddress.value.details}, ${selectedAddress.value.ward}, ${selectedAddress.value.district}, ${selectedAddress.value.province} | ${selectedAddress.value.receiverName}, ${selectedAddress.value.receiverPhone}";
        newOrder.dishes = convertCartDishesToListDishItem(dishes);
        newOrder.quantity = dishes
            .fold(
                0,
                (previousValue, cartItem) =>
                    previousValue += cartItem.quantity ?? 0)
            .toInt();

        PaymentDetails newPaymentDetails = PaymentDetails();
        newPaymentDetails.amount = amount;
        newPaymentDetails.paymentId = selectedPayment.value?.paymentID;

        PaymentRequestBody newPaymentRequestBody = PaymentRequestBody();
        newPaymentRequestBody.amount = amount;

        TransactionModel newTransaction = TransactionModel();
        newTransaction.accountId =
            _accountController.accountSession.value?.accountID;
        newTransaction.ordersDTO = newOrder;
        newTransaction.paymentDetailsDTO = newPaymentDetails;
        newTransaction.paymentRequestBody = newPaymentRequestBody;
        final response =
            await _transactionApi.performTransaction(newTransaction);
        if (response.message == "Success") {
          Logger().i("Response dat:\n ${response.data}");
          TransactionResponseModel transactionResponse =
              TransactionResponseModel.fromJson(response.data);

          responseBaseModel.message = "Success";
          responseBaseModel.data = transactionResponse;
          return responseBaseModel;
        }
        responseBaseModel.message = "Fail";
        return responseBaseModel;
      }
      //Các trường hợp thanh toán khác
      responseBaseModel.message = "Fail";
      return responseBaseModel;
    }
    responseBaseModel.message = "Fail";
    return responseBaseModel;
  }

  Future<String> updateTransaction(String orderId, int paymentDetailsId) async {
    final response =
        await _transactionApi.updateTransaction(orderId, paymentDetailsId);
    return response.message ?? "";
  }
}
