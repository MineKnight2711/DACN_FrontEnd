import 'package:fooddelivery_fe/api/category/category_api.dart';
import 'package:fooddelivery_fe/model/category_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  late CategoryApi categoryApi;
  Rx<List<CategoryModel>?> listCategory = Rx<List<CategoryModel>?>([]);
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

  void toggleShowAllCategories() async {
    showAllCategories.toggle();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  void onSelectCategory(String id) async {
    currentCategoryId(id);
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
