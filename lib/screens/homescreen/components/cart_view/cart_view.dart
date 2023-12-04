// ignore_for_file: use_build_context_synchronously
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/controller/payment_controller.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/cart_view/components/cart_item.dart';
import 'package:fooddelivery_fe/screens/payment_screen/payment_screen.dart';
import 'package:fooddelivery_fe/widgets/custom_message.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
                    if (cartController.listCart.value.isNotEmpty) {
                      return Column(
                        children: cartController.listCart.value
                            .map((cartItem) => CartItem(
                                  cartItem: cartItem,
                                  cartController: cartController,
                                ))
                            .toList(),
                      );
                    }
                    return const Center(child: Text("No cart"));
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
            checkOutEnable: cartController.listCart.value.isNotEmpty,
            cartTotal: cartController.calculateTotal().value,
            deleteCartPressed: cartController.listCart.value.isNotEmpty
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
              paymentController.getAllListPayment();
              Get.to(
                () => PaymentMethodScreen(),
                transition: Transition.downToUp,
              );
            },
          ),
        ),
      ),
    ]);
  }
}

// [
//   Text("Test"),
//   Text("Test"),
//   ElevatedButton(
//     onPressed: () async {
//       // final webViewController = MainController.initController();
//       // webViewController
//       //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       //   ..setBackgroundColor(const Color(0x00000000))
//       //   ..setNavigationDelegate(
//       //     NavigationDelegate(
//       //       onProgress: (int progress) {
//       //         // Update loading bar.
//       //       },
//       //       onPageStarted: (String url) {},
//       //       onPageFinished: (String url) {},
//       //       onWebResourceError: (WebResourceError error) {},
//       //       onNavigationRequest: (NavigationRequest request) {
//       //         if (request.url.startsWith('https://www.example.com/')) {
//       //           Navigator.pop(context);
//       //           return NavigationDecision.prevent;
//       //         }
//       //         return NavigationDecision.navigate;
//       //       },
//       //     ),
//       //   )
//       //   ..loadRequest(Uri.parse(
//       //       'https://pay.payos.vn/web/434be2f71ae64d23b14d7a423a15d796'));
//       // slideInTransition(
//       //     context,
//       //     WebView(
//       //       webViewController: webViewController,
//       //     ));
//     },
//     child: Text('Show Flutter homepage'),
//   ),
// ],
class WebView extends StatelessWidget {
  final WebViewController webViewController;
  const WebView({super.key, required this.webViewController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: WebViewWidget(controller: webViewController),
    );
  }
}
