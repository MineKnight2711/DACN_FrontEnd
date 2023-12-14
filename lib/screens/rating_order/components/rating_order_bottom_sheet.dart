// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/rating_order_controller.dart';
import 'package:fooddelivery_fe/model/order_model.dart';
import 'package:fooddelivery_fe/screens/rating_order/components/rating_bar_row.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:fooddelivery_fe/utils/transition_animation.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_button.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_message.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';

class ReviewOrderBottomSheet extends StatelessWidget {
  final OrderDetailsDTO orderDetails;
  final RatingOrderController ratingOrderController;
  const ReviewOrderBottomSheet(
      {super.key,
      required this.orderDetails,
      required this.ratingOrderController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.97.sh,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BottomSheetHeader(),
          Divider(
            height: 30.h,
            thickness: 3.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mã đơn hàng",
                  textAlign: TextAlign.center,
                  style: CustomFonts.customGoogleFonts(
                    fontSize: 14.r,
                    color: AppColors.gray100,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "${orderDetails.order?.orderID}",
                  textAlign: TextAlign.center,
                  style: CustomFonts.customGoogleFonts(
                    fontSize: 16.r,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 30.h,
            thickness: 3.h,
          ),
          RatingBarRow(
            minRating: 1,
            enable: true,
            onRatingUpdate: ratingOrderController.scoreChanging,
          ),
          Divider(
            height: 30.h,
            thickness: 0.3.h,
            color: AppColors.dark100,
          ),
          Center(
            child: Obx(
              () => Text(
                ratingOrderController
                    .scoreChangingResult(ratingOrderController.score.value)
                    .value,
                textAlign: TextAlign.center,
                style: CustomFonts.customGoogleFonts(fontSize: 15.r),
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          FeedBackTextField(
            hintText: "Hãy cho chúng tôi biết suy nghĩ của bạn....",
            controller: ratingOrderController.feedBackController,
          ),
          Divider(
            height: 10.h,
            thickness: 3.h,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Các sản phẩm đã đặt",
              textAlign: TextAlign.center,
              style: CustomFonts.customGoogleFonts(
                fontSize: 14.r,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          orderDetails.detailList != null
              ? SizedBox(
                  height: 0.25.sh,
                  child: Container(
                    margin: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5.w),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: NoGlowingScrollView(
                      child: Column(
                        children: orderDetails.detailList!
                            .map((details) => Column(
                                  children: [
                                    ListTile(
                                      leading: Padding(
                                        padding: EdgeInsets.only(top: 2.5.h),
                                        child: Text(
                                          "${(details.price ?? 0) ~/ double.parse("${details.dish?.price}")}x",
                                          style: CustomFonts.customGoogleFonts(
                                              fontSize: 14.r),
                                        ),
                                      ),
                                      title: Text(
                                        "${details.dish?.dishName}",
                                        style: CustomFonts.customGoogleFonts(
                                            fontSize: 14.r),
                                      ),
                                      trailing: Text(
                                          DataConvert().formatCurrency(
                                              details.price ?? 0.0),
                                          style: CustomFonts.customGoogleFonts(
                                              fontSize: 14.r)),
                                    ),
                                    Divider(
                                      height: 1.h,
                                      indent: 10.w,
                                      thickness: 1.h,
                                    )
                                  ],
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                )
              : const Card(),
          Align(
            alignment: Alignment.center,
            child: RoundIconButton(
              size: 80.w,
              title: "Gửi đánh giá",
              onPressed: () async {
                showLoadingAnimation(
                    context, "assets/animations/loading.json", 180);
                final result = await ratingOrderController
                    .rateOrder("${orderDetails.order?.orderID}")
                    .whenComplete(() => Get.back());
                if (result == "Success") {
                  Get.back();
                  showCustomSnackBar(context, "Thông báo",
                      "Đã đánh giá đơn hàng", ContentType.success, 2);
                  ratingOrderController.refresh();
                } else {
                  Get.back();
                  showCustomSnackBar(
                      context,
                      "Thông báo",
                      "Có lỗi xảy ra\nChi tiết :$result",
                      ContentType.failure,
                      2);
                  ratingOrderController.refresh();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class FeedBackTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  const FeedBackTextField(
      {super.key, required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      child: TextField(
        controller: controller,
        maxLines: 6,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.gray50,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          focusColor: AppColors.dark100,
          hintText: hintText,
          hintStyle: CustomFonts.customGoogleFonts(
              fontSize: 15.r, color: AppColors.gray50),
        ),
        style: CustomFonts.customGoogleFonts(fontSize: 15.r),
        maxLength: 500,
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
      ),
    );
  }
}

class BottomSheetHeader extends StatelessWidget {
  const BottomSheetHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5.h),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10.h),
            child: Text(
              "Đánh giá đơn hàng",
              textAlign: TextAlign.center,
              style: CustomFonts.customGoogleFonts(fontSize: 16.r),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
