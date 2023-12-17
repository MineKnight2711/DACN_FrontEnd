import 'package:fooddelivery_fe/model/category_model.dart';
import 'package:intl/intl.dart';

class DishFavoriteCountDTO {
  DishModel dish;
  int favoriteCount;

  DishFavoriteCountDTO({required this.dish, required this.favoriteCount});

  factory DishFavoriteCountDTO.fromJson(Map<String, dynamic> json) {
    return DishFavoriteCountDTO(
      dish: DishModel.fromJson(json['dish']),
      favoriteCount: json['favoriteCount'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['dish'] = dish.toJson();
  //   data['favoriteCount'] = favoriteCount;
  //   return data;
  // }
}

class DishModel {
  String dishID;
  String dishName;
  String description;
  int inStock;
  double price;
  String? imageUrl;
  CategoryModel category;
  DateTime? dateCreate;

  DishModel({
    required this.dishID,
    required this.dishName,
    required this.description,
    required this.inStock,
    required this.price,
    this.imageUrl,
    required this.category,
    this.dateCreate,
  });
  factory DishModel.fromJson(Map<String, dynamic> json) {
    String? dateCreateJson = json['dateCreate'] as String?;
    return DishModel(
        dishID: json['dishID'] as String,
        dishName: json['dishName'] as String,
        description: json['description'] as String,
        price: json['price'] as double,
        inStock: json['inStock'] as int,
        imageUrl: json['imageUrl'] as String?,
        dateCreate: (dateCreateJson != "" && dateCreateJson != null)
            ? DateFormat('yyyy-MM-dd').parse(dateCreateJson)
            : null,
        category: CategoryModel.fromJson(json['category']));
  }
}
