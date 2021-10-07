// To parse this JSON data, do
//
//     final approvalResultsModel = approvalResultsModelFromJson(jsonString);

import 'dart:convert';

ApprovalResultsModel approvalResultsModelFromJson(String str) => ApprovalResultsModel.fromJson(json.decode(str));

String approvalResultsModelToJson(ApprovalResultsModel data) => json.encode(data.toJson());

class ApprovalResultsModel {
  ApprovalResultsModel({
    this.status,
    this.data,
    this.filePath,
  });

  bool? status;
  List<Datum>? data;
  String? filePath;

  factory ApprovalResultsModel.fromJson(Map<String, dynamic> json) => ApprovalResultsModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    filePath: json["file_path"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "file_path": filePath,
  };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.substituteId,
    this.assetId,
    this.assetCategoriesId,
    this.typeStatus,
    this.sendStatus,
    this.sendDate,
    this.objective,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.office,
    this.city,
    this.remark,
    this.image,
    this.auditDate,
    this.approveDate,
    this.form07SId,
    this.form09SId,
    this.form10SId,
    this.form05SId,
    this.form13SId,
    this.docNotifiesId,
    this.docContractsId,
    this.docGarunteeId,
    this.reason,
    this.category,
    this.asset,
  });

  int? id;
  int? userId;
  dynamic substituteId;
  int? assetId;
  int? assetCategoriesId;
  String? typeStatus;
  String? sendStatus;
  DateTime? sendDate;
  String? objective;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? office;
  String? city;
  dynamic remark;
  dynamic image;
  DateTime? auditDate;
  DateTime? approveDate;
  int? form07SId;
  int? form09SId;
  dynamic form10SId;
  dynamic form05SId;
  dynamic form13SId;
  dynamic docNotifiesId;
  int? docContractsId;
  int? docGarunteeId;
  dynamic reason;
  Category? category;
  Asset? asset;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    substituteId: json["substitute_id"],
    assetId: json["asset_id"],
    assetCategoriesId: json["asset_categories_id"],
    typeStatus: json["type_status"],
    sendStatus: json["send_status"],
    sendDate: DateTime.parse(json["send_date"]),
    objective: json["objective"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json['deleted_at'] == null ? null : DateTime.parse(json['deleted_at']),
    office: json["office"],
    city: json["city"],
    remark: json["remark"],
    image: json["image"],
    auditDate: DateTime.parse(json["audit_date"]),
    approveDate: DateTime.parse(json["approve_date"]),
    form07SId: json["form07s_id"],
    form09SId: json["form09s_id"],
    form10SId: json["form10s_id"],
    form05SId: json["form05s_id"],
    form13SId: json["form13s_id"],
    docNotifiesId: json["doc_notifies_id"],
    docContractsId: json["doc_contracts_id"],
    docGarunteeId: json["doc_garuntee_id"],
    reason: json["reason"],
    category: json['category'] != null
        ? new Category.fromJson(json['category'])
        : null,
    asset: json['asset'] != null
        ? new Asset.fromJson(json['asset'])
        : null
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "substitute_id": substituteId,
    "asset_id": assetId,
    "asset_categories_id": assetCategoriesId,
    "type_status": typeStatus,
    "send_status": sendStatus,
    "send_date": sendDate!.toIso8601String(),
    "objective": objective,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "office": office,
    "city": city,
    "remark": remark,
    "image": image,
    "audit_date": auditDate!.toIso8601String(),
    "approve_date": approveDate!.toIso8601String(),
    "form07s_id": form07SId,
    "form09s_id": form09SId,
    "form10s_id": form10SId,
    "form05s_id": form05SId,
    "form13s_id": form13SId,
    "doc_notifies_id": docNotifiesId,
    "doc_contracts_id": docContractsId,
    "doc_garuntee_id": docGarunteeId,
    "reason": reason,
    "category": category!.toJson(),
    "asset": asset!.toJson(),
  };
}

class Asset {
  Asset({
    this.id,
    this.code,
    this.description,
  });

  int? id;
  String? code;
  String? description;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    id: json["id"],
    code: json["code"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "description": description,
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.imageString,
  });

  int? id;
  String? name;
  dynamic imageString;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    imageString: json["imageString"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "imageString": imageString,
  };
}
