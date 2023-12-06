// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/controller/favorite_controller.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/dish_view/dish_view.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:fooddelivery_fe/widgets/custom_message.dart';
import 'package:get/get.dart';

class FavoriteIconButton extends StatefulWidget {
  final DishModel dish;
  final FavoriteController favoriteController;
  const FavoriteIconButton(
      {super.key, required this.dish, required this.favoriteController});

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return FutureBuilder(
        future: widget.favoriteController
            .getAccountFavoriteDish(widget.dish.dishID),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return FavoriteIcon(
              onFavorite: () async {
                showLoadingAnimation(
                    context, "assets/animations/loading.json", 180);
                String result = await widget.favoriteController
                    .unFavorite(widget.dish.dishID)
                    .whenComplete(() {
                  Navigator.pop(context);
                  setState(() {});
                });
                if (result == "Success") {
                  showCustomSnackBar(
                      context, "Thông báo", "Đã bỏ thích", ContentType.help, 2);
                } else {
                  showCustomSnackBar(
                      context,
                      "Lỗi",
                      "Có lỗi xảy ra\nChi tiết : $result",
                      ContentType.failure,
                      2);
                }
              },
              color: Colors.red,
              iconData: CupertinoIcons.heart_fill,
            );
          }
          return FavoriteIcon(
            onFavorite: () async {
              showLoadingAnimation(
                  context, "assets/animations/loading.json", 180);
              String result = await widget.favoriteController
                  .addToFavorite(widget.dish)
                  .whenComplete(() {
                widget.favoriteController
                    .getAccountFavoriteDish(widget.dish.dishID);
                Navigator.pop(context);
                setState(() {});
              });
              if (result == "Success") {
                showCustomSnackBar(context, "Thông báo", "Đã lưu vào yêu thích",
                    ContentType.success, 2);
              } else {
                showCustomSnackBar(
                    context,
                    "Lỗi",
                    "Có lỗi xảy ra\nChi tiết : $result",
                    ContentType.failure,
                    2);
              }
            },
            color: AppColors.dark100,
            iconData: CupertinoIcons.heart,
          );
        },
      );
    });
  }
}
