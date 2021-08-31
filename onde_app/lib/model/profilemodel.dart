// To parse this JSON data, do
//
//     final profilemodel = profilemodelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

Profilemodel profilemodelFromJson(String str) =>
    Profilemodel.fromJson(json.decode(str));

String profilemodelToJson(Profilemodel data) => json.encode(data.toJson());

class Profilemodel {
  Profilemodel({
    this.title,
    this.firstName,
    this.lastName,
    this.birthday,
    this.citizenId,
    this.pwdId,
    this.email,
    this.gender,
    this.disabilityTypeId,
  });

  String? title;
  TextEditingController? firstName;
  TextEditingController? lastName;
  TextEditingController? birthday;
  TextEditingController? citizenId;
  TextEditingController? pwdId;
  TextEditingController? email;
  int? gender;
  int? disabilityTypeId;

  factory Profilemodel.fromJson(Map<String, dynamic> json) => Profilemodel(
        title: json["title"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        birthday: json["birthday"],
        citizenId: json["citizen_id"],
        pwdId: json["pwd_id"],
        email: json["email"],
        gender: json["gender"],
        disabilityTypeId: json["disability_type_id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "first_name": firstName!.text,
        "last_name": lastName!.text,
        "birthday": birthday!.text,
        "citizen_id": citizenId!.text,
        "pwd_id": pwdId!.text,
        "email": email!.text,
        "gender": gender,
        "disability_type_id": disabilityTypeId,
      };
}

class ProfileModel {
  String? title;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController citizenId = TextEditingController();
  TextEditingController pwdId = TextEditingController();
  TextEditingController email = TextEditingController();
  int? gender;
  int? disabilityTypeId;

  setText(Map<String, dynamic> json) {
    title = json['title'];
    firstName.text = json["first_name"];
    lastName.text = json["last_name"];
    birthday.text = json["birthday"];
    citizenId.text = json["citizen_id"];
    pwdId.text = json["pwd_id"];
    email.text = json["email"];
    gender = json["gender"];
    disabilityTypeId = json["disability_type_id"];
  }

  String toJson() => jsonEncode({
    "title": title ?? '',
    "first_name": firstName.text,
    "last_name": lastName.text,
    "birthday": birthday.text,
    "citizen_id": citizenId.text,
    "pwd_id": pwdId.text,
    "email": email.text,
    "gender": gender,
    "disability_type_id": disabilityTypeId,
  });
}

/*import 'dart:convert';

import 'package:flutter/material.dart';

class Profilemodel {
  String? title;
  TextEditingController firstName;
  TextEditingController lastName;
  TextEditingController birthday;
  TextEditingController citizenId;
  TextEditingController pwdId;
  TextEditingController email;
  int? gender;
  int? disabilityTypeId;

  Profilemodel({
    this.title,
    required this.firstName,
    required this.lastName,
    required this.birthday,
    required this.citizenId,
    required this.pwdId,
    required this.email,
    this.gender,
    this.disabilityTypeId,
  });

  setJson(Map<String, dynamic> json) {
    title = json["title"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    birthday = json["birthday"];
    citizenId = json["citizen_id"];
    pwdId = json["pwd_id"];
    email = json["email"];
    gender = json["gender"];
    disabilityTypeId = json["disability_type_id"];
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "first_name": firstName,
        "last_name": lastName,
        "birthday": birthday,
        "citizen_id": citizenId,
        "pwd_id": pwdId,
        "email": email,
        "gender": gender,
        "disability_type_id": disabilityTypeId,
      };
}*/
