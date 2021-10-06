// To parse this JSON data, do
//
//     final getFormReceiveModel = getFormReceiveModelFromJson(jsonString);

import 'dart:convert';

GetFormReceiveModel getFormReceiveModelFromJson(String str) => GetFormReceiveModel.fromJson(json.decode(str));

String getFormReceiveModelToJson(GetFormReceiveModel data) => json.encode(data.toJson());

class GetFormReceiveModel {
  GetFormReceiveModel({
    this.status,
    this.data,
  });

  bool? status;
  List<Datum>? data;

  factory GetFormReceiveModel.fromJson(Map<String, dynamic> json) => GetFormReceiveModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.position,
    this.form,
    this.asset,
    this.total,
  });

  int? position;
  Form? form;
  int? asset;
  int? total;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    position: json["position"],
    form: Form.fromJson(json["form"]),
    asset: json["asset"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "position": position,
    "form": form!.toJson(),
    "asset": asset,
    "total": total,
  };
}

class Form {
  Form({
    this.id,
    this.typeStatus,
    this.createdAt,
    this.sendDate,
  });

  int? id;
  String? typeStatus;
  DateTime? createdAt;
  DateTime? sendDate;

  factory Form.fromJson(Map<String, dynamic> json) => Form(
    id: json["id"],
    typeStatus: json["type_status"],
    createdAt: DateTime.parse(json["created_at"]),
    sendDate: DateTime.parse(json["send_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type_status": typeStatus,
    "created_at": createdAt!.toIso8601String(),
    "send_date": sendDate!.toIso8601String(),
  };
}
