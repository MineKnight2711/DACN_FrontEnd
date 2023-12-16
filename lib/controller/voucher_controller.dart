import 'package:fooddelivery_fe/api/account/account_voucher_api.dart';
import 'package:fooddelivery_fe/api/voucher/voucer_api.dart';
import 'package:fooddelivery_fe/controller/account_voucher_controller.dart';
import 'package:fooddelivery_fe/model/voucher_model.dart';
import 'package:get/get.dart';

enum SortVoucherByPoints { highToLow, lowToHigh }

enum SortVoucherByExpDate { nearest, furthest }

enum SortVoucherByStartDate { nearest, furthest }

enum SortVoucherByType { percent, amount }

class VoucherController extends GetxController {
  late VoucherApi _voucherApi;
  late AccountVoucherApi _accountVoucherApi;
  late AccountVoucherController _accountVoucherController;
  RxList<VoucherModel> listVoucher = <VoucherModel>[].obs;
  RxList<VoucherModel> storedListVoucher = <VoucherModel>[].obs;

  final sortByPointsController = Rx<SortVoucherByPoints?>(null);
  final sortByExpDateController = Rx<SortVoucherByExpDate?>(null);
  final sortByStartDateController = Rx<SortVoucherByStartDate?>(null);
  final sortByTypeController = Rx<SortVoucherByType?>(null);

  @override
  void onInit() {
    super.onInit();
    _voucherApi = VoucherApi();
    _accountVoucherApi = AccountVoucherApi();
    _accountVoucherController = Get.find<AccountVoucherController>();
  }

  Future<void> getAllVoucher() async {
    final response = await _voucherApi.getAllVoucher();
    if (response.message == "Success") {
      final vouchersJson = response.data as List<dynamic>;
      listVoucher.value = storedListVoucher.value = vouchersJson
          .map((voucher) => VoucherModel.fromJson(voucher))
          .toList();
    }
  }

  Future<String> saveVoucherToAccount(
      String accountId, String voucherId) async {
    final response =
        await _accountVoucherApi.saveVoucherToAccount(accountId, voucherId);
    _accountVoucherController.getAllAccountVouchers();
    return response.message ?? "";
  }

  int comparePoints(VoucherModel a, VoucherModel b) {
    int aPoints = a.pointsRequired ?? 0;
    int bPoints = b.pointsRequired ?? 0;

    return bPoints.compareTo(aPoints);
  }

  int compareDates(DateTime? a, DateTime? b) {
    Duration aDiff = DateTime.now().difference(a ?? DateTime.now());
    Duration bDiff = DateTime.now().difference(b ?? DateTime.now());

    if (aDiff.abs() < bDiff.abs()) {
      return -1;
    } else if (bDiff.abs() < aDiff.abs()) {
      return 1;
    } else {
      return 0;
    }
  }

  void sortListOrder() {
    //Sắp xếp theo tổng tiền của đơn
    if (sortByPointsController.value != null) {
      switch (sortByPointsController.value) {
        case SortVoucherByPoints.highToLow:
          listVoucher.sort((a, b) => comparePoints(a, b));
          break;
        case SortVoucherByPoints.lowToHigh:
          listVoucher.sort((a, b) => comparePoints(b, a));
          break;
        case null:
          break;
      }
    }
    //Xếp theo ngày kết thúc voucher
    else if (sortByExpDateController.value != null) {
      switch (sortByExpDateController.value) {
        case SortVoucherByExpDate.nearest:
          listVoucher.removeWhere(
              (v) => v.expDate != null && v.expDate!.isBefore(DateTime.now()));
          listVoucher.sort((a, b) => compareDates(a.expDate, b.expDate));
          break;
        case SortVoucherByExpDate.furthest:
          listVoucher.removeWhere(
              (v) => v.expDate != null && v.expDate!.isBefore(DateTime.now()));
          listVoucher.sort((a, b) => compareDates(b.expDate, a.expDate));
          break;
        case null:
          break;
      }
    }
    //Xếp theo ngày bắt đầu voucher
    else if (sortByStartDateController.value != null) {
      switch (sortByStartDateController.value) {
        case SortVoucherByStartDate.nearest:
          listVoucher.removeWhere((v) =>
              v.startDate != null && v.startDate!.isBefore(DateTime.now()));
          listVoucher.sort((a, b) => compareDates(a.startDate, b.startDate));
          break;
        case SortVoucherByStartDate.furthest:
          listVoucher.removeWhere((v) =>
              v.startDate != null && v.startDate!.isBefore(DateTime.now()));
          listVoucher.sort((a, b) => compareDates(b.startDate, a.startDate));
          break;
        case null:
          break;
      }
    }
    //Xếp theo loại voucher
    else if (sortByTypeController.value != null) {
      switch (sortByTypeController.value) {
        case SortVoucherByType.percent:
          listVoucher.value = List.from(storedListVoucher);
          listVoucher.removeWhere((v) => v.type != 'Percent');
          break;
        case SortVoucherByType.amount:
          listVoucher.value = List.from(storedListVoucher);
          listVoucher.removeWhere((v) => v.type != 'Amount');
          break;
        case null:
          break;
      }
    }
  }
}
