// To parse this JSON data, do
//
//     final rightsModel = rightsModelFromJson(jsonString);

import 'dart:convert';

RightsModel rightsModelFromJson(String str) => RightsModel.fromJson(json.decode(str));

String rightsModelToJson(RightsModel data) => json.encode(data.toJson());

class RightsModel {
  RightsModel({
    this.maimadPrefixCode,
    this.maimadPrefixNameThai,
    this.maimadFirstNameThai,
    this.maimadLastNameThai,
    this.maimadPersonCode,
    this.maimadBirthDate,
    this.maimadAge,
    this.maimadSexCode,
    this.maimadSexNameThai,
    this.nationalityCode,
    this.maimadCurrAddressNo,
    this.maimadCurrMoo,
    this.maimadCurrSoi,
    this.maimadCurrStreet,
    this.maimadCurrAddress,
    this.maimadCurrSubdistrictName,
    this.maimadCurrSubdistrictCode,
    this.maimadCurrDistrictName,
    this.maimadCurrDistrictCode,
    this.maimadCurrProvinceName,
    this.maimadCurrProvinceCode,
    this.maimadCurrPostCode,
    this.curatorPrefixCode,
    this.curatorPrefixName,
    this.curatorFirstName,
    this.curatorLastName,
    this.curatorPersonCode,
    this.curatorRelationCode,
    this.curatorRelationName,
    this.curatorRelationOther,
    this.curatorCurrAddressNo,
    this.curatorCurrMoo,
    this.curatorCurrSoi,
    this.curatorCurrStreet,
    this.curatorCurrAddress,
    this.curatorCurrSubdistrictName,
    this.curatorCurrSubdistrictCode,
    this.curatorCurrDistrictName,
    this.curatorCurrDistrictCode,
    this.curatorCurrProvinceName,
    this.curatorCurrProvinceCode,
    this.curatorCurrPostCode,
    this.deformid,
    this.deformname,
    this.cardIssueDate,
    this.cardExpireDate,
    this.permitDate,
    this.personSubtype,
  });

  String? maimadPrefixCode;
  String? maimadPrefixNameThai;
  String? maimadFirstNameThai;
  String? maimadLastNameThai;
  String? maimadPersonCode;
  String? maimadBirthDate;
  String? maimadAge;
  String? maimadSexCode;
  String? maimadSexNameThai;
  String? nationalityCode;
  String? maimadCurrAddressNo;
  String? maimadCurrMoo;
  String? maimadCurrSoi;
  String? maimadCurrStreet;
  String? maimadCurrAddress;
  String? maimadCurrSubdistrictName;
  String? maimadCurrSubdistrictCode;
  String? maimadCurrDistrictName;
  String? maimadCurrDistrictCode;
  String? maimadCurrProvinceName;
  String? maimadCurrProvinceCode;
  String? maimadCurrPostCode;
  String? curatorPrefixCode;
  String? curatorPrefixName;
  String? curatorFirstName;
  String? curatorLastName;
  String? curatorPersonCode;
  String? curatorRelationCode;
  String? curatorRelationName;
  String? curatorRelationOther;
  String? curatorCurrAddressNo;
  String? curatorCurrMoo;
  String? curatorCurrSoi;
  String? curatorCurrStreet;
  String? curatorCurrAddress;
  String? curatorCurrSubdistrictName;
  String? curatorCurrSubdistrictCode;
  String? curatorCurrDistrictName;
  String? curatorCurrDistrictCode;
  String? curatorCurrProvinceName;
  String? curatorCurrProvinceCode;
  String? curatorCurrPostCode;
  String? deformid;
  String? deformname;
  String? cardIssueDate;
  String? cardExpireDate;
  String? permitDate;
  String? personSubtype;

