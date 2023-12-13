import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';

class DishByCategoryGridView extends StatelessWidget {
  final List<DishFavoriteCountDTO> dishes;

  const DishByCategoryGridView({super.key, required this.dishes});

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
                      // showModalBottomSheet(
                      //   context: context,
                      //   isScrollControlled: true,
                      //   shape: const RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.only(
                      //       topLeft: Radius.circular(20),
                      //       topRight: Radius.circular(20),
                      //     ),
                      //   ),
                      //   backgroundColor: Colors.white,
                      //   builder: (BuildContext context) {
                      //     return OrderDetailsBottomSheet(
                      //       dish: item,
                      //     );
                      //   },
                      // );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 80.h,
                          decoration: BoxDecoration(
                            color: AppColors.orange100,
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dishItem.dish.dishName,
                                style: CustomFonts.customGoogleFonts(
                                    fontSize: 16.r),
                              ),
                              Text(
                                DataConvert()
                                    .formatCurrency(dishItem.dish.price),
                                style: CustomFonts.customGoogleFonts(
                                    fontSize: 14.r),
                              ),
                            ],
                          ),
                        ),
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
}
