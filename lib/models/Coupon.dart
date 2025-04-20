import 'dart:convert';

import 'package:america/utils/TextUtils.dart';

class Coupon {
  int? id;
  String? name;
  String? description;
  String? terms;
  String? photo;
  String? price;
  String? priceAfterDiscount;
  String? save_price;
  String? start_at;
  String? end_at;
  dynamic? timeWhenClipped;
  String? barcode;

  Coupon(
      this.id,
      this.name,
      this.photo,
      this.description,
      this.timeWhenClipped,
      this.terms,
      this.price,
      this.priceAfterDiscount,
      this.save_price,
      this.start_at,
      this.end_at,
      this.barcode);

  static fromJson(Map<String, dynamic> jsonObject) {
    int id = int.parse(jsonObject['id'].toString());

    String name = jsonObject['name'].toString();
    String description = jsonObject['description'].toString();
    String terms = jsonObject['terms'].toString();
    String start_at = jsonObject['start_at'].toString();
    String end_at = jsonObject['end_at'].toString();
    String timeWhenClipped = jsonObject['time_when_clipped'].toString();
    String photo = TextUtils.getImageUrl(jsonObject['photo'].toString());
    String barcode = TextUtils.getImageUrl(jsonObject['barcode'].toString());
    String price = jsonObject['price'].toString();
    String priceAfterDiscount = jsonObject['price_after_discount'].toString();
    String save_price = jsonObject['save_price'].toString();

    return Coupon(id, name, photo, description, timeWhenClipped, terms, price,
        priceAfterDiscount, save_price, start_at, end_at, barcode);
  }

  static List<Coupon> getListFromJson(List<dynamic> jsonArray) {
    List<Coupon> list = [];
    for (int i = 0; i < jsonArray.length; i++) {
      list.add(Coupon.fromJson(jsonArray[i]));
    }
    return list;
  }

  @override
  String toString() {
    return 'Coupon{id: $id, name: $name, photo: $photo,price:$price,priceAfterDiscount:$priceAfterDiscount,start_at:$start_at,end_at:$end_at,barcode:$barcode,description:$description,terms:$terms}';
  }
}

// To parse this JSON data, do
//
//     final clippedCoupons = clippedCouponsFromMap(jsonString);

// To parse this JSON data, do
//
//     final clippedCoupons = clippedCouponsFromMap(jsonString);

List<ClippedCoupons> clippedCouponsFromMap(String str) =>
    List<ClippedCoupons>.from(
        json.decode(str).map((x) => ClippedCoupons.fromMap(x)));

String clippedCouponsToMap(List<ClippedCoupons> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ClippedCoupons {
  final int? id;
  final String? name;
  final String? tenantId;
  final String? description;
  final String? terms;
  final String? photo;
  final dynamic? price;
  final dynamic? priceAfterDiscount;
  final String? status;
  final String? startAt;
  final String? endAt;
  final String? timeWhenClipped;
  final String? barcode;
  final dynamic bardcodeNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ClippedCoupons({
    this.id,
    this.name,
    this.tenantId,
    this.description,
    this.terms,
    this.photo,
    this.price,
    this.priceAfterDiscount,
    this.status,
    this.startAt,
    this.endAt,
    this.timeWhenClipped,
    this.barcode,
    this.bardcodeNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory ClippedCoupons.fromMap(Map<String, dynamic> json) => ClippedCoupons(
        id: json["id"],
        name: json["name"],
        tenantId: json["tenant_id"],
        description: json["description"],
        terms: json["terms"],
        photo: TextUtils.getImageUrl(json['photo'].toString()),
        price: json["price"].toString(),
        priceAfterDiscount: json["price_after_discount"].toString(),
        status: json["status"],
        startAt: json["start_at"].toString(),
        endAt: json["end_at"].toString(),
        timeWhenClipped: json["time_when_clipped"],
        bardcodeNumber: json["barcode_number"].toString(),
        barcode: TextUtils.getImageUrl(json['barcode'].toString()),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "tenant_id": tenantId,
        "description": description,
        "terms": terms,
        "photo": photo,
        "price": price,
        "price_after_discount": priceAfterDiscount,
        "status": status,
        "time_when_clipped": timeWhenClipped,
        "barcode": barcode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
