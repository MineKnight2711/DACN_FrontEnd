// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/model/cart_model.dart';
import 'package:fooddelivery_fe/widgets/custom_message.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CartView extends StatelessWidget {
  final CartController cartController;
  const CartView({super.key, required this.cartController});

  @override
  Widget build(BuildContext context) {
    cartController.getAccountCart();
    return SingleChildScrollView(
      child: Obx(
        () {
          if (cartController.listCart.value.isNotEmpty) {
            return Column(
              children: [
                Text(
                  "Giỏ hàng của bạn",
                  style: GoogleFonts.roboto(fontSize: 20),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  children: cartController.listCart.value
                      .map((cartItem) => CartItem(
                            cartItem: cartItem,
                            cartController: cartController,
                          ))
                      .toList(),
                ),
              ],
            );
          }
          return Center(child: Text("No cart"));
        },
      ),
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
    );
  }
}

class CartItem extends StatelessWidget {
  final CartModel cartItem;
  final CartController cartController;
  const CartItem(
      {super.key, required this.cartItem, required this.cartController});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // key: Key("${cartItem.cartID}"),
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (context) {},
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: const Color.fromARGB(255, 18, 7, 7),
            icon: CupertinoIcons.pencil,
            label: 'Sửa',
          ),
          SlidableAction(
            onPressed: (slideContext) async {
              if (await showConfirmDialog(context, "Lời nhắc",
                  "Bạn có chắc muốn xoá ${cartItem.dish?.dishName}")) {
                String? result = await cartController
                    .deleteCartItem("${cartItem.cartID}")
                    .whenComplete(() => cartController.getAccountCart());
                if (result == "Success") {
                  showCustomSnackBar(context, "Thông báo", "Đã xoá sản phẩm",
                      ContentType.success);
                } else {
                  showCustomSnackBar(
                      context, "Lỗi", "Có lỗi xảy ra", ContentType.failure);
                }
              }
            },
            backgroundColor: const Color(0xFF0392CF),
            foregroundColor: Colors.white,
            icon: CupertinoIcons.delete,
            label: 'Xoá',
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.w),
        width: 400.w,
        height: 80.h,
        child: Row(
          children: [
            SizedBox(
              width: 10.w,
            ),
            Container(
              width: 70.w,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    "${cartItem.dish?.imageUrl}",
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${cartItem.dish?.dishName}",
                  style: GoogleFonts.roboto(fontSize: 18),
                ),
                SizedBox(height: 5.h),
                Text(
                  "${cartItem.dish?.price}",
                  style: GoogleFonts.roboto(fontSize: 16),
                ),
                SizedBox(height: 5.h),
                Text(
                  "SL :${cartItem.quantity}",
                  style: GoogleFonts.roboto(fontSize: 16),
                ),
                // SizedBox(height: 5.h),
                // Text(
                //   cartItem.dish.description,
                //   style: const TextStyle(fontSize: 16),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
