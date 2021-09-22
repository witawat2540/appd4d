// To parse this JSON data, do
//
//     final practiceFormModel = practiceFormModelFromJson(jsonString);

import 'dart:convert';

PracticeFormModel practiceFormModelFromJson(String str) => PracticeFormModel.fromJson(json.decode(str));

String practiceFormModelToJson(PracticeFormModel data) => json.encode(data.toJson());

class PracticeFormModel {
  PracticeFormModel({
    this.userId,
    this.name,
    this.mainGroupsId,
    this.subGroupsId,
    this.assetCategoriesId,
  });

  String? userId;
  String? name;
  int? mainGroupsId;
  int? subGroupsId;
  int? assetCategoriesId;

  factory PracticeFormModel.fromJson(Map<String, dynamic> json) => PracticeFormModel(
    userId: json["user_id"],
    name: json["name"],
    mainGroupsId: json["main_groups_id"],
    subGroupsId: json["sub_groups_id"],
    assetCategoriesId: json["asset_categories_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "main_groups_id": mainGroupsId,
    "sub_groups_id": subGroupsId,
    "asset_categories_id": assetCategoriesId,
  };
}
