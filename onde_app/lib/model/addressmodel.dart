// To parse this JSON data, do
//
//     final addressmodel = addressmodelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class AddressModel {
  TextEditingController houseNo = TextEditingController();
  TextEditingController villageNo = TextEditingController();
  TextEditingController lane = TextEditingController();
  String? subDistrict;
  String? district;
  String? province;
  String? postalCode;
  String? eduLevel;
  String? eduPlace;
  String? eduProvine;
  String? eduDistrict;
  TextEditingController tel = TextEditingController();

  /* factory Addressmodel.fromRawJson(String str) => Addressmodel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());*/

  setText(Map<String, dynamic> json) {
    houseNo.text = json["house_no"];
    villageNo.text = json["village_no"];
    lane.text = json["lane"];
    subDistrict = json["sub_district"];
    district = json["district"];
    province = json["province"];
    postalCode = json["postal_code"];
    eduLevel = json["edu_level"];
    eduPlace = json["edu_place"];
    eduProvine = json["edu_provine"];
    eduDistrict = json["edu_district"];
    tel.text = json["tel"];
  }

  Map<String, dynamic> toJson() => {
        "house_no": houseNo.text,
        "village_no": villageNo.text,
        "lane": lane.text,
        "sub_district": subDistrict,
        "district": district,
        "province": province,
        "postal_code": postalCode,
        "edu_level": eduLevel,
        "edu_place": eduPlace,
        "edu_provine": eduProvine,
        "edu_district": eduDistrict,
        "tel": tel.text,
      };
}
