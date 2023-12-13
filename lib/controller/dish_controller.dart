import 'package:fooddelivery_fe/api/dish/dish_api.dart';
import 'package:fooddelivery_fe/model/dish_model.dart';
import 'package:fooddelivery_fe/model/respone_base_model.dart';
import 'package:get/get.dart';

class DishController extends GetxController {
  late DishApi _dishApi;
  Rx<List<DishFavoriteCountDTO>> listDish = Rx<List<DishFavoriteCountDTO>>([]);
  @override
  void onInit() {
    super.onInit();
    _dishApi = DishApi();
    getAllDish();
  }

  Future<void> getAllDish() async {
    ResponseBaseModel? responseBaseModel = await _dishApi.getAllDish();
    if (responseBaseModel?.message == "Success") {
      final dishesReceived = responseBaseModel?.data as List<dynamic>;
      List<DishFavoriteCountDTO> dishList = dishesReceived
          .map(
            (dishMap) => DishFavoriteCountDTO.fromJson(dishMap),
          )
          .toList();
      listDish.value = dishList;
    }
  }
}
