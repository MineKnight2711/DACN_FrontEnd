// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/dish_view/dish_view.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:fooddelivery_fe/widgets/custom_message.dart';
import 'package:google_fonts/google_fonts.dart';

class DishItemByCategoryView extends StatelessWidget {
  const DishItemByCategoryView({
    super.key,
    required this.dish,
    required this.cartController,
  });

  final DishModel dish;
  final CartController cartController;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: CustomMediaQuerry.mediaWidth(context, 1),
        height: CustomMediaQuerry.mediaHeight(context, 3.5),
        // color: Colors.blueGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                slideInTransition(context, TestWidget());
              },
              child: Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: SizedBox(
                    width: 120.w,
                    height: 150.h,
                    child: Image.network(
                      fit: BoxFit.cover,
                      dish.imageUrl,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dish.dishName,
                        style: GoogleFonts.roboto(fontSize: 18),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        DataConvert().formatCurrency(dish.price),
                        style: GoogleFonts.roboto(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (await showConfirmDialog(
                          context,
                          "Thêm ${dish.dishName}",
                          "Bạn có muốn thêm ${dish.dishName} vào giỏ hàng ?")) {
                        String? result =
                            await cartController.addToCart(dish, 1);
                        switch (result) {
                          case "Success":
                            showCustomSnackBar(
                                context,
                                "Thông báo",
                                "Thêm vào giỏ hàng thành công",
                                ContentType.success,
                                2);
                            break;
                          case "UpdatedCart":
                            showCustomSnackBar(
                                context,
                                "Thông báo",
                                "Cập nhật giỏ hàng thành công",
                                ContentType.help,
                                2);
                            break;
                          case "NoAccount":
                            showCustomSnackBar(
                                context,
                                "Lỗi",
                                "Bạn phải đăng nhập để thêm sản phẩm vào giỏ hàng",
                                ContentType.failure,
                                2);
                            break;
                          default:
                            showCustomSnackBar(
                                context,
                                "Lỗi",
                                "Lỗi chưa xác định: $result",
                                ContentType.failure,
                                2);
                            break;
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),

                      backgroundColor:
                          AppColors.orange100, // Make the button circular
                      padding: const EdgeInsets.all(12),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white, // Set the icon's color
                      size: 18, // Set the icon's size
                    ),
                  ),
                ),
              ],
            )

            // SizedBox(height: 10.h),
            // Text(
            //   dish.description,
            //   maxLines: 1,
            //   overflow: TextOverflow.fade,
            //   style: GoogleFonts.roboto(fontSize: 16),
            // ),
          ],
        ),
      ),
    );
  }
}
