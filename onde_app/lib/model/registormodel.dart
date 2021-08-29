// To parse this JSON data, do
//
//     final registor = registorFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

Registor registorFromJson(String str) => Registor.fromJson(json.decode(str));

Map<String,String> registorToJson(Registor data) => Map<String,String>.from(data.toJson());

class Registor {
  Registor({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.cPassword,
    this.citizenId,
    this.pwdId,
    this.disabilityTypeId,
    this.gender = 1,
    this.pwdPic
  });

  TextEditingController? firstName;
  final TextEditingController? lastName;
  final TextEditingController? email;

 final TextEditingController? password;

  final TextEditingController? cPassword;

  final TextEditingController? citizenId;
  TextEditingController? pwdId;
  TextEditingController? pwdPic;
  int? disabilityTypeId;
  int? gender;

  factory Registor.fromJson(Map<String, dynamic> json) => Registor(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        password: json["password"],
        cPassword: json["c_password"],
        citizenId: json["citizen_id"],
        pwdId: json["pwd_id"],
        disabilityTypeId: json["disability_type_id"],
        gender: json["gender"],
        pwdPic: json["pwd_pic"],
      );

  Map<String, String> toJson() => {
        "first_name": firstName!.text,
        "last_name": lastName!.text,
        "email": email!.text,
        "password": password!.text,
        "c_password": cPassword!.text,
        "citizen_id": citizenId!.text,
        "pwd_id": pwdId!.text,
        "disability_type_id": disabilityTypeId.toString(),
        "gender": gender.toString(),
        "pwd_pic": pwdPic!.text,
      };
}
