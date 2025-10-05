// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);


import 'package:america/models/Product.dart';
import 'package:america/utils/TextUtils.dart';

CategoryModel categoryModelFromJson(str) => CategoryModel.fromJson(str);

class CategoryModel {
  List<Category>? categories;

  CategoryModel({
    this.categories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
      );
}

class Category {
  int? id;
  String? name;
  String? photo;
  String? tenantId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Product>? products;

  Category({
    this.id,
    this.name,
    this.photo,
    this.tenantId,
    this.createdAt,
    this.updatedAt,
    this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        photo: TextUtils.getImageUrl(json['photo'].toString()),
        tenantId: json["tenant_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );
}
