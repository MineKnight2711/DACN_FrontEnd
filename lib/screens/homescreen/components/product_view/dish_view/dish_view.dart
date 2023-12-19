// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/controller/dish_controller.dart';
import 'package:fooddelivery_fe/controller/favorite_controller.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/dish_details_bottom_sheet.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/favorite_icon_button.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_message.dart';
import 'package:fooddelivery_fe/widgets/empty_widget.dart';
import 'package:fooddelivery_fe/widgets/image_view.dart';
import 'package:get/get.dart';

class ListDishView extends StatelessWidget {
  ListDishView({super.key});

  final dishController = Get.find<DishController>();

  final cartController = Get.find<CartController>();

  final favoriteController = Get.find<FavoriteController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (dishController.listDish.value.isNotEmpty) {
          return Column(
              children: dishController.listDish.value
                  .map((dishItem) => Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.w),
                        height: 130.h,
                        width: 400.w - 20,
                        child: Card(
                          elevation: 2,
                          shadowColor: Colors.grey.withOpacity(1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              _showBottomSheet(dishItem, context);
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
                                            imageUrl:
                                                "${dishItem.dish.imageUrl}");
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
                                        "${dishItem.dish.imageUrl}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(6.r),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5.h),
                                        Text(
                                          dishItem.dish.dishName,
                                          style: CustomFonts.customGoogleFonts(
                                              fontSize: 16.r),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          DataConvert().formatCurrency(
                                              dishItem.dish.price),
                                          style: CustomFonts.customGoogleFonts(
                                              fontSize: 14.r),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FavoriteIconButton(
                                      dishDTO: dishItem,
                                      favoriteController: favoriteController,
                                    ),
                                    SizedBox(
                                      width: 30.w,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (await showConfirmDialog(
                                              context,
                                              "Thêm ${dishItem.dish.dishName}",
                                              "Bạn có muốn thêm ${dishItem.dish.dishName} vào giỏ hàng ?")) {
                                            String? result =
                                                await cartController.addToCart(
                                                    dishItem.dish, 1);
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
                                          color: Colors
                                              .white, // Set the icon's color
                                          size: 18, // Set the icon's size
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList());
        }
        return EmptyWidgetSmall(
          assetsAnimations: "loading_1",
          tilte: tr("home.no_dish"),
        );
      },
    );
  }

  void _showBottomSheet(DishFavoriteCountDTO dishDTO, BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8, //Kích cỡ sheet khi vừa hiện lên
          minChildSize:
              0.3, //Khi ta kéo sheet về 0.3 chiều cao của nó, nó sẽ đóng
          maxChildSize: 0.95, //Chiều cao tối đa của sheet được phép kéo lên
          expand: false,
          builder: (context, scrollController) {
            return DishDetailsBottomSheet(
              dishDTO: dishDTO,
            );
          },
        );
      },
    ).whenComplete(() => cartController.selectedQuantity.value = 1);
  }
}
