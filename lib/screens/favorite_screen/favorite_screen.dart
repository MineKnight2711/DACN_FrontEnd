// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/controller/favorite_controller.dart';
import 'package:fooddelivery_fe/screens/favorite_screen/components/favorite_item.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_message.dart';
import 'package:fooddelivery_fe/widgets/empty_widget.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';

class FavoriteScreen extends GetView {
  FavoriteScreen({super.key});
  final favoriteController = Get.find<FavoriteController>();
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Get.back();
        },
        title: tr("favorite_products.appbar.favorite_products_text"),
      ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Obx(() {
            if (favoriteController.listFavorite.isNotEmpty) {
              return NoGlowingScrollView(
                child: Column(
                    children: favoriteController.listFavorite
                        .map((favorite) => FavoriteItem(
                              addToCartPressed: () async {
                                if (await showConfirmDialog(
                                    context,
                                    "Thêm ${favorite.dish?.dishName}",
                                    "Bạn có muốn thêm ${favorite.dish?.dishName} vào giỏ hàng ?")) {
                                  String? result = await cartController
                                      .addToCart(favorite.dish, 1);
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
                              favorite: favorite,
                            ))
                        .toList()),
              );
            }
            return EmptyWidget(
              tilte: tr("favorite_products.no_favorite"),
              assetsAnimations: "cat_sleep",
            );
          })),
    );
  }
}
