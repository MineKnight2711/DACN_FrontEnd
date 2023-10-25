class CategoryModel {
  String? categoryID;
  String? categoryName;
  String? imageUrl;
  CategoryModel({
    this.categoryID,
    this.categoryName,
    this.imageUrl,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryID: json['categoryID'],
      categoryName: json['categoryName'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryID': categoryID,
      'categoryName': categoryName,
      'imageUrl': imageUrl,
    };
  }
}
