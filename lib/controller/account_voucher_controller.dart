import 'package:fooddelivery_fe/api/account/account_voucher_api.dart';
import 'package:fooddelivery_fe/controller/account_controller.dart';
import 'package:fooddelivery_fe/model/account_voucher_model.dart';
import 'package:get/get.dart';

class AccountVoucherController extends GetxController {
  late AccountVoucherApi _accountVoucherApi;
  late AccountController _accountController;
  RxList<AccountVoucherModel> listAccountVoucher = <AccountVoucherModel>[].obs;
  RxList<AccountVoucherModel> listAccountVoucherExp =
      <AccountVoucherModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    _accountVoucherApi = AccountVoucherApi();
    _accountController = Get.find<AccountController>();
  }

  Future<void> getAllAccountVouchers() async {
    await _accountController.fetchCurrentUser();
    if (_accountController.accountSession.value != null) {
      final response = await _accountVoucherApi.getAccountVouchers(
          "${_accountController.accountSession.value?.accountID}");
      if (response.message == "Success") {
        final accountVoucherJson = response.data as List<dynamic>;
        listAccountVoucher.value = accountVoucherJson
            .map((item) => AccountVoucherModel.fromJson(item))
            .toList();
        checkExpVoucher();
      } else if (response.message == "NoVoucher") {
        listAccountVoucher.clear();
      }
    }
  }

  void checkExpVoucher() {
    listAccountVoucherExp.assignAll(listAccountVoucher.where((item) {
      DateTime? itemExpDate = item.voucher.expDate;
      return itemExpDate != null && itemExpDate.isBefore(DateTime.now());
    }).toList());

    listAccountVoucher.removeWhere((item) {
      DateTime? itemExpDate = item.voucher.expDate;
      return itemExpDate != null && itemExpDate.isBefore(DateTime.now());
    });
  }

  Future<String> deleteVoucher(String voucherId) async {
    if (_accountController.accountSession.value != null) {
      final response = await _accountVoucherApi.deleteVoucher(
          "${_accountController.accountSession.value?.accountID}", voucherId);
      return response.message ?? "";
    }
    return "Fail";
  }
}
