// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/controller/dish_controller.dart';
import 'package:fooddelivery_fe/controller/favorite_controller.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/dish_details_bottom_sheet.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/favorite_icon_button.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:fooddelivery_fe/widgets/custom_message.dart';
import 'package:fooddelivery_fe/widgets/image_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ListDishView extends StatefulWidget {
  final ScrollController outerScrollController;
  const ListDishView({super.key, required this.outerScrollController});

  @override
  State<ListDishView> createState() => _ListDishViewState();
}

class _ListDishViewState extends State<ListDishView> {
  final dishController = Get.find<DishController>();

  final cartController = Get.find<CartController>();

  final favoriteController = Get.find<FavoriteController>();

  double _calculateGridViewHeight(BuildContext context, int itemCount) {
    double gridHeight = 0;

    gridHeight += (120.h + 20) * itemCount;

    return gridHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (dishController.listDish.value.isNotEmpty) {
          return SizedBox(
              width: CustomMediaQuerry.mediaWidth(context, 1),
              height: _calculateGridViewHeight(
                  context, dishController.listDish.value.length),
              child: NotificationListener(
                onNotification: (notification) {
                  if (notification is ScrollUpdateNotification &&
                      notification.depth == 0 &&
                      notification.metrics.extentBefore == 0) {
                    widget.outerScrollController.animateTo(0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut);
                  }
                  return true;
                },
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: dishController.listDish.value.length,
                  itemBuilder: (context, index) {
                    final dish = dishController.listDish.value[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: 120.h,
                      width: 400.w - 20,
                      child: Card(
                        elevation: 2,
                        shadowColor: Colors.grey.withOpacity(1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.white,
                              builder: (BuildContext context) {
                                return DishDetailsBottomSheet(
                                  dish: dish,
                                );
                              },
                            ).whenComplete(() =>
                                cartController.selectedQuantity.value = 1);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ImageViewer(
                                          imageUrl: dish.imageUrl);
                                    },
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  child: SizedBox(
                                    width: 100.w,
                                    height: 120.h,
                                    child: Image.network(
                                      dish.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5.h),
                                    Text(
                                      dish.dishName,
                                      style: GoogleFonts.roboto(fontSize: 16.r),
                                    ),
                                    SizedBox(height: 10.h),
                                    Text(
                                      DataConvert().formatCurrency(dish.price),
                                      style: GoogleFonts.roboto(fontSize: 16.r),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  FavoriteIconButton(
                                    dish: dish,
                                    favoriteController: favoriteController,
                                  ),
                                  const Expanded(child: Card()),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (await showConfirmDialog(
                                          context,
                                          "Thêm ${dish.dishName}",
                                          "Bạn có muốn thêm ${dish.dishName} vào giỏ hàng ?")) {
                                        String? result = await cartController
                                            .addToCart(dish, 1);
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

                                      backgroundColor: AppColors
                                          .orange100, // Make the button circular
                                      padding: EdgeInsets.all(6.w),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color:
                                          Colors.white, // Set the icon's color
                                      size: 18, // Set the icon's size
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ));
        }
        return const Text("Không có món ăn");
      },
    );
  }
}

class FavoriteIcon extends StatelessWidget {
  final Function()? onFavorite;
  final Color? color;
  final IconData? iconData;
  const FavoriteIcon({super.key, this.onFavorite, this.color, this.iconData});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20.r,
      onPressed: onFavorite,
      icon: Icon(
        iconData,
        size: 25.r,
        color: color,
      ),
    );
  }
}
