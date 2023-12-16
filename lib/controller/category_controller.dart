import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fooddelivery_fe/api/category/category_api.dart';
import 'package:fooddelivery_fe/model/category_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  late CategoryApi categoryApi;
  RxList<CategoryModel> listCategory = <CategoryModel>[].obs;
  final RxBool showAllCategories = false.obs;
  final RxString currentCategoryId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    categoryApi = CategoryApi();
    getAllCategory();
  }

  Future<void> getAllCategory() async {
    ResponseBaseModel? responseBaseModel = await categoryApi.getAllCategory();
    if (responseBaseModel?.message == "Success") {
      final categoryReceived = responseBaseModel?.data as List<dynamic>;
      List<CategoryModel> categoriesList = categoryReceived
          .map(
            (categoryMap) => CategoryModel.fromJson(categoryMap),
          )
          .toList();
      listCategory.value = categoriesList;
    }
  }

  double caculateSubCategoryListHeight(int categoryNum) {
    double itemHeight = 90.h + 30;

    int numItems = categoryNum;
    int rows = 1;
    if (numItems > 4) {
      rows = ((numItems - 4) / 4).ceil();
    }

    return rows * itemHeight;
  }

  double calculateCategoryListHeight() {
    final double itemHeight = 135.h;
    const int itemsPerRow = 4;
    int numberOfRows = 1;
    if (listCategory.isNotEmpty && listCategory.length > 4) {
      numberOfRows = (listCategory.length / itemsPerRow).ceil();
    }

    return itemHeight * numberOfRows;
  }

  void toggleShowAllCategories() async {
    showAllCategories.toggle();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void onSelectCategory(String id) async {
    currentCategoryId(id);
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
