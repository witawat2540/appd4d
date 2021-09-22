// To parse this JSON data, do
//
//     final spousemodel = spousemodelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DataSubstituteModel {
  int? id;
  int? userId;
  String? title ;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  String? related;
  TextEditingController proxyDate = TextEditingController();
  TextEditingController birthday = TextEditingController();

  TextEditingController citizenId = TextEditingController();
  TextEditingController houseNo = TextEditingController();
  TextEditingController villageNo = TextEditingController();
  TextEditingController lane = TextEditingController();
  String? subDistrict;
  String? district;
  String? province;
  TextEditingController postalCode = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController email = TextEditingController();
  String? degree;
  TextEditingController eduPlace = TextEditingController();
  int? idProvince;
  int? idDistrict;
  int? idSubDistrict;

  setText(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    title = json["title"];
    firstName.text = json["first_name"];
    lastName.text = json["last_name"];
    related =  json["related"];
    proxyDate.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(json["proxy_date"]));
    birthday.text = DateFormat('yyyy-MM-dd').format(DateTime.parse(json["brithday"]));
    //birthday.text = json["brithday"];
    citizenId.text =  json["citizen_id"];
    houseNo.text =  json["house_no"] ?? '';
    villageNo.text = json["village_no"] ?? '';
    lane.text = json["lane"] ?? '';
    subDistrict = json["sub_district"];
    district = json["district"] ?? '';
    province = json["province"] ?? '';
    postalCode.text = json["postal_code"] ?? '';
    tel.text = json["tel"] ?? '';
    email.text = json["email"] ?? '';
    degree = json["degree"] ?? '';
    eduPlace.text = json["edu_place"] ?? '';
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "first_name": firstName.text,
    "last_name": lastName.text,
    "related": related,
    "proxy_date": proxyDate.text,
    "brithday": birthday.text,
    "citizen_id": citizenId.text,
    "house_no": houseNo.text,
    "village_no": villageNo.text,
    "lane": lane.text,
    "sub_district": subDistrict,
    "district": district,
    "province": province,
    "postal_code": postalCode.text,
    "tel": tel.text,
    "email": email.text,
    "degree": degree,
    "edu_place": eduPlace.text,
  };
}
