// To parse this JSON data, do
//
//     final storesModel = storesModelFromJson(jsonString);

import 'dart:convert';
import 'dart:developer';

import 'package:america/utils/TextUtils.dart';

StoresModel storesModelFromJson(String str) =>
    StoresModel.fromJson(json.decode(str));

String storesModelToJson(StoresModel data) => json.encode(data.toJson());

class StoresModel {
  List<Store>? stores;

  StoresModel({
    this.stores,
  });

  factory StoresModel.fromJson(Map<String, dynamic> json) {
    log("here :  $json");
    return StoresModel(
      stores: json["stores"] == null
          ? []
          : List<Store>.from(json["stores"]!.map((x) => Store.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "stores": stores == null
            ? []
            : List<dynamic>.from(stores!.map((x) => x.toJson())),
      };
}

class Store {
  int? id;
  String? name;
  String? nameOfManager;
  String? email;
  String? password;
  String? phone;
  String? photo;
  String? address;
  int? activate;
  String? tenantId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Store({
    this.id,
    this.name,
    this.nameOfManager,
    this.email,
    this.password,
    this.phone,
    this.photo,
    this.address,
    this.activate,
    this.tenantId,
    this.createdAt,
    this.updatedAt,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        nameOfManager: json["name_of_manager"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        photo: TextUtils.getImageUrl(json["photo"] ?? ""),
        address: json["address"],
        activate: json["activate"],
        tenantId: json["tenant_id"],
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
        "name_of_manager": nameOfManager,
        "email": email,
        "password": password,
        "phone": phone,
        "photo": photo,
        "address": address,
        "activate": activate,
        "tenant_id": tenantId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
