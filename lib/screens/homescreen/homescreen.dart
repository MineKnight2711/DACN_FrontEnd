import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fooddelivery_fe/controller/category_Controller.dart';
import 'package:fooddelivery_fe/controller/login_controller.dart';
import 'package:fooddelivery_fe/model/account_model.dart';
import 'package:fooddelivery_fe/model/category_model.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/homescreen_appbar.dart';

import 'package:get/get.dart';

import '../../config/mediquerry.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final AccountModel? accountModel;

  HomeScreen({super.key, this.accountModel});
  final loginController = Get.put(LoginController());
  final categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomHomeAppBar(scaffoldKey: scaffoldKey),
      endDrawer:
          CustomHomeAppBar(scaffoldKey: scaffoldKey).buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Obx(() {
              final List<CategoryModel>? categoryList =
                  categoryController.listCategory.value;
              if (categoryList != null && categoryList.isNotEmpty) {
                List<CategoryModel> displayedCategories =
                    categoryController.showAllCategories.value
                        ? categoryList
                        : categoryList.sublist(0, 4);

                return CategoryList(
                    categories: displayedCategories,
                    categeryController: categoryController);
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  final List<CategoryModel>? categories;
  final CategoryController categeryController;
  const CategoryList(
      {super.key, this.categories, required this.categeryController});

  @override
  Widget build(BuildContext context) {
    double containerHeight = categories!.length * 30.0;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr("Category"),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black26,
                ),
              ),
              GestureDetector(
                onTap: () {
                  categeryController.toggleShowAllCategories();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tr(categeryController.showAllCategories.value
                          ? "View Less"
                          : "View All"),
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset("assets/icons/arrow_right.svg"),
                  ],
                ),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: containerHeight,
          child: Wrap(
            spacing: 16,
            runSpacing: -40,
            children: List.generate(categories!.length, (index) {
              final CategoryModel item = categories![index];
              return CategryItem(
                categeryController: categeryController,
                categoryModel: item,
              );
            }),
          ),
        ),
      ],
    );
  }
}

class CategryItem extends StatelessWidget {
  final CategoryModel categoryModel;
  final CategoryController categeryController;

  const CategryItem(
      {super.key,
      required this.categoryModel,
      required this.categeryController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          categeryController.onSelectCategory("${categoryModel.categoryID}"),
      child: Container(
        margin: const EdgeInsets.only(bottom: 70),
        width: CustomMediaQuerry.mediaWidth(context, 5),
        height: CustomMediaQuerry.mediaHeight(context, 8),
        child: Column(
          children: [
            SizedBox(
              height: CustomMediaQuerry.mediaHeight(context, 10),
              width: CustomMediaQuerry.mediaWidth(context, 6),
              child: CachedNetworkImage(
                imageUrl: categoryModel.imageUrl.toString(),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(bottom: 4),
                child: Obx(
                  () => Text(
                    "${categoryModel.categoryName}",
                    maxLines: 1,
                    style: TextStyle(
                      color: categeryController.currentCategoryId.value ==
                              categoryModel.categoryID
                          ? const Color.fromARGB(255, 75, 75, 75)
                          : Colors.black26,
                      fontWeight: FontWeight.w500,
                      fontSize: 9.5.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
