// To parse this JSON data, do
//
//     final getQuestionnaireModel = getQuestionnaireModelFromJson(jsonString);

import 'dart:convert';

List<GetQuestionnaireModel> getQuestionnaireModelFromJson(String str) => List<GetQuestionnaireModel>.from(json.decode(str).map((x) => GetQuestionnaireModel.fromJson(x)));

String getQuestionnaireModelToJson(List<GetQuestionnaireModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetQuestionnaireModel {
  GetQuestionnaireModel({
    this.title,
    this.id,
  });

  String? title;
  int? id;

  factory GetQuestionnaireModel.fromJson(Map<String, dynamic> json) => GetQuestionnaireModel(
    title: json["title"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
  };
}
