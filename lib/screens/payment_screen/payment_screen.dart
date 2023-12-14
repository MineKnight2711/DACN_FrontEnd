// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/address_controller.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/controller/main_controllers.dart';
import 'package:fooddelivery_fe/controller/payment_controller.dart';
import 'package:fooddelivery_fe/controller/transaction_controller.dart';
import 'package:fooddelivery_fe/model/cart_model.dart';
import 'package:fooddelivery_fe/model/transaction_response.dart';
import 'package:fooddelivery_fe/screens/homescreen/homescreen.dart';
import 'package:fooddelivery_fe/screens/payment_screen/components/payment_method_choose.dart';
import 'package:fooddelivery_fe/screens/payment_screen/components/choose_address_screen.dart';
import 'package:fooddelivery_fe/screens/payment_screen/components/payment_webview.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';

import 'package:fooddelivery_fe/widgets/custom_widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_button.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_message.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckoutScreen extends GetView {
  final List<CartModel> listItem;
  CheckoutScreen(this.listItem, {super.key});
  final paymentController = Get.find<PaymentController>();
  final transactionController = Get.find<TransactionController>();
  final cartController = Get.find<CartController>();

  Future<bool> popScreen() async {
    Get.delete<PaymentController>();
    Get.delete<TransactionController>();
    Get.delete<AddressController>();
    paymentController.refresh();
    return true;
  }

  double caculatecartItemHeight(int itemCount) {
    double maxHeight = 280.h;
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
          title: "Thanh toán",
        ),
        body: Padding(
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
                color: AppColors.dark100,
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sản phẩm đã chọn:',
                  style: GoogleFonts.roboto(
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
                transactionController: transactionController,
                paymentController: paymentController,
              ),
              SizedBox(height: 10.h),
              PaymentDetails(
                cartTotal: cartController.calculateTotal().value,
                itemAmount: listItem.fold(
                    0,
                    (previousValue, cartItem) =>
                        previousValue += cartItem.quantity ?? 0),
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
                            listItem, cartController.calculateTotal().value)
                        .whenComplete(() => Get.back());
                    print("Result --------- ${result.message}");

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
                title: "Thanh toán",
              ),
            ],
          ),
        ),
      ),
    );
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

//Widget địa chỉ của account
class AccountAddress extends StatelessWidget {
  const AccountAddress({
    super.key,
    required this.transactionController,
  });

  final TransactionController transactionController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.dark100,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListTile(
              title: Text(
                "Thông tin người nhận :",
                style: GoogleFonts.roboto(fontSize: 14.r),
              ),
              subtitle: Obx(
                () => Text(
                  "${transactionController.selectedAddress.value?.receiverName} | ${transactionController.selectedAddress.value?.receiverPhone}",
                  style: GoogleFonts.roboto(
                      fontSize: 13.r, color: AppColors.dark20),
                ),
              ),
              trailing: TextButton.icon(
                label: Text(
                  "Sửa",
                  style: GoogleFonts.roboto(fontSize: 14.r),
                ),
                onPressed: () {
                  Get.to(ChooseAddressScreen(),
                      transition: Transition.rightToLeft);
                },
                icon: const Icon(
                  CupertinoIcons.pencil,
                  size: 18,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 11.w),
            child: Text(
              "Địa chỉ :",
              style: GoogleFonts.roboto(fontSize: 14.r),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 11.w), // Adjust padding as needed
              child: NoGlowingScrollView(
                child: Obx(
                  () => Text(
                    "${transactionController.selectedAddress.value?.details}, ${transactionController.selectedAddress.value?.ward}, ${transactionController.selectedAddress.value?.district}, ${transactionController.selectedAddress.value?.province}",
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.roboto(
                        fontSize: 13.r, color: AppColors.dark20),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Widget chi tiết thanh toán
class PaymentDetails extends StatelessWidget {
  final double cartTotal;

  final int itemAmount;

  const PaymentDetails(
      {super.key, required this.cartTotal, required this.itemAmount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chi tiết thanh toán:',
          style: CustomFonts.customGoogleFonts(
              fontSize: 16.r, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Món ăn (số lượng)',
              style: CustomFonts.customGoogleFonts(fontSize: 14.r),
            ),
            Text(
              itemAmount.toString(),
              style: CustomFonts.customGoogleFonts(fontSize: 14.r),
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Giảm giá',
              style: CustomFonts.customGoogleFonts(fontSize: 14.r),
            ),
            Text(
              '10%',
              style: CustomFonts.customGoogleFonts(fontSize: 14.r),
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        const Divider(color: AppColors.gray100),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tổng cộng',
              style: CustomFonts.customGoogleFonts(fontSize: 18.r),
            ),
            Text(
              DataConvert().formatCurrency(cartTotal),
              style: CustomFonts.customGoogleFonts(fontSize: 18.r),
            ),
          ],
        ),
      ],
    );
  }
}

//Widget chọn phương thức thanh toán và chọn voucher
class PaymentMethodAndVoucher extends StatelessWidget {
  final TransactionController transactionController;
  final PaymentController paymentController;
  const PaymentMethodAndVoucher(
      {super.key,
      required this.transactionController,
      required this.paymentController});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => PaymentDialog(
                  transactionController: transactionController,
                  paymentController: paymentController),
            );
          },
          label: Obx(
            () => Text(
              transactionController.selectedPayment.value != null
                  ? "${transactionController.selectedPayment.value?.paymentMethod}"
                  : "Chọn phương thức thanh toán",
              style: GoogleFonts.roboto(fontSize: 14.r),
            ),
          ),
          icon: const Icon(CupertinoIcons.creditcard),
        ),
        Container(
          color: AppColors.dark100,
          width: 0.5.w,
          height: 20.h,
        ),
        TextButton.icon(
          onPressed: () {},
          label: Text(
            "Thêm mã giảm giá",
            style: GoogleFonts.roboto(fontSize: 14.r),
          ),
          icon: const Icon(CupertinoIcons.tags),
        ),
      ],
    );
  }
}

//Widget danh sách các món đã đặt
class OrderItems extends StatelessWidget {
  final List<CartModel> listItem;
  final double listHeight;
  const OrderItems(
      {super.key, required this.listItem, required this.listHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: listHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.dark100,
          width: 1,
        ),
      ),
      child: listItem.isNotEmpty
          ? NoGlowingScrollView(
              child: Column(
                children: listItem
                    .map(
                      (item) => Column(
                        children: [
                          SizedBox(
                            height: 55.h,
                            child: ListTile(
                              leading: Image.network(
                                "${item.dish?.imageUrl}",
                              ),
                              title: Text(
                                "${item.quantity}x ${item.dish?.dishName}",
                                style: GoogleFonts.roboto(fontSize: 14.r),
                              ),
                              subtitle: Text(
                                "${item.dish?.category.categoryName}",
                                style: GoogleFonts.roboto(fontSize: 12.r),
                              ),
                              trailing: Text(
                                DataConvert().formatCurrency(
                                    double.parse("${item.quantity}") *
                                        double.parse("${item.dish?.price}")),
                                style: GoogleFonts.roboto(fontSize: 12.r),
                              ),
                            ),
                          ),
                          Divider(
                            height: 15.h,
                            indent: 15.w,
                            endIndent: 15.w,
                            color: AppColors.gray100,
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
