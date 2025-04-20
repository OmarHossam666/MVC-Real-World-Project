// To parse this JSON data, do
//
//     final basicData = basicDataFromJson(jsonString);

import 'dart:convert';

BasicData basicDataFromJson(String str) => BasicData.fromJson(json.decode(str));

String basicDataToJson(BasicData data) => json.encode(data.toJson());

class BasicData {
    BasicData({
        required this.id,
        required this.domain,
        required this.tenantId,
        required this.appId,
        required this.type,
        required this.isBlocked,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
        required this.sales,
        required this.pdf,
        required this.qrCode
    });

    int? id;
    String domain;
    String tenantId;
    String appId;
    int? type;
    int? isBlocked;
    String createdAt;
    String updatedAt;
    User user;
    String qrCode;
    List<Sale> sales;
    List<Pdf> pdf;

    factory BasicData.fromJson(Map<String, dynamic> json) => BasicData(
        id: json["id"],
        domain: json["domain"],
        tenantId: json["tenant_id"],
        appId: json["app_id"],
        type: json["type"],
        isBlocked: json["is_blocked"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        qrCode: json["qr"],
        user: User.fromJson(json["user"]),
        sales:  List<Sale>.from(json["sales"].map((x) => Sale.fromJson(x))),
        pdf:  List<Pdf>.from(json["pdf"].map((x) => Pdf.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "domain": domain,
        "tenant_id": tenantId,
        "app_id": appId,
        "type": type,
        "is_blocked": isBlocked,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user": user.toJson(),
        "sales":  List<dynamic>.from(sales.map((x) => x.toJson())),
        "pdf": List<dynamic>.from(pdf.map((x) => x.toJson())),
    };
}

class Pdf {
    Pdf({
        required this.id,
        required this.title,
        required this.status,
        required this.startDate,
        required this.endDate,
        required this.tenantId,
        required this.createdAt,
        required this.updatedAt,
        required this.saleAttachs,
    });

    int? id;
    String title;
    int? status;
    String startDate;
    String endDate;
    String tenantId;
    String createdAt;
    String updatedAt;
    List<SaleAttach> saleAttachs;

    factory Pdf.fromJson(Map<String, dynamic> json) => Pdf(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        tenantId: json["tenant_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        saleAttachs: List<SaleAttach>.from(json["sale_attachs"].map((x) => SaleAttach.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
        "start_date": startDate,
        "end_date": endDate,
        "tenant_id": tenantId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "sale_attachs": List<dynamic>.from(saleAttachs.map((x) => x.toJson())),
    };
}

class SaleAttach {
    SaleAttach({
        required this.id,
        required this.type,
        required this.fileUrl,
        required this.saleId,
    });

    int? id;
    String type;
    String fileUrl;
    int? saleId;

    factory SaleAttach.fromJson(Map<String, dynamic> json) => SaleAttach(
        id: json["id"],
        type: json["type"],
        fileUrl: json["file_url"],
        saleId: json["sale_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "file_url": fileUrl,
        "sale_id": saleId,
    };
}

class Sale {
    Sale({
        required this.id,
        required this.title,
        required this.status,
        required this.startDate,
        required this.endDate,
        required this.tenantId,
        required this.createdAt,
        required this.updatedAt,
        required this.products,
    });

    int? id;
    String title;
    int? status;
    String startDate;
    String endDate;
    String tenantId;
    String createdAt;
    String updatedAt;
    List<Product> products;

    factory Sale.fromJson(Map<String, dynamic> json) => Sale(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        tenantId: json["tenant_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
        "start_date": startDate,
        "end_date": endDate,
        "tenant_id": tenantId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Product {
    Product({
        required this.id,
        required this.name,
        required this.price,
        required this.image,
        required this.saleId,
        required this.tenantId,
        required this.createdAt,
        required this.updatedAt,
    });

    int? id;
    String name;
    String price;
    String image;
    int? saleId;
    String tenantId;
    String createdAt;
    String updatedAt;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"].toString(),
        image: json["image"],
        saleId: json["sale_id"],
        tenantId: json["tenant_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "image": image,
        "sale_id": saleId,
        "tenant_id": tenantId,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

class User {
    User({
        required this.id,
        required this.name,
        required this.email,
        required this.mobile,
        required this.tenantId,
        required this.profileImage,
        this.roleId,
        required this.type,
        this.token,
        required this.wallet,
        required this.isAvailable,
        required this.isOnline,
        required this.isNotification,
        required this.isMail,
        required this.isVerified,
        required this.otp,
        this.rememberToken,
        required this.createdAt,
        required this.updatedAt,
        this.deletedAt,
          required this.addresses,
    });

    int? id;
    String name;
    String email;
    String mobile;
    String tenantId;
    String profileImage;
    dynamic roleId;
    int? type;
    dynamic token;
    int? wallet;
    int? isAvailable;
    int? isOnline;
    int? isNotification;
    int? isMail;
    int? isVerified;
    String otp;
    dynamic rememberToken;
    String createdAt;
    String updatedAt;
    dynamic deletedAt;
    List<Address> addresses;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        tenantId: json["tenant_id"],
        profileImage: json["profile_image"],
        roleId: json["role_id"],
        type: json["type"],
        token: json["token"],
        wallet: json["wallet"],
        isAvailable: json["is_available"],
        isOnline: json["is_online"],
        isNotification: json["is_notification"],
        isMail: json["is_mail"],
        isVerified: json["is_verified"],
        otp: json["otp"],
        rememberToken: json["remember_token"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "tenant_id": tenantId,
        "profile_image": profileImage,
        "role_id": roleId,
        "type": type,
        "token": token,
        "wallet": wallet,
        "is_available": isAvailable,
        "is_online": isOnline,
        "is_notification": isNotification,
        "is_mail": isMail,
        "is_verified": isVerified,
        "otp": otp,
        "remember_token": rememberToken,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
    };
}
class Address {
    Address({
        required this.id,
        required this.userId,
        required this.addressType,
        required this.address,
        this.lat,
        this.lang,
        this.area,
        this.houseNo,
        required this.createdAt,
        required this.updatedAt,
    });

    int? id;
    int? userId;
    int? addressType;
    String address;
    dynamic lat;
    dynamic lang;
    dynamic area;
    dynamic houseNo;
    String createdAt;
    String updatedAt;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["user_id"],
        addressType: json["address_type"],
        address: json["address"],
        lat: json["lat"],
        lang: json["lang"],
        area: json["area"],
        houseNo: json["house_no"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "address_type": addressType,
        "address": address,
        "lat": lat,
        "lang": lang,
        "area": area,
        "house_no": houseNo,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}