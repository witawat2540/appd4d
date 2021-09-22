// To parse this JSON data, do
//
//     final getDocumentModel = getDocumentModelFromJson(jsonString);

import 'dart:convert';

List<GetDocumentModel> getDocumentModelFromJson(String str) => List<GetDocumentModel>.from(json.decode(str).map((x) => GetDocumentModel.fromJson(x)));

String getDocumentModelToJson(List<GetDocumentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetDocumentModel {
  GetDocumentModel({
    this.id,
    this.title,
  });

  int? id;
  String? title;

  factory GetDocumentModel.fromJson(Map<String, dynamic> json) => GetDocumentModel(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
