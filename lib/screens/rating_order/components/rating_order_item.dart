import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/rating_order_controller.dart';
import 'package:fooddelivery_fe/model/order_model.dart';
import 'package:fooddelivery_fe/screens/order_screen/compinent/list_details_dishes.dart';
import 'package:fooddelivery_fe/screens/rating_order/components/rating_bar_row.dart';
import 'package:fooddelivery_fe/screens/rating_order/components/rating_order_bottom_sheet.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';

class RatingOrderItem extends StatelessWidget {
  final OrderDetailsDTO order;
  final RatingOrderController ratingOrderController;
  const RatingOrderItem({
    super.key,
    required this.ratingOrderController,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.22.sh,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      margin: EdgeInsets.only(top: 5.h),
      child: Card(
        elevation: 2,
        shadowColor: Colors.grey.withOpacity(1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text(
                  "Mã đơn hàng",
                  style: CustomFonts.customGoogleFonts(
                      fontSize: 14.r, color: AppColors.gray50),
                ),
                const Spacer(),
                Text(
                  DataConvert().formattedOrderDate(order.order?.orderDate),
                  style: CustomFonts.customGoogleFonts(
                      fontSize: 14.r, color: AppColors.gray50),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "${order.order?.orderID}",
              style: CustomFonts.customGoogleFonts(
                  fontSize: 16.r, color: AppColors.dark100),
            ),
            SizedBox(
              height: 5.h,
            ),
            ListDetailsDishes(
              detailList: order.detailList,
            ),
            SizedBox(
              height: 5.h,
            ),
            Divider(
              endIndent: 5.w,
              indent: 5.w,
              color: AppColors.dark100,
              thickness: 0.2.w,
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              width: 300.w,
              child: RatingBarRow(
                minRating: 0,
                onRatingUpdate: (p0) {},
                enable: false,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    builder: (BuildContext context) {
                      return ReviewOrderBottomSheet(
                        ratingOrderController: ratingOrderController,
                        orderDetails: order,
                      );
                    },
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
