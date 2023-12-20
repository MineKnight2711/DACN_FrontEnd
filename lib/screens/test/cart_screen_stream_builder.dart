import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fooddelivery_fe/api/cart_api/cart_api.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/model/cart_model.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CartTestController extends GetxController {
  final CartApi _cartApi = CartApi();
  final RxList<CartModel> carts = <CartModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      getAllCart();
    });
  }

  Future<void> getAllCart() async {
    final responseBaseModel = await _cartApi.getCartByAccount("AC0000000002");
    if (responseBaseModel?.message == "Success") {
      final categoryReceived = responseBaseModel?.data as List<dynamic>;
      final listCart = categoryReceived
          .map(
            (categoryMap) => CartModel.fromJson(categoryMap),
          )
          .toList();
      carts.value = listCart;
    }
  }
}

class CartScreenRealtime extends StatelessWidget {
  final CartTestController _cartTestController = Get.put(CartTestController());
  CartScreenRealtime({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (_cartTestController.carts.isNotEmpty) {
        return Column(
          children: _cartTestController.carts
              .map((cartItem) => CartItemRealtime(cartItem: cartItem))
              .toList(),
        );
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    }));
  }
}

class CartItemRealtime extends StatelessWidget {
  final CartModel cartItem;
  const CartItemRealtime({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            // flex: 3,
            onPressed: (con) {
              // showDialog(
              //     barrierDismissible: false,
              //     context: context,
              //     builder: (context) {
              //       return QuantityDialog(
              //         onNoQuantity: () {},
              //         onQuantityChanged: (quantity) {
              //           cartController.updateCart(cartItem, quantity);
              //         },
              //         currentQuantity: cartItem.quantity ?? 0,
              //       );
              //     }).whenComplete(() async {
              //   if (cartItem.quantity == 0) {
              //     bool result = await showConfirmDialog(
              //         context,
              //         tr("cart.cart_message.quantity_cannot_zero"),
              //         tr("cart.cart_message.dish_remove"));
              //     if (result) {
              //       cartController.deleteCartItem(cartItem);
              //     } else {
              //       cartController.updateCart(cartItem, 1);
              //     }
              //   } else {
              //     String updateResult = await cartController.updateCartApi(
              //         "${cartItem.cartID}", cartItem.quantity ?? 0);
              //     if (updateResult != "UpdatedCart") {
              //       showCustomSnackBar(
              //           context,
              //           "Lỗi",
              //           "Có lỗi xảy ra\nChi tiết : $updateResult",
              //           ContentType.failure,
              //           2);
              //     }
              //   }
              // });
            },
            borderRadius: BorderRadius.circular(20),
            backgroundColor: Colors.blue[200]!,
            foregroundColor: AppColors.dark100,
            icon: CupertinoIcons.pencil,
            label: tr("cart.dishes_cart.edit_dishes"),
          ),
          SlidableAction(
            onPressed: (slideContext) async {
              // if (await showConfirmDialog(context, "Lời nhắc",
              //     "Bạn có chắc muốn xoá ${cartItem.dish?.dishName}")) {
              //   showLoadingAnimation(
              //       context, "assets/animations/loading.json", 180);
              //   String? result = await cartController
              //       .deleteCartItem(cartItem)
              //       .whenComplete(() {
              //     Navigator.pop(context);
              //     cartController.getAccountCart();
              //   });
              //   if (result == "Success") {
              //     showCustomSnackBar(context, "Thông báo", "Đã xoá sản phẩm",
              //         ContentType.success, 2);
              //   } else {
              //     showCustomSnackBar(
              //         context, "Lỗi", "Có lỗi xảy ra", ContentType.failure, 2);
              //   }
              // }
            },
            borderRadius: BorderRadius.circular(20),
            backgroundColor: AppColors.orange100,
            foregroundColor: AppColors.white100,
            icon: CupertinoIcons.delete,
            label: tr("cart.dishes_cart.remove_dishes"),
          ),
        ],
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
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
                    image: Image.network(
                      "${cartItem.dish?.imageUrl}",
                    ).image,
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
                    "Item total",
                    style: GoogleFonts.roboto(fontSize: 16),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    "SL :${cartItem.quantity}",
                    style: GoogleFonts.roboto(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
