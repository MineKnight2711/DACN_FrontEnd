// ignore_for_file: use_build_context_synchronously
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/controller/payment_controller.dart';
import 'package:fooddelivery_fe/controller/transaction_controller.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/cart_view/components/cart_item.dart';
import 'package:fooddelivery_fe/screens/payment_screen/payment_screen.dart';
import 'package:fooddelivery_fe/widgets/custom_message.dart';
import 'package:fooddelivery_fe/widgets/empty_widget.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/cart_total_view.dart';

class CartView extends StatelessWidget {
  final CartController cartController;
  const CartView({super.key, required this.cartController});

  @override
  Widget build(BuildContext context) {
    cartController.getAccountCart();
    return Stack(children: [
      NoGlowingScrollView(
        child: Obx(
          () => SizedBox(
            height: cartController.calculateListCartHeight().value,
            child: Column(
              children: [
                Text(
                  "Giỏ hàng của bạn",
                  style: GoogleFonts.roboto(fontSize: 20),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Obx(
                  () {
                    if (cartController.listCart.isNotEmpty) {
                      return Column(
                        children: cartController.listCart
                            .map((cartItem) => CartItem(
                                  cartItem: cartItem,
                                  cartController: cartController,
                                ))
                            .toList(),
                      );
                    }
                    return const EmptyWidget(
                        tilte: "Giỏ hàng trống..",
                        assetsAnimations: "person_empty_box");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Obx(
          () => CartTotalView(
            checkOutEnable: cartController.listCart.isNotEmpty,
            cartTotal: cartController.calculateTotal().value,
            deleteCartPressed: cartController.listCart.isNotEmpty
                ? () async {
                    bool result = await showConfirmDialog(context,
                        "Xoá giỏ hàng", "Bạn có chắc muốn xoá giỏ hàng?");
                    if (result) {
                      String? result =
                          await cartController.clearCart().whenComplete(
                                () => cartController.getAccountCart(),
                              );
                      if (result == "Success") {
                        showCustomSnackBar(context, "Thông báo",
                            "Đã xoá giỏ hàng", ContentType.success, 1);
                      } else {
                        showCustomSnackBar(
                            context,
                            "Thông báo",
                            "Có lỗi xảy ra!\nChi tiết :$result",
                            ContentType.failure,
                            2);
                      }
                    }
                  }
                : null,
            checkoutPressed: () {
              final paymentController = Get.put(PaymentController());
              final transactionController = Get.put(TransactionController());
              paymentController.getAllListPayment();
              transactionController.getAccountListAddress();
              Get.to(
                () => CheckoutScreen(cartController.listCart),
                transition: Transition.downToUp,
              );
            },
          ),
        ),
      ),
    ]);
  }
}
