// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/account_voucher_controller.dart';
import 'package:fooddelivery_fe/controller/address_controller.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/controller/main_controllers.dart';
import 'package:fooddelivery_fe/controller/payment_controller.dart';
import 'package:fooddelivery_fe/controller/transaction_controller.dart';
import 'package:fooddelivery_fe/model/cart_model.dart';
import 'package:fooddelivery_fe/model/transaction_response.dart';
import 'package:fooddelivery_fe/screens/homescreen/homescreen.dart';
import 'package:fooddelivery_fe/screens/payment_screen/components/choose_dishes_box.dart';
import 'package:fooddelivery_fe/screens/payment_screen/components/payment_details.dart';
import 'package:fooddelivery_fe/screens/payment_screen/components/payment_webview.dart';
import 'package:fooddelivery_fe/screens/payment_screen/components/selected_address_box.dart';
import 'package:fooddelivery_fe/screens/payment_screen/components/selected_payment_method_and_voucher.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';

import 'package:fooddelivery_fe/widgets/custom_widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_button.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_message.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutScreen extends GetView {
  final List<CartModel> listItem;
  CheckoutScreen(this.listItem, {super.key});
  final paymentController = Get.find<PaymentController>();
  final transactionController = Get.find<TransactionController>();
  final cartController = Get.find<CartController>();
  final accountVoucherController = Get.find<AccountVoucherController>();
  Future<bool> popScreen() async {
    Get.delete<PaymentController>();
    Get.delete<TransactionController>();
    Get.delete<AddressController>();
    paymentController.refresh();
    return true;
  }

  Future<bool> refresh() async {
    paymentController.getAllListPayment();
    accountVoucherController.getAllAccountVouchers();
    return true;
  }

  double caculatecartItemHeight(int itemCount) {
    double maxHeight = 230.h;
    double itemHeight = 55.h;
    double dividerHeight = 15.h;
    double height = 0.0;
    height = (itemHeight + dividerHeight) * itemCount;
    if (height < maxHeight) {
      return height;
    } else {
      height = maxHeight;
      return height;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: popScreen,
      child: Scaffold(
        appBar: CustomAppBar(
          onPressed: () {
            popScreen();
            Get.back();
          },
          title: tr("payment.appbar.payment_text"),
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: NoGlowingScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.r),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  AccountAddress(transactionController: transactionController),
                  SizedBox(height: 10.h),
                  Divider(
                    thickness: 0.5.w,
                    endIndent: 10.w,
                    indent: 10.w,
                    height: 5.h,
                    color: AppColors.dark100,
                  ),
                  SizedBox(height: 10.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tr("payment.selected_product"),
                      style: CustomFonts.customGoogleFonts(
                        fontSize: 14.r,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  OrderItems(
                    listItem: listItem,
                    listHeight: caculatecartItemHeight(listItem.length),
                  ),
                  SizedBox(height: 10.h),
                  PaymentMethodAndVoucher(
                    accountVoucherController: accountVoucherController,
                    transactionController: transactionController,
                    paymentController: paymentController,
                  ),
                  SizedBox(height: 10.h),
                  Obx(
                    () => PaymentDetailsBox(
                      transactionController: transactionController,
                      cartTotal: cartController.calculateTotal().value,
                      finalTotal: caculateCartTotal().value,
                      itemAmount: itemAmount(),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  RoundIconButton(
                    size: 80.r,
                    onPressed: () async {
                      showLoadingAnimation(
                          context, "assets/animations/loading.json", 140.w);
                      if (transactionController.selectedPayment.value == null) {
                        showCustomSnackBar(
                                context,
                                "Thông báo",
                                "Vui lòng chọn phương thức thanh toán!",
                                ContentType.failure,
                                2)
                            .whenComplete(() => Get.back());
                        return;
                      }
                      bool confirmOrdered = await showConfirmDialog(
                              context,
                              "Xác nhận đặt hàng",
                              "Đơn hàng sẽ được giao tại:\n\n${transactionController.selectedAddress.value?.details}, ${transactionController.selectedAddress.value?.ward}, ${transactionController.selectedAddress.value?.district}, ${transactionController.selectedAddress.value?.province}\n\nNgười nhận : ${transactionController.selectedAddress.value?.receiverName}, ${transactionController.selectedAddress.value?.receiverPhone}")
                          .whenComplete(() => Get.back());
                      if (confirmOrdered) {
                        showLoadingAnimation(
                            context, "assets/animations/loading.json", 140.w);
                        final result = await transactionController
                            .performTransaction(
                                listItem, caculateCartTotal().value)
                            .whenComplete(() => Get.back());

                        if (result.message == "Success") {
                          TransactionResponseModel response =
                              TransactionResponseModel.fromJson(result.data);
                          transactionController.refresh();
                          await cartController.clearCart();
                          showCustomSnackBar(context, "Thông báo",
                              "Đặt hàng thành công", ContentType.success, 2);

                          if (response.paymentResponse != null) {
                            toCheckoutWebView(context, response);
                          }
                        } else {
                          showCustomSnackBar(
                              context,
                              "Lỗi",
                              "Có lỗi xảy ra :\nChi tiết :${result.data}",
                              ContentType.failure,
                              2);
                        }
                      }
                    },
                    title: tr("payment.checkout"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  int itemAmount() {
    return listItem.fold(0,
        (previousValue, cartItem) => previousValue += cartItem.quantity ?? 0);
  }

  RxDouble caculateCartTotal() {
    RxDouble total = cartController.calculateTotal();
    if (transactionController.selectedVoucher.value != null) {
      final voucher = transactionController.selectedVoucher.value!;
      switch (voucher.type) {
        case "Percent":
          total.value = total.value -
              (total.value * ((voucher.discountPercent ?? 0) / 100));
          return total;
        case "Amount":
          total.value = total.value - (voucher.discountAmount ?? 0);
          return total;
        default:
          break;
      }
    }
    return total;
  }

  void toCheckoutWebView(
      BuildContext context, TransactionResponseModel response) {
    final webViewController = MainController.initController();
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.white100)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            if (request.url.contains("/api/transaction/success")) {
              String result = await transactionController
                  .updateTransaction(
                      "${response.orderId}", response.paymentDetailsId ?? 0)
                  .whenComplete(() => Get.offAll(() => const HomeScreen()));
              if (result == "Success") {
                showCustomSnackBar(context, "Thông báo",
                    "Thanh toán thành công", ContentType.success, 2);

                refresh();
              } else {
                showCustomSnackBar(
                    context,
                    "Có lỗi xảy ra",
                    "Thanh toán thất bại\nChi tiết $result",
                    ContentType.failure,
                    2);
              }
              return NavigationDecision.prevent;
            } else if (request.url.contains("/api/transaction/cancel")) {
              String result = await transactionController.cancleTransaction(
                  "${response.orderId}", response.paymentDetailsId ?? 0);
              if (result == "Success") {
                showCustomSnackBar(context, "Thông báo", "Đã huỷ thanh toán",
                        ContentType.help, 2)
                    .whenComplete(() => showDelayedLoadingAnimation(
                            context, "assets/animations/loading.json", 140.w, 2)
                        .whenComplete(
                            () => Get.offAll(() => const HomeScreen())));
              } else {
                showCustomSnackBar(
                    context, "Lỗi", "Có lỗi xảy ra", ContentType.failure, 2);
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse("${response.paymentResponse?.data?.checkoutUrl}"));
    Get.to(
        () => WillPopScope(
              onWillPop: () async {
                transactionController.cancleTransaction(
                    "${response.orderId}", response.paymentDetailsId ?? 0);
                return true;
              },
              child: PaymentWebView(
                webViewController: webViewController,
              ),
            ),
        transition: Transition.downToUp);
  }
}
