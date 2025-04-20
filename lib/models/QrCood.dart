// To parse this JSON data, do
//
//     final qrModel = qrModelFromMap(jsonString);

import 'dart:convert';

QrModel qrModelFromMap(String str) => QrModel.fromMap(json.decode(str));

String qrModelToMap(QrModel data) => json.encode(data.toMap());

class QrModel {
    final List<QrImage>? social;

    QrModel({
        this.social,
    });

    factory QrModel.fromMap(Map<String, dynamic> json) => QrModel(
        social: json["social"] == null ? [] : List<QrImage>.from(json["social"]!.map((x) => QrImage.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "social": social == null ? [] : List<dynamic>.from(social!.map((x) => x.toMap())),
    };
}

class QrImage {
    final int? id;
    final String? photo;
    final String? link;
    final String? tenantId;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    QrImage({
        this.id,
        this.photo,
        this.link,
        this.tenantId,
        this.createdAt,
        this.updatedAt,
    });

    factory QrImage.fromMap(Map<String, dynamic> json) => QrImage(
        id: json["id"],
        photo: json["photo"],
        link: json["link"],
        tenantId: json["tenant_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "photo": photo,
        "link": link,
        "tenant_id": tenantId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
