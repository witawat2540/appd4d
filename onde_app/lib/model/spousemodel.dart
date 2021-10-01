// To parse this JSON data, do
//
//     final spouseModel = spouseModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

//SpouseModel spouseModelFromJson(String str) => SpouseModel.fromJson(json.decode(str));

//String spouseModelToJson(SpouseModel data) => json.encode(data.toJson());

class SpouseModel {
  /*SpouseModel({
    this.id,
    this.userId,
    this.substituteId,
    this.title,
    this.firstName,
    this.lastName,
    this.birthday,
    this.citizenId,
    this.houseNo,
    this.villageNo,
    this.provinceId,
    this.districtId,
    this.subDistrictId,
    this.postalCode,
    this.tel,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });*/

  int? id;
  dynamic userId;
  int? substituteId;
  String? title;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController citizenId = TextEditingController();
  TextEditingController houseNo = TextEditingController();
  TextEditingController villageNo = TextEditingController();
  int? provinceId;
  int? districtId;
  int? subDistrictId;
  TextEditingController postalCode = TextEditingController();
  TextEditingController tel = TextEditingController();
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? province;
  String? district;
  String? subDistrict;

  /*factory SpouseModel.fromJson(Map<String, dynamic> json) => SpouseModel(
    id: json["id"],
    userId: json["user_id"],
    substituteId: json["substitute_id"],
    title: json["title"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    birthday: DateTime.parse(json["birthday"]),
    citizenId: json["citizen_id"],
    houseNo: json["house_no"],
    villageNo: json["village_no"],
    provinceId: json["province_id"],
    districtId: json["district_id"],
    subDistrictId: json["sub_district_id"],
    postalCode: json["postal_code"],
    tel: json["tel"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );*/
  setText(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    substituteId = json["substitute_id"];
    title = json["title"];
    firstName.text = json["first_name"] ?? '-';
    lastName.text = json["last_name"] ?? '-';
    birthday.text = json["birthday"];
    citizenId.text = json["citizen_id"] ?? '-';
    houseNo.text = json["house_no"] ?? '-';
    villageNo.text = json["village_no"] ?? '-';
    provinceId = int.parse(json["province_id"].toString());
    districtId = int.parse(json["district_id"].toString());
    subDistrictId = int.parse(json["sub_district_id"].toString());
    postalCode.text = json["postal_code"] ?? '-';
    tel.text = json["tel"] ?? '';
    /*createdAt = DateTime.parse(json["created_at"]);
    updatedAt = DateTime.parse(json["updated_at"]);*/
    deletedAt = json["deleted_at"];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "substitute_id": substituteId,
        "title": title,
        "first_name": firstName.text,
        "last_name": lastName.text,
        "birthday": birthday.text,
        "citizen_id": citizenId.text,
        "house_no": houseNo.text,
        "village_no": villageNo.text,
        "province_id": provinceId,
        "district_id": districtId,
        "sub_district_id": subDistrictId,
        "postal_code": postalCode.text,
        "tel": tel.text,
        /*"created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),*/
        "deleted_at": deletedAt,
      };
}