  factory RightsModel.fromJson(Map<String, dynamic> json) => RightsModel(
    maimadPrefixCode: json["MAIMAD_PREFIX_CODE"],
    maimadPrefixNameThai: json["MAIMAD_PREFIX_NAME_THAI"],
    maimadFirstNameThai: json["MAIMAD_FIRST_NAME_THAI"],
    maimadLastNameThai: json["MAIMAD_LAST_NAME_THAI"],
    maimadPersonCode: json["MAIMAD_PERSON_CODE"],
    maimadBirthDate: json["MAIMAD_BIRTH_DATE"],
    maimadAge: json["MAIMAD_AGE"],
    maimadSexCode: json["MAIMAD_SEX_CODE"],
    maimadSexNameThai: json["MAIMAD_SEX_NAME_THAI"],
    nationalityCode: json["NATIONALITY_CODE"],
    maimadCurrAddressNo: json["MAIMAD_CURR_ADDRESS_NO"],
    maimadCurrMoo: json["MAIMAD_CURR_MOO"],
    maimadCurrSoi: json["MAIMAD_CURR_SOI"],
    maimadCurrStreet: json["MAIMAD_CURR_STREET"],
    maimadCurrAddress: json["MAIMAD_CURR_ADDRESS"],
    maimadCurrSubdistrictName: json["MAIMAD_CURR_SUBDISTRICT_NAME"],
    maimadCurrSubdistrictCode: json["MAIMAD_CURR_SUBDISTRICT_CODE"],
    maimadCurrDistrictName: json["MAIMAD_CURR_DISTRICT_NAME"],
    maimadCurrDistrictCode: json["MAIMAD_CURR_DISTRICT_CODE"],
    maimadCurrProvinceName: json["MAIMAD_CURR_PROVINCE_NAME"],
    maimadCurrProvinceCode: json["MAIMAD_CURR_PROVINCE_CODE"],
    maimadCurrPostCode: json["MAIMAD_CURR_POST_CODE"],
    curatorPrefixCode: json["CURATOR_PREFIX_CODE"],
    curatorPrefixName: json["CURATOR_PREFIX_NAME"],
    curatorFirstName: json["CURATOR_FIRST_NAME"],
    curatorLastName: json["CURATOR_LAST_NAME"],
    curatorPersonCode: json["CURATOR_PERSON_CODE"],
    curatorRelationCode: json["CURATOR_RELATION_CODE"],
    curatorRelationName: json["CURATOR_RELATION_NAME"],
    curatorRelationOther: json["CURATOR_RELATION_OTHER"],
    curatorCurrAddressNo: json["CURATOR_CURR_ADDRESS_NO"],
    curatorCurrMoo: json["CURATOR_CURR_MOO"],
    curatorCurrSoi: json["CURATOR_CURR_SOI"],
    curatorCurrStreet: json["CURATOR_CURR_STREET"],
    curatorCurrAddress: json["CURATOR_CURR_ADDRESS"],
    curatorCurrSubdistrictName: json["CURATOR_CURR_SUBDISTRICT_NAME"],
    curatorCurrSubdistrictCode: json["CURATOR_CURR_SUBDISTRICT_CODE"],
    curatorCurrDistrictName: json["CURATOR_CURR_DISTRICT_NAME"],
    curatorCurrDistrictCode: json["CURATOR_CURR_DISTRICT_CODE"],
    curatorCurrProvinceName: json["CURATOR_CURR_PROVINCE_NAME"],
    curatorCurrProvinceCode: json["CURATOR_CURR_PROVINCE_CODE"],
    curatorCurrPostCode: json["CURATOR_CURR_POST_CODE"],
    deformid: json["DEFORMID"],
    deformname: json["DEFORMNAME"],
    cardIssueDate: json["CARD_ISSUE_DATE"],
    cardExpireDate: json["CARD_EXPIRE_DATE"],
    permitDate: json["PERMIT_DATE"],
    personSubtype: json["PERSON_SUBTYPE"],
  );

  Map<String, dynamic> toJson() => {
    "MAIMAD_PREFIX_CODE": maimadPrefixCode,
    "MAIMAD_PREFIX_NAME_THAI": maimadPrefixNameThai,
    "MAIMAD_FIRST_NAME_THAI": maimadFirstNameThai,
    "MAIMAD_LAST_NAME_THAI": maimadLastNameThai,
    "MAIMAD_PERSON_CODE": maimadPersonCode,
    "MAIMAD_BIRTH_DATE": maimadBirthDate,
    "MAIMAD_AGE": maimadAge,
    "MAIMAD_SEX_CODE": maimadSexCode,
    "MAIMAD_SEX_NAME_THAI": maimadSexNameThai,
    "NATIONALITY_CODE": nationalityCode,
    "MAIMAD_CURR_ADDRESS_NO": maimadCurrAddressNo,
    "MAIMAD_CURR_MOO": maimadCurrMoo,
    "MAIMAD_CURR_SOI": maimadCurrSoi,
    "MAIMAD_CURR_STREET": maimadCurrStreet,
    "MAIMAD_CURR_ADDRESS": maimadCurrAddress,
    "MAIMAD_CURR_SUBDISTRICT_NAME": maimadCurrSubdistrictName,
    "MAIMAD_CURR_SUBDISTRICT_CODE": maimadCurrSubdistrictCode,
    "MAIMAD_CURR_DISTRICT_NAME": maimadCurrDistrictName,
    "MAIMAD_CURR_DISTRICT_CODE": maimadCurrDistrictCode,
    "MAIMAD_CURR_PROVINCE_NAME": maimadCurrProvinceName,
    "MAIMAD_CURR_PROVINCE_CODE": maimadCurrProvinceCode,
    "MAIMAD_CURR_POST_CODE": maimadCurrPostCode,
    "CURATOR_PREFIX_CODE": curatorPrefixCode,
    "CURATOR_PREFIX_NAME": curatorPrefixName,
    "CURATOR_FIRST_NAME": curatorFirstName,
    "CURATOR_LAST_NAME": curatorLastName,
    "CURATOR_PERSON_CODE": curatorPersonCode,
    "CURATOR_RELATION_CODE": curatorRelationCode,
    "CURATOR_RELATION_NAME": curatorRelationName,
    "CURATOR_RELATION_OTHER": curatorRelationOther,
    "CURATOR_CURR_ADDRESS_NO": curatorCurrAddressNo,
    "CURATOR_CURR_MOO": curatorCurrMoo,
    "CURATOR_CURR_SOI": curatorCurrSoi,
    "CURATOR_CURR_STREET": curatorCurrStreet,
    "CURATOR_CURR_ADDRESS": curatorCurrAddress,
    "CURATOR_CURR_SUBDISTRICT_NAME": curatorCurrSubdistrictName,
    "CURATOR_CURR_SUBDISTRICT_CODE": curatorCurrSubdistrictCode,
    "CURATOR_CURR_DISTRICT_NAME": curatorCurrDistrictName,
    "CURATOR_CURR_DISTRICT_CODE": curatorCurrDistrictCode,
    "CURATOR_CURR_PROVINCE_NAME": curatorCurrProvinceName,
    "CURATOR_CURR_PROVINCE_CODE": curatorCurrProvinceCode,
    "CURATOR_CURR_POST_CODE": curatorCurrPostCode,
    "DEFORMID": deformid,
    "DEFORMNAME": deformname,
    "CARD_ISSUE_DATE": cardIssueDate,
    "CARD_EXPIRE_DATE": cardExpireDate,
    "PERMIT_DATE": permitDate,
    "PERSON_SUBTYPE": personSubtype,
  };
}
