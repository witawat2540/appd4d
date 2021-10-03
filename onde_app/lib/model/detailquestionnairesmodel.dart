// To parse this JSON data, do
//
//     final detailQuestionnairesModel = detailQuestionnairesModelFromJson(jsonString);

import 'dart:convert';

DetailQuestionnairesModel detailQuestionnairesModelFromJson(String str) => DetailQuestionnairesModel.fromJson(json.decode(str));

String detailQuestionnairesModelToJson(DetailQuestionnairesModel data) => json.encode(data.toJson());

class DetailQuestionnairesModel {
  DetailQuestionnairesModel({
    this.id,
    this.surveyTypeId,
    this.name,
    this.numberOfQuestion,
    this.isActive,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.questions,
  });

  int? id;
  int? surveyTypeId;
  String? name;
  int? numberOfQuestion;
  int? isActive;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  List<Question>? questions;

  factory DetailQuestionnairesModel.fromJson(Map<String, dynamic> json) => DetailQuestionnairesModel(
    id: json["id"],
    surveyTypeId: json["survey_type_id"],
    name: json["name"],
    numberOfQuestion: json["number_of_question"],
    isActive: json["is_active"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "survey_type_id": surveyTypeId,
    "name": name,
    "number_of_question": numberOfQuestion,
    "is_active": isActive,
    "start_date": startDate!.toIso8601String(),
    "end_date": endDate!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "questions": List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}

class Question {
  Question({
    this.id,
    this.text,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.pivot,
  });

  int? id;
  String? text;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic? deletedAt;
  Pivot? pivot;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    text: json["text"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
    "pivot": pivot!.toJson(),
  };
}

class Pivot {
  Pivot({
    this.surveyId,
    this.questionId,
  });

  int? surveyId;
  int? questionId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    surveyId: json["survey_id"],
    questionId: json["question_id"],
  );

  Map<String, dynamic> toJson() => {
    "survey_id": surveyId,
    "question_id": questionId,
  };
}
