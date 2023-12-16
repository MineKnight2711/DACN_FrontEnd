// ignore_for_file: use_build_context_synchronously
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/controller/dish_by_category_controller.dart';
import 'package:fooddelivery_fe/model/category_model.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/dish_view/dish_by_category_grid.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_widgets/custom_textfield.dart';
import 'package:fooddelivery_fe/widgets/no_glowing_scrollview.dart';
import 'package:get/get.dart';

class DishByCategoryScreen extends GetView {
  final CategoryModel categoryModel;
  final _controller = Get.find<DishByCategoryController>();

  DishByCategoryScreen(this.categoryModel, {super.key});

  Future<void> onRefresh() async {
    await _controller.loadDishByCategory("${categoryModel.categoryID}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPressed: () {
          Get.back();
          _controller.refresh();
          Get.delete<DishByCategoryController>();
        },
        title: '${categoryModel.categoryName}',
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: NoGlowingScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                RoundTextfield(
                  hintText: tr("dish_category.enter_something"),
                  controller: _controller.searchController,
                  onChanged: _controller.searchDishes,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(tr("exchange_voucher.sort_by")),
                    PopupMenuButton<SortBy>(
                      icon: Image.asset(
                        'assets/images/menu_icon.png',
                        color: Colors.black,
                        scale: 5.r,
                      ),
                      onSelected: (SortBy value) {
                        _controller.sortBy.value = value;
                        _controller.sortDishes();
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<SortBy>>[
                        PopupMenuItem<SortBy>(
                          value: SortBy.priceLowToHigh,
                          child: Text(tr("dish_category.sort_low_to_high")),
                        ),
                        PopupMenuItem<SortBy>(
                          value: SortBy.priceHighToLow,
                          child: Text(tr("dish_category.sort_high_to_low")),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Obx(() {
                  if (_controller.filteredDishes.isNotEmpty) {
                    return DishByCategoryGridView(
                        dishes: _controller.filteredDishes);
                  }
                  return const Center(
                    child: Text("NoDish"),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
