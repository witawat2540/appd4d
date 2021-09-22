// To parse this JSON data, do
//
//     final getPracticeModel = getPracticeModelFromJson(jsonString);

import 'dart:convert';

GetPracticeModel getPracticeModelFromJson(String str) => GetPracticeModel.fromJson(json.decode(str));

String getPracticeModelToJson(GetPracticeModel data) => json.encode(data.toJson());

class GetPracticeModel {
  GetPracticeModel({
    this.status,
    this.data,
  });

  bool? status;
  List<DataPractice>? data;

  factory GetPracticeModel.fromJson(Map<String, dynamic> json) => GetPracticeModel(
    status: json["status"],
    data: List<DataPractice>.from(json["data"].map((x) => DataPractice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataPractice {
  DataPractice({
    this.id,
    this.userId,
    this.name,
    this.mainGroupsId,
    this.subGroupsId,
    this.assetCategoriesId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? name;
  int? mainGroupsId;
  dynamic subGroupsId;
  dynamic assetCategoriesId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DataPractice.fromJson(Map<String, dynamic> json) => DataPractice(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    mainGroupsId: json["main_groups_id"],
    subGroupsId: json["sub_groups_id"],
    assetCategoriesId: json["asset_categories_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "main_groups_id": mainGroupsId,
    "sub_groups_id": subGroupsId,
    "asset_categories_id": assetCategoriesId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
