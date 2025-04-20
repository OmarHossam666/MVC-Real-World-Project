import 'dart:convert';

import 'package:america/utils/TextUtils.dart';

GiftsModel giftsModelFromJson(String str) =>
    GiftsModel.fromJson(json.decode(str));

String giftsModelToJson(GiftsModel data) => json.encode(data.toJson());

class GiftsModel {
  List<Gift>? gifts;

  GiftsModel({
    this.gifts,
  });

  factory GiftsModel.fromJson(Map<String, dynamic> json) => GiftsModel(
        gifts: json["gifts"] == null
            ? []
            : List<Gift>.from(json["gifts"]!.map((x) => Gift.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "gifts": gifts == null
            ? []
            : List<dynamic>.from(gifts!.map((x) => x.toJson())),
      };
}

class Gift {
  int? id;
  String? name;
  String? tenantId;
  String? status;
  String? price;
  DateTime? startAt;
  DateTime? endAt;
  String? timeWhenClipped;
  String? barcode;
  String? barcodeNumber;
  dynamic clippedAt;
  int? userId;
  int? storeId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Gift({
    this.id,
    this.name,
    this.tenantId,
    this.status,
    this.price,
    this.startAt,
    this.endAt,
    this.timeWhenClipped,
    this.barcode,
    this.barcodeNumber,
    this.clippedAt,
    this.userId,
    this.storeId,
    this.createdAt,
    this.updatedAt,
  });

  factory Gift.fromJson(Map<String, dynamic> json) => Gift(
        id: json["id"],
        name: json["name"],
        tenantId: json["tenant_id"],
        status: json["status"],
        price: json["price"],
        startAt:
            json["start_at"] == null ? null : DateTime.parse(json["start_at"]),
        endAt: json["end_at"] == null ? null : DateTime.parse(json["end_at"]),
        timeWhenClipped: json["time_when_clipped"],
        barcode: TextUtils.getImageUrl(json['barcode'].toString()),
        barcodeNumber: json["barcode_number"],
        clippedAt: json["clipped_at"],
        userId: json["user_id"],
        storeId: json["store_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tenant_id": tenantId,
        "status": status,
        "price": price,
        "start_at": startAt?.toIso8601String(),
        "end_at": endAt?.toIso8601String(),
        "time_when_clipped": timeWhenClipped,
        "barcode": barcode,
        "barcode_number": barcodeNumber,
        "clipped_at": clippedAt,
        "user_id": userId,
        "store_id": storeId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
