// To parse this JSON data, do
//
//     final getFormBorrowModel = getFormBorrowModelFromJson(jsonString);

import 'dart:convert';

List<GetFormBorrowModel> getFormBorrowModelFromJson(String str) => List<GetFormBorrowModel>.from(json.decode(str).map((x) => GetFormBorrowModel.fromJson(x)));

String getFormBorrowModelToJson(List<GetFormBorrowModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetFormBorrowModel {
  GetFormBorrowModel({
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
  });

  int? id;
  int? userId;
  dynamic substituteId;
  dynamic assetId;
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
  dynamic auditDate;
  dynamic approveDate;
  dynamic form07SId;
  dynamic form09SId;
  dynamic form10SId;
  dynamic form05SId;
  dynamic form13SId;
  dynamic docNotifiesId;
  dynamic docContractsId;
  dynamic docGarunteeId;
  dynamic reason;

  factory GetFormBorrowModel.fromJson(Map<String, dynamic> json) => GetFormBorrowModel(
    id: json["id"],
    userId: json["user_id"],
    substituteId: json["substitute_id"],
    assetId: json["asset_id"],
    assetCategoriesId: json["asset_categories_id"],
    typeStatus: json["type_status"],
    sendStatus: json["send_status"],
    sendDate: json['send_date']==null?null:DateTime.parse(json["send_date"]),
    objective: json["objective"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    office: json["office"],
    city: json["city"],
    remark: json["remark"],
    image: json["image"],
    auditDate: json["audit_date"],
    approveDate: json["approve_date"],
    form07SId: json["form07s_id"],
    form09SId: json["form09s_id"],
    form10SId: json["form10s_id"],
    form05SId: json["form05s_id"],
    form13SId: json["form13s_id"],
    docNotifiesId: json["doc_notifies_id"],
    docContractsId: json["doc_contracts_id"],
    docGarunteeId: json["doc_garuntee_id"],
    reason: json["reason"],
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
    "audit_date": auditDate,
    "approve_date": approveDate,
    "form07s_id": form07SId,
    "form09s_id": form09SId,
    "form10s_id": form10SId,
    "form05s_id": form05SId,
    "form13s_id": form13SId,
    "doc_notifies_id": docNotifiesId,
    "doc_contracts_id": docContractsId,
    "doc_garuntee_id": docGarunteeId,
    "reason": reason,
  };
}
