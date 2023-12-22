import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/controller/favorite_controller.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/dish_details_bottom_sheet.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/favorite_icon_button.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:get/get.dart';

class DishByCategoryGridView extends StatelessWidget {
  final List<DishFavoriteCountDTO> dishes;
  final favoriteController = Get.find<FavoriteController>();
  final cartController = Get.find<CartController>();
  DishByCategoryGridView({super.key, required this.dishes});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      height: 550.h,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.r,
          mainAxisSpacing: 5.h,
          crossAxisSpacing: 5.w,
          children: dishes
              .map(
                (dishItem) => Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  shadowColor: AppColors.dark50.withOpacity(1),
                  elevation: 5,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      _showBottomSheet(dishItem, context);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: Image.network(
                                "${dishItem.dish.imageUrl}",
                                scale: 0.5,
                                fit: BoxFit.cover,
                              ).image),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 5.0.w, horizontal: 5.w),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dishItem.dish.dishName,
                                        style: CustomFonts.customGoogleFonts(
                                            fontSize: 16.r),
                                      ),
                                      Text(
                                        DataConvert().formatCurrency(
                                            dishItem.dish.price),
                                        style: CustomFonts.customGoogleFonts(
                                            fontSize: 16.r),
                                      ),
                                    ],
                                  ),
                                ),
                                FavoriteIconButton(
                                  dishDTO: dishItem,
                                  favoriteController: favoriteController,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
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
