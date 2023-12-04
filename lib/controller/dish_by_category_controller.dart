import 'package:flutter/material.dart';
import 'package:fooddelivery_fe/api/dish/dish_api.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';
import 'package:fooddelivery_fe/utils/data_convert.dart';
import 'package:get/get.dart';

enum SortBy { priceLowToHigh, priceHighToLow }

class DishByCategoryController extends GetxController {
  late DishApi _dishApi;
  RxList<DishModel> dishes = <DishModel>[].obs;
  RxList<DishModel> filteredDishes = <DishModel>[].obs;

  Rx<SortBy> sortBy = SortBy.priceLowToHigh.obs;
  TextEditingController searchController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    _dishApi = DishApi();
  }

  @override
  void refresh() {
    super.refresh();
    _dishApi = DishApi();
    sortBy = SortBy.priceLowToHigh.obs;
    dishes.clear();
    filteredDishes.clear();
  }

  void sortDishes() {
    switch (sortBy.value) {
      case SortBy.priceLowToHigh:
        filteredDishes.sort((a, b) => (a.price).compareTo(b.price));
        break;
      case SortBy.priceHighToLow:
        filteredDishes.sort((a, b) => (b.price).compareTo(a.price));
        break;
    }
  }

  Future<void> loadDishByCategory(String categoryId) async {
    final response = await _dishApi.findDishByCategoryID(categoryId);
    if (response.message == "Success") {
      final dishesReceivedJson = response.data as List<dynamic>;

      dishes.value = filteredDishes.value =
          dishesReceivedJson.map((d) => DishModel.fromJson(d)).toList();
    }
  }

  String? searchDishes(String? query) {
    List<DishModel> searchDishes = [];
    // if (filteredDishes.isEmpty) {
    //   filteredDishes.value = dishes;
    //   return 'Không tìm thấy món :((';
    // }
    if (query == null || query == '') {
      filteredDishes.value = dishes;
      return null;
    } else {
      searchDishes = dishes.where((dish) {
        String dishName = dish.dishName.toString();
        //Bỏ dấu ở tên món và từ khoá tìm kiếm để tìm kiếm dễ dàng hơn
        String normalizedDishName =
            DataConvert().removeDiacritics(dishName.toLowerCase());
        String normalizedSearch =
            DataConvert().removeDiacritics(query.toLowerCase());
        return normalizedDishName.contains(normalizedSearch);
      }).toList();
      filteredDishes.value = searchDishes;
      if (filteredDishes.isEmpty) {
        filteredDishes.value = dishes;
        return 'Không tìm thấy món :((';
      }
      return 'Tìm thấy ${filteredDishes.length}';
    }
  }
}
