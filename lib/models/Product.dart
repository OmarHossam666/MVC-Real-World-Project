import 'package:america/utils/TextUtils.dart';

class Product {
  int? id;
  String name;
  String photo;
  String price;
  String after_price;
  String start_at;
  String end_at;

  Product(
    this.id,
    this.name,
    this.photo,
    this.price,
    this.after_price,
    this.start_at,
    this.end_at,
  );

  static fromJson(Map<String, dynamic> jsonObject) {
    int id = int.parse(jsonObject['id'].toString());

    String name = jsonObject['name'].toString();

    String startAt = jsonObject['start_at'].toString();
    String endAt = jsonObject['end_at'].toString();
    String photo = TextUtils.getImageUrl(jsonObject['photo'].toString());
    String price = jsonObject['price'].toString();
    String afterPrice = jsonObject['after_price'].toString();

    return Product(id, name, photo, price, afterPrice, startAt, endAt);
  }

  static List<Product> getListFromJson(List<dynamic> jsonArray) {
    List<Product> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(Product.fromJson(jsonArray[i]));
    }
    return list;
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, photo: $photo,price:$price,start_at:$start_at,end_at:$end_at}';
  }
}
