// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddelivery_fe/config/colors.dart';
import 'package:fooddelivery_fe/config/mediquerry.dart';
import 'package:fooddelivery_fe/controller/cart_controller.dart';
import 'package:fooddelivery_fe/controller/category_controller.dart';
import 'package:fooddelivery_fe/controller/dish_controller.dart';
import 'package:fooddelivery_fe/model/category_model.dart';
import 'package:fooddelivery_fe/widgets/custom_message.dart';
import 'package:fooddelivery_fe/widgets/round_textfield.dart';
import 'package:get/get.dart';

class ProductView extends StatelessWidget {
  final CategoryController categoryController;
  ProductView({super.key, required this.categoryController});
  final TextEditingController searchController = TextEditingController();
  final outerScrollController = ScrollController().obs;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        controller: outerScrollController.value,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                            tr(categoryController.showAllCategories.value
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
                        SvgPicture.asset("assets/icons/arrow_right.svg"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
              }
              return const Center(
                  child: Padding(
                padding: EdgeInsets.all(32),
                child: Text("Không có danh mục :(("),
              ));
            }),
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
            ListDishView(outerScrollController: outerScrollController.value),
          ],
        ),
      ),
    );
  }
}

class ListDishView extends StatelessWidget {
  final ScrollController outerScrollController;
  ListDishView({super.key, required this.outerScrollController});
  final dishController = Get.find<DishController>();
  final cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: CustomMediaQuerry.mediaWidth(context, 1),
        height: CustomMediaQuerry.mediaHeight(context, 8) *
            (dishController.listDish.value.length),
        child: NotificationListener(onNotification: (notification) {
          if (notification is ScrollUpdateNotification &&
              notification.depth == 0 &&
              notification.metrics.extentBefore == 0) {
            outerScrollController.animateTo(0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut);
          }
          return true;
        }, child: Obx(
          () {
            if (dishController.listDish.value.isNotEmpty) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: dishController.listDish.value.length,
                itemBuilder: (context, index) {
                  final dish = dishController.listDish.value[index];
                  return Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: CustomMediaQuerry.mediaWidth(context, 1),
                    height: CustomMediaQuerry.mediaHeight(context, 8),
                    // color: Colors.blueGrey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 15.w),
                        Container(
                          width: 85.w,
                          height: CustomMediaQuerry.mediaHeight(context, 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                dish.imageUrl,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dish.dishName,
                              style: const TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              "${dish.price}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              dish.description,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: FloatingActionButton(
                            onPressed: () async {
                              if (await showConfirmDialog(
                                  context,
                                  "Thêm ${dish.dishName}",
                                  "Bạn có muốn thêm ${dish.dishName} vào giỏ hàng ?")) {
                                String? result =
                                    await cartController.addToCart(dish, 1);
                                switch (result) {
                                  case "Success":
                                    showCustomSnackBar(
                                        context,
                                        "Thông báo",
                                        "Thêm vào giỏ hàng thành công",
                                        ContentType.success);
                                    break;
                                  case "UpdatedCart":
                                    showCustomSnackBar(
                                        context,
                                        "Thông báo",
                                        "Cập nhật giỏ hàng thành công",
                                        ContentType.help);
                                    break;
                                  case "NoAccount":
                                    showCustomSnackBar(
                                        context,
                                        "Lỗi",
                                        "Phiên đăng nhập không hợp lệ",
                                        ContentType.failure);
                                    break;
                                  default:
                                    showCustomSnackBar(
                                        context,
                                        "Lỗi",
                                        "Lỗi chưa xác định: $result",
                                        ContentType.failure);
                                    break;
                                }
                              }
                            },
                            backgroundColor: AppColors.orange100,
                            mini: true,
                            child: const Icon(Icons.add),
                          ),
                        ),
                        SizedBox(width: 20.w),
                      ],
                    ),
                  );
                },
              );
            }
            return const Text("Không có món ăn");
          },
        )),
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
      onTap: () =>
          categeryController.onSelectCategory("${categoryModel.categoryID}"),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        width: 80.w,
        height: 90.h,
        child: Column(
          children: [
            CircleAvatar(
              radius: 32.r,
              backgroundColor: Colors.transparent,
              backgroundImage: CachedNetworkImageProvider(
                categoryModel.imageUrl.toString(),
              ),
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
                  fontSize: 9.5.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
