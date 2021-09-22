// To parse this JSON data, do
//
//     final getSubstituteModel = getSubstituteModelFromJson(jsonString);

import 'dart:convert';

GetSubstituteModel getSubstituteModelFromJson(String str) => GetSubstituteModel.fromJson(json.decode(str));

String getSubstituteModelToJson(GetSubstituteModel data) => json.encode(data.toJson());

class GetSubstituteModel {
  GetSubstituteModel({
     this.status,
     this.data,
  });

  bool? status;
  List<Datum>? data;

  factory GetSubstituteModel.fromJson(Map<String, dynamic> json) => GetSubstituteModel(
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
    this.id,
    this.userId,
    this.title,
    this.firstName,
    this.lastName,
    this.related,
    this.proxyDate,
    this.brithday,
    this.citizenId,
    this.houseNo,
    this.villageNo,
    this.lane,
    this.subDistrict,
    this.district,
    this.province,
    this.postalCode,
    this.tel,
    this.email,
    this.degree,
    this.eduPlace,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  int? userId;
  String? title;
  String? firstName;
  String? lastName;
  String? related;
  DateTime? proxyDate;
  DateTime? brithday;
  String? citizenId;
  String? houseNo;
  String? villageNo;
  String? lane;
  String? subDistrict;
  String? district;
  String? province;
  String? postalCode;
  String? tel;
  String? email;
  String? degree;
  String? eduPlace;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    title: json["title"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    related: json["related"],
    proxyDate: DateTime.parse(json["proxy_date"]??'2021-00-00'),
    brithday: DateTime.parse(json["brithday"]?? '2021-00-00'),
    citizenId: json["citizen_id"],
    houseNo: json["house_no"],
    villageNo: json["village_no"],
    lane: json["lane"],
    subDistrict: json["sub_district"],
    district: json["district"],
    province: json["province"],
    postalCode: json["postal_code"],
    tel: json["tel"],
    email: json["email"],
    degree: json["degree"],
    eduPlace: json["edu_place"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "first_name": firstName,
    "last_name": lastName,
    "related": related,
    "proxy_date": proxyDate!.toIso8601String(),
    "brithday": brithday!.toIso8601String(),
    "citizen_id": citizenId,
    "house_no": houseNo,
    "village_no": villageNo,
    "lane": lane,
    "sub_district": subDistrict,
    "district": district,
    "province": province,
    "postal_code": postalCode,
    "tel": tel,
    "email": email,
    "degree": degree,
    "edu_place": eduPlace,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "deleted_at": deletedAt,
  };
}
