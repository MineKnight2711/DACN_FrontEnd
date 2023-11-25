import 'package:fooddelivery_fe/model/category_model.dart';

class DishModel {
  String dishID;
  String dishName;
  String description;
  int inStock;
  double price;
  String imageUrl;
  CategoryModel category;

  DishModel({
    required this.dishID,
    required this.dishName,
    required this.description,
    required this.inStock,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
  factory DishModel.fromJson(Map<String, dynamic> json) {
    return DishModel(
        dishID: json['dishID'] as String,
        dishName: json['dishName'] as String,
        description: json['description'] as String,
        price: json['price'] as double,
        inStock: json['inStock'] as int,
        imageUrl: json['imageUrl'] as String,
        category: CategoryModel.fromJson(json['category']));
  }
}
