// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/controller/favorite_controller.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/favorite_icon_button.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:fooddelivery_fe/widgets/custom_button.dart';
import 'package:fooddelivery_fe/widgets/custom_message.dart';
import 'package:fooddelivery_fe/widgets/quantity_chooser.dart';
import 'package:get/get.dart';

class DishDetailsBottomSheet extends StatelessWidget {
  final DishFavoriteCountDTO dishDTO;
  // final detailController = Get.find<ProductDetailController>();
  // final accountController = Get.find<AccountApi>();
  final cartController = Get.find<CartController>();
  final favoriteController = Get.find<FavoriteController>();
  DishDetailsBottomSheet({super.key, required this.dishDTO});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 590.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.amber[100],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.network("${dishDTO.dish.imageUrl}").image,
                      )),
                  width: double.infinity,
                  height: 400.h,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dishDTO.dish.dishName,
                          style: CustomFonts.customGoogleFonts(
                              fontSize: 18.r, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DataConvert().formatCurrency(dishDTO.dish.price),
                          style: CustomFonts.customGoogleFonts(fontSize: 16.r),
                        ),
                      ],
                    ),
                    const Spacer(),
                    FavoriteIconButton(
                      dishDTO: dishDTO,
                      favoriteController: favoriteController,
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        dishDTO.dish.description,
                        style: CustomFonts.customGoogleFonts(
                            fontSize: 13.r, color: AppColors.dark20),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
          Divider(
            thickness: 5.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            child: Row(
              children: [
                QuantityChooser(
                  onQuantityChanged: (quantity) {
                    cartController.selectedQuantity.value = quantity;
                  },
                  minAmount: 1,
                ),
                const Spacer(),
                SizedBox(
                  height: 40.h,
                  child: RoundIconButton(
                    size: 50.w,
                    title: "Đặt mua",
                    onPressed: () async {
                      if (await showConfirmDialog(
                          context,
                          "Thêm ${dishDTO.dish.dishName}",
                          "Bạn có muốn thêm ${dishDTO.dish.dishName} vào giỏ hàng ?")) {
                        String? result = await cartController.addToCart(
                            dishDTO.dish,
                            cartController.selectedQuantity.value);
                        switch (result) {
                          case "Success":
                            showCustomSnackBar(
                                context,
                                "Thông báo",
                                "Thêm vào giỏ hàng thành công",
                                ContentType.success,
                                2);
                            Get.back();
                            break;
                          case "UpdatedCart":
                            showCustomSnackBar(
                                context,
                                "Thông báo",
                                "Cập nhật giỏ hàng thành công",
                                ContentType.help,
                                2);
                            Get.back();
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
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
