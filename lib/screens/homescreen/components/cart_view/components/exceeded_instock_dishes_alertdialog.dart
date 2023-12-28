import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_button.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';

class ExceededDishesDialog extends StatelessWidget {
  final List<DishModel> listExceededDish;
  const ExceededDishesDialog({super.key, required this.listExceededDish});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        "Danh sách các món hết hàng",
        style: CustomFonts.customGoogleFonts(fontSize: 14.r),
      ),
      content: SizedBox(
          height: 0.3.sh,
          width: 0.5.sw,
          child: NoGlowingScrollView(
              child: Column(
            children: listExceededDish
                .map((dish) => ListTile(
                      leading: SizedBox(
                        height: 30.h,
                        width: 20.w,
                        child: CircleAvatar(
                          radius: 20.r,
                          backgroundColor: Colors.red,
                          backgroundImage: Image.network(
                            "${dish.imageUrl}",
                          ).image,
                        ),
                      ),
                      title: Text(
                        dish.dishName,
                        style: CustomFonts.customGoogleFonts(fontSize: 12.r),
                      ),
                      trailing: Text(
                        "Còn lại : ${dish.inStock}",
                        style: CustomFonts.customGoogleFonts(fontSize: 12.r),
                      ),
                    ))
                .toList(),
          ))),
      actions: [
        Center(
            child: RoundIconButton(
          size: 50.r,
          onPressed: () => Get.back(),
          title: "OK",
        ))
      ],
    );
  }
}
