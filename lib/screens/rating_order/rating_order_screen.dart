import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/rating_order_controller.dart';
import 'package:fooddelivery_fe/screens/rating_order/components/rating_order_item.dart';
import 'package:fooddelivery_fe/screens/rating_order/components/rating_order_tabbar_controller.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/empty_widget.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingOrderScreen extends GetView {
  final ratingOrderController = Get.find<RatingOrderController>();
  final tabBarController = Get.put(RatingOrderTabbarController());
  RatingOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Get.back();
        },
        title: tr("order_rate_screen.appbar.order_review_text"),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              controller: tabBarController.tabController.value,
              splashBorderRadius: BorderRadius.circular(30),
              labelStyle: CustomFonts.customGoogleFonts(fontSize: 14.r),
              unselectedLabelStyle:
                  CustomFonts.customGoogleFonts(fontSize: 12.r),
              labelColor: AppColors.orange100,
              unselectedLabelColor: AppColors.dark50,
              indicatorColor: Colors.transparent,
              tabs: tabBarController.tabs
                  .map(
                    (tab) => Container(
                      alignment: Alignment.center,
                      height: 35.h,
                      child: Text(
                        tab,
                        style: GoogleFonts.roboto(fontSize: 12.r),
                      ),
                    ),
                  )
                  .toList(),
              indicatorPadding: EdgeInsets.symmetric(horizontal: 5.w),
              padding: EdgeInsets.all(5.w),
            ),
            SizedBox(
                height: 0.85.sh,
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: tabBarController.tabController.value,
                  children: [
                    Obx(() {
                      if (ratingOrderController.listCompleteOrder.isNotEmpty) {
                        return NoGlowingScrollView(
                          child: Column(
                            children: ratingOrderController.listCompleteOrder
                                .map(
                                  (order) => RatingOrderItem(
                                      order: order,
                                      ratingOrderController:
                                          ratingOrderController),
                                )
                                .toList(),
                          ),
                        );
                      }
                      return const EmptyWidget(
                        assetsAnimations: "cat_sleep",
                        tilte: "Chưa có đơn hàng..",
                      );
                    }),
                    Obx(() {
                      if (ratingOrderController.listRatedOrder.isNotEmpty) {
                        return Column(
                          children: ratingOrderController.listRatedOrder
                              .map((order) => RatingOrderItem(
                                  order: order,
                                  ratingOrderController: ratingOrderController))
                              .toList(),
                        );
                      }
                      return const EmptyWidget(
                        assetsAnimations: "cat_sleep",
                        tilte: "Chưa có đơn hàng..",
                      );
                    }),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
