// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/font.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/controller/dish_controller.dart';
import 'package:fooddelivery_fe/controller/favorite_controller.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/components/dish_view/dish_item.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_textfield.dart';
import 'package:fooddelivery_fe/widgets/empty_widget.dart';
import 'package:get/get.dart';

class DishSearchScreen extends StatelessWidget {
  final dishController = Get.find<DishController>();
  final favoriteController = Get.find<FavoriteController>();
  final cartController = Get.find<CartController>();
  final TextEditingController txtSearchDish;
  DishSearchScreen({super.key, required this.txtSearchDish});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true, //Treo như 1 header
              floating: true,
              expandedHeight: 100.h,
              centerTitle: true,
              backgroundColor: AppColors.orange100,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              title: Text(
                "Tìm món",
                style: CustomFonts.customGoogleFonts(
                    fontSize: 16.r, color: AppColors.white100),
              ),

              bottom: PreferredSize(
                preferredSize: Size(1.sw, 72.8.h),
                child: Container(
                  width: 0.9.sw,
                  height: 0.065.sh,
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  child: Hero(
                    tag: "searchTextField",
                    child: Material(
                      type: MaterialType.transparency,
                      child: RoundTextfield(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        hintText: tr("home.search"),
                        controller: txtSearchDish,
                        onChanged: (dishName) {
                          dishController.searchDish(dishName ?? '');
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tr("home.top_food"),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black26,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    if (dishController.listSearchDish.isNotEmpty) {
                      return Column(
                        children: dishController.listSearchDish
                            .map((dishItem) => DishItem(dishItem: dishItem))
                            .toList(),
                      );
                    }
                    return const EmptyWidget(
                      assetsAnimations: "cat_sleep",
                      tilte: "Không tìm thấy món nào..",
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
