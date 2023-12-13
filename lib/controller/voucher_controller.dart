import 'package:fooddelivery_fe/api/voucher/voucer_api.dart';
import 'package:fooddelivery_fe/model/voucher_model.dart';
import 'package:get/get.dart';

class VoucherController extends GetxController {
  late VoucherApi _voucherApi;
  RxList<VoucherModel> listVoucher = <VoucherModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    _voucherApi = VoucherApi();
  }

  Future<void> getAllVoucher() async {
    final response = await _voucherApi.getAllVoucher();
    if (response.message == "Success") {
      final vouchersJson = response.data as List<dynamic>;
      listVoucher.value = vouchersJson
          .map((voucher) => VoucherModel.fromJson(voucher))
          .toList();
    }
  }
}
