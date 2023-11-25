import 'package:fooddelivery_fe/api/dish/dish_api.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:get/get.dart';

class DishController extends GetxController {
  late DishApi _dishApi;
  Rx<List<DishModel>> listDish = Rx<List<DishModel>>([]);
  @override
  void onInit() {
    super.onInit();
    _dishApi = DishApi();
    getAllCategory();
  }

  Future<void> getAllCategory() async {
    ResponseBaseModel? responseBaseModel = await _dishApi.getAllDish();
    if (responseBaseModel?.message == "Success") {
      final categoryReceived = responseBaseModel?.data as List<dynamic>;
      List<DishModel> dishList = categoryReceived
          .map(
            (dishMap) => DishModel.fromJson(dishMap),
          )
          .toList();
      listDish.value = dishList;
    }
  }
}
