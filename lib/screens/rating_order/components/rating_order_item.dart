import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/rating_order_controller.dart';
import 'package:fooddelivery_fe/model/order_model.dart';
import 'package:fooddelivery_fe/screens/order_screen/components/list_details_dishes.dart';
import 'package:fooddelivery_fe/screens/order_screen/components/order_details_bottom_sheet.dart';
import 'package:fooddelivery_fe/screens/rating_order/components/rating_bar_row.dart';
import 'package:fooddelivery_fe/screens/rating_order/components/rating_order_bottom_sheet.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:fooddelivery_fe/widgets/rating_bar.dart';

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
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
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
              builder: (context) {
                return DraggableScrollableSheet(
                  initialChildSize: 0.8, //Kích cỡ sheet khi vừa hiện lên
                  minChildSize:
                      0.3, //Khi ta kéo sheet về 0.3 chiều cao của nó, nó sẽ đóng
                  maxChildSize:
                      0.95, //Chiều cao tối đa của sheet được phép kéo lên
                  expand: false,
                  builder: (context, scrollController) {
                    return NoGlowingScrollView(
                      scrollController: scrollController,
                      child: OrderDetailsBottomSheet(
                        scrollController: scrollController,
                        orderDetails: order,
                      ),
                    );
                  },
                );
              },
            );
          },
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
              order.order?.status != "Đã đánh giá"
                  ? SizedBox(
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
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ShowRatingBar(
                              size: 25.w, rating: order.order?.score ?? 0.0),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            "${order.order?.score}",
                            style:
                                CustomFonts.customGoogleFonts(fontSize: 16.r),
                          )
                        ],
                      ),
                    ),
            ]),
          ),
        ),
      ),
    );
  }
}
