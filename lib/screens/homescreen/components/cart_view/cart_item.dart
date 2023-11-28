// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/model/cart_model.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:fooddelivery_fe/widgets/custom_message.dart';
import 'package:google_fonts/google_fonts.dart';

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
                      ContentType.success, 2);
                } else {
                  showCustomSnackBar(
                      context, "Lỗi", "Có lỗi xảy ra", ContentType.failure, 2);
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
                  DataConvert().formatCurrency(cartItem.dish?.price ?? 0.0),
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
    );
  }
}
