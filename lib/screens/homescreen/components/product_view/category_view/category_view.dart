import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/controller/category_controller.dart';
import 'package:fooddelivery_fe/model/category_model.dart';
import 'package:get/get.dart';

class CategoryList extends StatelessWidget {
  final List<CategoryModel>? categories;
  final CategoryController categeryController;
  const CategoryList(
      {super.key, this.categories, required this.categeryController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 16,
          runSpacing: -40,
          children: List.generate(categories!.length, (index) {
            final CategoryModel item = categories![index];
            return CategoryItem(
              categeryController: categeryController,
              categoryModel: item,
            );
          }),
        ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;
  final CategoryController categeryController;

  const CategoryItem(
      {super.key,
      required this.categoryModel,
      required this.categeryController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        categeryController.onSelectCategory("${categoryModel.categoryID}");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        width: 80.w,
        height: 90.h,
        child: Column(
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundColor: Colors.transparent,
              backgroundImage: Image.network(
                categoryModel.imageUrl.toString(),
              ).image,
            ),
            SizedBox(
              height: 8.w,
            ),
            Obx(
              () => Text(
                "${categoryModel.categoryName}",
                maxLines: 1,
                style: TextStyle(
                  color: categeryController.currentCategoryId.value ==
                          categoryModel.categoryID
                      ? const Color.fromARGB(255, 75, 75, 75)
                      : Colors.black26,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
