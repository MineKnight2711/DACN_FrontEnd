import 'package:fooddelivery_fe/api/transaction/transaction_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/controller/address_controller.dart';
import 'package:fooddelivery_fe/model/address_model.dart';
import 'package:fooddelivery_fe/model/payment_model.dart';
import 'package:fooddelivery_fe/model/transaction_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TransactionController extends GetxController {
  late TransactionApi _transactionApi;
  late AccountController _accountController;
  late AddressController _addressController;
  RxList<AddressModel> listAddress = <AddressModel>[].obs;
  Rx<AddressModel> selectedAddress = AddressModel().obs;
  Rx<PaymentModel> selectedPayment = PaymentModel().obs;
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

  Future<String> performTransaction(List<DishItem> dishes) async {
    return "";
  }
}
