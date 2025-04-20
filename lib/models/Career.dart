CareersModel careersModelFromJson(str) => CareersModel.fromJson(str);

class CareersModel {
  List<Career>? careers;

  CareersModel({
    this.careers,
  });

  factory CareersModel.fromJson(Map<String, dynamic> json) => CareersModel(
        careers: json["careers"] == null
            ? []
            : List<Career>.from(
                json["careers"]!.map((x) => Career.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "careers": careers == null
            ? []
            : List<dynamic>.from(careers!.map((x) => x.toJson())),
      };
}

class Career {
  int? id;
  String? title;
  String? description;
  String? tenantId;
  int? storeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<CareerSpecification>? careerSpecifications;

  Career({
    this.id,
    this.title,
    this.description,
    this.tenantId,
    this.storeId,
    this.createdAt,
    this.updatedAt,
    this.careerSpecifications,
  });

  factory Career.fromJson(Map<String, dynamic> json) => Career(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        tenantId: json["tenant_id"],
        storeId: json["store_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        careerSpecifications: json["career_specifications"] == null
            ? []
            : List<CareerSpecification>.from(json["career_specifications"]!
                .map((x) => CareerSpecification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "tenant_id": tenantId,
        "store_id": storeId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "career_specifications": careerSpecifications == null
            ? []
            : List<dynamic>.from(careerSpecifications!.map((x) => x.toJson())),
      };
}

class CareerSpecification {
  int? id;
  String? name;
  String? validation;
  int? type;
  int? availableReport;
  int? careerId;
  String? tenantId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<CareerSpecificationValue>? careerSpecificationValues;

  CareerSpecification({
    this.id,
    this.name,
    this.validation,
    this.type,
    this.availableReport,
    this.careerId,
    this.tenantId,
    this.createdAt,
    this.updatedAt,
    this.careerSpecificationValues,
  });

  factory CareerSpecification.fromJson(Map<String, dynamic> json) =>
      CareerSpecification(
        id: json["id"],
        name: json["name"],
        validation: json["validation"],
        type: json["type"],
        availableReport: json["available_report"],
        careerId: json["career_id"],
        tenantId: json["tenant_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        careerSpecificationValues: json["career_specification_values"] == null
            ? []
            : List<CareerSpecificationValue>.from(
                json["career_specification_values"]!
                    .map((x) => CareerSpecificationValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "validation": validation,
        "type": type,
        "available_report": availableReport,
        "career_id": careerId,
        "tenant_id": tenantId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "career_specification_values": careerSpecificationValues == null
            ? []
            : List<dynamic>.from(
                careerSpecificationValues!.map((x) => x.toJson())),
      };
}

class CareerSpecificationValue {
  int? id;
  String? value;
  int? careerSpecificationId;
  String? tenantId;
  DateTime? createdAt;
  DateTime? updatedAt;

  CareerSpecificationValue({
    this.id,
    this.value,
    this.careerSpecificationId,
    this.tenantId,
    this.createdAt,
    this.updatedAt,
  });

  factory CareerSpecificationValue.fromJson(Map<String, dynamic> json) =>
      CareerSpecificationValue(
        id: json["id"],
        value: json["value"],
        careerSpecificationId: json["career_specification_id"],
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
        "value": value,
        "career_specification_id": careerSpecificationId,
        "tenant_id": tenantId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
