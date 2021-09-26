// To parse this JSON data, do
//
//     final getHelpdeskModel = getHelpdeskModelFromJson(jsonString);

import 'dart:convert';

List<GetHelpdeskModel> getHelpdeskModelFromJson(String str) => List<GetHelpdeskModel>.from(json.decode(str).map((x) => GetHelpdeskModel.fromJson(x)));

String getHelpdeskModelToJson(List<GetHelpdeskModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetHelpdeskModel {
  GetHelpdeskModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.status,
    this.note,
    this.userId,
    this.helpdeskUserId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? title;
  String? description;
  dynamic image;
  String? status;
  dynamic note;
  int? userId;
  dynamic helpdeskUserId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory GetHelpdeskModel.fromJson(Map<String, dynamic> json) => GetHelpdeskModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    status: json["status"],
    note: json["note"],
    userId: json["user_id"],
    helpdeskUserId: json["helpdesk_user_id"],
    createdAt: DateTime.parse(json["created_at"]).toLocal(),
    updatedAt: DateTime.parse(json["updated_at"]).toLocal(),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "status": status,
    "note": note,
    "user_id": userId,
    "helpdesk_user_id": helpdeskUserId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
