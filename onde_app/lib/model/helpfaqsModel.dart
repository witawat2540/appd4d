// To parse this JSON data, do
//
//     final getHelpFaqsModel = getHelpFaqsModelFromJson(jsonString);

import 'dart:convert';

List<GetHelpFaqsModel> getHelpFaqsModelFromJson(String str) => List<GetHelpFaqsModel>.from(json.decode(str).map((x) => GetHelpFaqsModel.fromJson(x)));

String getHelpFaqsModelToJson(List<GetHelpFaqsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetHelpFaqsModel {
  GetHelpFaqsModel({
    this.question,
    this.answer,
  });

  String? question;
  String? answer;

  factory GetHelpFaqsModel.fromJson(Map<String, dynamic> json) => GetHelpFaqsModel(
    question: json["question"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
  };
}
