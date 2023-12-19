import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/model/cart_model.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';

class OrderItems extends StatelessWidget {
  final List<CartModel> listItem;
  final double listHeight;
  const OrderItems(
      {super.key, required this.listItem, required this.listHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: listHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.dark100,
          width: 1,
        ),
      ),
      child: listItem.isNotEmpty
          ? NoGlowingScrollView(
              child: Column(
                children: listItem
                    .map(
                      (item) => Column(
                        children: [
                          SizedBox(
                            height: 55.h,
                            child: ListTile(
                              leading: Image.network(
                                "${item.dish?.imageUrl}",
                              ),
                              title: Text(
                                "${item.quantity}x ${item.dish?.dishName}",
                                style: CustomFonts.customGoogleFonts(
                                    fontSize: 14.r),
                              ),
                              subtitle: Text(
                                "${item.dish?.category.categoryName}",
                                style: CustomFonts.customGoogleFonts(
                                    fontSize: 12.r),
                              ),
                              trailing: Text(
                                DataConvert().formatCurrency(
                                    double.parse("${item.quantity}") *
                                        double.parse("${item.dish?.price}")),
                                style: CustomFonts.customGoogleFonts(
                                    fontSize: 12.r),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Divider(
                            height: 15.h,
                            indent: 15.w,
                            endIndent: 15.w,
                            color: AppColors.gray100,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
