// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/controller/dish_by_category_controller.dart';
import 'package:fooddelivery_fe/model/category_model.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/dish_view/dish_by_category_grid.dart';
import 'package:fooddelivery_fe/widgets/custom_appbar.dart';
import 'package:fooddelivery_fe/widgets/custom_textfield.dart';
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
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              RoundTextfield(
                hintText: "Nhập gì đó đi...",
                controller: _controller.searchController,
                onChanged: _controller.searchDishes,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Xếp theo'),
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
                      const PopupMenuItem<SortBy>(
                        value: SortBy.priceLowToHigh,
                        child: Text('Giá: Thấp đến cao'),
                      ),
                      const PopupMenuItem<SortBy>(
                        value: SortBy.priceHighToLow,
                        child: Text('Giá: Cao đến thấp'),
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
    );
  }
}
