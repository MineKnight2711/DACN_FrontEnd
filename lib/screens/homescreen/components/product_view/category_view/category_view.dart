import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddelivery_fe/controller/category_controller.dart';
import 'package:fooddelivery_fe/controller/dish_by_category_controller.dart';
import 'package:fooddelivery_fe/model/category_model.dart';
import 'package:fooddelivery_fe/screens/homescreen/components/product_view/dish_by_category_screen.dart';
import 'package:get/get.dart';

class CategoryList extends StatefulWidget {
  final List<CategoryModel>? categories;
  final CategoryController categoryController;
  final Function()? onDropDown;
  const CategoryList(
      {super.key,
      this.categories,
      required this.categoryController,
      this.onDropDown});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    with TickerProviderStateMixin<CategoryList> {
  bool _isDropDown = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    // _isDropDown = widget.categoryController.showAllCategories.value;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleDropdown() {
    _isDropDown = !_isDropDown;
    if (_isDropDown) {
      setState(() {
        _animationController.forward();
      });
    } else {
      _animationController.reverse().whenComplete(() => setState(() {}));
    }
    widget.onDropDown;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  toggleDropdown();
                  Future.delayed(
                    const Duration(milliseconds: 800),
                    () => widget.categoryController.toggleShowAllCategories(),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isDropDown ? tr("home.view_less") : tr("home.view_all"),
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
        Obx(() {
          final List<CategoryModel> categoryList =
              widget.categoryController.listCategory;
          List<CategoryModel> displayedCategories = [];
          if (categoryList.isNotEmpty) {
            if (categoryList.length >= 4) {
              displayedCategories =
                  widget.categoryController.showAllCategories.value
                      ? categoryList
                      : categoryList.sublist(0, 4);
            } else {
              displayedCategories = categoryList;
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 95.h,
                  child: Wrap(
                    spacing: 10.w,
                    // runSpacing: ,
                    children: List.generate(categoryList.sublist(0, 4).length,
                        (index) {
                      final CategoryModel item =
                          categoryList.sublist(0, 4)[index];
                      return CategoryItem(
                        onCategoryPressed: () {
                          _isDropDown = false;
                          _animationController
                              .reverse()
                              .whenComplete(() => setState(() {
                                    goToCategoryDishView(item);
                                  }));
                        },
                        categoryController: widget.categoryController,
                        categoryModel: item,
                      );
                    }),
                  ),
                ),
                SizeTransition(
                  sizeFactor: _animation,
                  // axisAlignment: -1,
                  child: _isDropDown
                      ? Container(
                          alignment: Alignment.topCenter,
                          height: widget.categoryController
                              .caculateSubCategoryListHeight(
                                  displayedCategories.length),
                          child: Wrap(
                            spacing: 10.w,
                            runSpacing: -30.h,
                            children: categoryList
                                .sublist(4, categoryList.length)
                                .map((categoryModel) => CategoryItem(
                                    onCategoryPressed: () {
                                      _isDropDown = false;
                                      _animationController
                                          .reverse()
                                          .whenComplete(() => setState(() {
                                                goToCategoryDishView(
                                                    categoryModel);
                                              }));
                                    },
                                    categoryModel: categoryModel,
                                    categoryController:
                                        widget.categoryController))
                                .toList(),
                          ),
                        )
                      : const Card(),
                ),
              ],
            );
          }
          return const Center(
              child: Padding(
            padding: EdgeInsets.all(32),
            child: Text("Không có danh mục :(("),
          ));
        }),
      ],
    );
  }

  void goToCategoryDishView(CategoryModel categoryModel) {
    widget.categoryController.onSelectCategory("${categoryModel.categoryID}");
    final controller = Get.put(DishByCategoryController());
    controller.loadDishByCategory("${categoryModel.categoryID}").whenComplete(
          () => Get.to(
            DishByCategoryScreen(categoryModel),
          ),
        );
    if (widget.categoryController.showAllCategories.value) {
      widget.categoryController.toggleShowAllCategories();
    }
  }
}

class CategoryItem extends StatelessWidget {
  final CategoryModel categoryModel;
  final CategoryController categoryController;
  final Function()? onCategoryPressed;
  const CategoryItem(
      {super.key,
      required this.categoryModel,
      required this.categoryController,
      this.onCategoryPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCategoryPressed,
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
                  color: categoryController.currentCategoryId.value ==
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
