// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/favorite_controller.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:fooddelivery_fe/widgets/custom_message.dart';
import 'package:get/get.dart';

class FavoriteIconButton extends StatefulWidget {
  final DishFavoriteCountDTO dishDTO;
  final FavoriteController favoriteController;
  const FavoriteIconButton(
      {super.key, required this.dishDTO, required this.favoriteController});

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return FutureBuilder(
        future: widget.favoriteController
            .getAccountFavoriteDish(widget.dishDTO.dish.dishID),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return FavoriteIcon(
              favoriteCount: widget.dishDTO.favoriteCount,
              onFavorite: () async {
                showLoadingAnimation(
                    context, "assets/animations/loading.json", 180);
                String result = await widget.favoriteController
                    .unFavorite(widget.dishDTO.dish.dishID)
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
            favoriteCount: widget.dishDTO.favoriteCount,
            onFavorite: () async {
              showLoadingAnimation(
                  context, "assets/animations/loading.json", 180);
              String result = await widget.favoriteController
                  .addToFavorite(widget.dishDTO.dish)
                  .whenComplete(() {
                widget.favoriteController
                    .getAccountFavoriteDish(widget.dishDTO.dish.dishID);
                Navigator.pop(context);
                setState(() {});
              });
              if (result == "Success") {
                showCustomSnackBar(context, "Thông báo", "Đã lưu vào yêu thích",
                    ContentType.success, 2);
              } else if (result == "NotLogin") {
                showCustomSnackBar(
                    context,
                    "Lỗi",
                    "Bạn chưa đăng nhập\nVui lòng đăng nhập để lưu món này ",
                    ContentType.failure,
                    2);
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

class FavoriteIcon extends StatelessWidget {
  final Function()? onFavorite;
  final int favoriteCount;
  final Color? color;
  final IconData? iconData;
  const FavoriteIcon(
      {super.key,
      this.onFavorite,
      this.color,
      this.iconData,
      required this.favoriteCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          splashRadius: 20.r,
          splashColor: Colors.pink.withOpacity(0.4),
          onPressed: onFavorite,
          icon: Icon(
            iconData,
            size: 25.r,
            color: color,
          ),
        ),
        Text(
          "$favoriteCount",
          style: CustomFonts.customGoogleFonts(fontSize: 12.r),
        )
      ],
    );
  }
}
