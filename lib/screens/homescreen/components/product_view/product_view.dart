// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddelivery_fe/controller/category_controller.dart';
import 'package:fooddelivery_fe/model/category_model.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/category_view/category_view.dart';
import 'package:fooddelivery_fe/widgets/custom_textfield.dart';
import 'package:get/get.dart';

import 'dish_view/dish_view.dart';

class ProductView extends StatelessWidget {
  final CategoryController categoryController;
  ProductView({super.key, required this.categoryController});
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return true;
      },
      child: CustomScrollView(
        slivers: [
          Obx(
            () => BodyHeader(
              isExpanded: categoryController.showAllCategories.value,
              categoryController: categoryController,
              searchController: searchController,
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
                ListDishView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BodyHeader extends StatelessWidget {
  final bool isExpanded;
  final CategoryController categoryController;
  final TextEditingController searchController;

  const BodyHeader({
    super.key,
    required this.categoryController,
    required this.searchController,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final headerHeight = isExpanded
            ? ((categoryController.listCategory.value?.length) ?? 0) * 40.h
            : 0.3.sh;

        final isScrolledUnder = isExpanded
            ? (constraints.scrollOffset > headerHeight - 50)
            : (constraints.scrollOffset > headerHeight - 30);
        return SliverAppBar(
          expandedHeight: isExpanded
              ? ((categoryController.listCategory.value?.length) ?? 0) * 40.h
              : 0.3.sh,
          floating: false,
          backgroundColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            background: AnimatedOpacity(
              opacity: !isScrolledUnder ? 1 : 0,
              duration: const Duration(milliseconds: 1000),
              curve: const Cubic(0.2, 0.0, 0.0, 1.0),
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RoundTextfield(
                          icon: const Icon(Icons.search),
                          hintText: tr("home.search"),
                          controller: searchController),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tr("home.category"),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black26,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              categoryController.toggleShowAllCategories();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Obx(
                                  () => Text(
                                    tr(categoryController
                                            .showAllCategories.value
                                        ? "View Less"
                                        : "View All"),
                                    style: const TextStyle(
                                      color: Colors.orange,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                SvgPicture.asset(
                                    "assets/icons/arrow_right.svg"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      final List<CategoryModel>? categoryList =
                          categoryController.listCategory.value;
                      List<CategoryModel> displayedCategories = [];
                      if (categoryList != null && categoryList.isNotEmpty) {
                        if (categoryList.length >= 4) {
                          displayedCategories =
                              categoryController.showAllCategories.value
                                  ? categoryList
                                  : categoryList.sublist(0, 4);
                        } else {
                          displayedCategories = categoryList;
                        }
                        return CategoryList(
                            categories: displayedCategories,
                            categoryController: categoryController);
                      }
                      return const Center(
                          child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Text("Không có danh mục :(("),
                      ));
                    }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
