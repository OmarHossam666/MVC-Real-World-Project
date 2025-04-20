// To parse this JSON data, do
//
//     final contactModel = contactModelFromJson(jsonString);

import 'dart:convert';

ContactModel contactModelFromJson(String str) => ContactModel.fromJson(json.decode(str));

String contactModelToJson(ContactModel data) => json.encode(data.toJson());

class ContactModel {
    final List<Contact>? contact;

    ContactModel({
        this.contact,
    });

    factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        contact: json["contact"] == null ? [] : List<Contact>.from(json["contact"]!.map((x) => Contact.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "contact": contact == null ? [] : List<dynamic>.from(contact!.map((x) => x.toJson())),
    };
}

class Contact {
    final int? id;
    final String? title;
    final String? description;
    final String? tenantId;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Contact({
        this.id,
        this.title,
        this.description,
        this.tenantId,
        this.createdAt,
        this.updatedAt,
    });

    factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        tenantId: json["tenant_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "tenant_id": tenantId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
