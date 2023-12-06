import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/model/favorite_model.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';

class FavoriteItem extends StatelessWidget {
  final FavoriteModel favorite;

  final Function() addToCartPressed;
  const FavoriteItem({
    super.key,
    required this.favorite,
    required this.addToCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      child: SizedBox(
          height: 120.h,
          child: InkWell(
            onTap: () {},
            child: Row(
              children: [
                Container(
                  width: 100.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 231, 179, 148),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.network(
                            "${favorite.dish?.imageUrl}",
                          ).image),
                      borderRadius: BorderRadius.circular(10)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${favorite.dish?.dishName}",
                        style: CustomFonts.customGoogleFonts(
                          fontSize: 15.r,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        DataConvert()
                            .formatCurrency(favorite.dish?.price ?? 0.0),
                        style: CustomFonts.customGoogleFonts(
                          fontSize: 13.r,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: addToCartPressed,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(7.w),
                    backgroundColor: AppColors.orange100,
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.add),
                )
              ],
            ),
          )),
    );
  }
}
