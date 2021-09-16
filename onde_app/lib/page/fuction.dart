import 'dart:convert';

import 'package:onde_app/network/connect.dart';

class MyFunction {
  static Future<List> getPrefix() async {
    List data = [];
    await ConnectAPI()
        .postHeaders(jsonEncode({}), 'get-prefix-name')
        .then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        data = jsonDecode(value.body)['data'];
      }
    });
    return data;
  }

  static Future<List> getProvince() async {
    List data = [];
    await ConnectAPI()
        .postHeaders(jsonEncode({}), 'get-province')
        .then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        data = jsonDecode(value.body)['data'];
      }
    });
    return data;
  }

  static Future<List> getDistrict(int? idProvince) async {
    List data = [];
    await ConnectAPI()
        .postHeaders(jsonEncode({"province_id": idProvince}), 'get-district')
        .then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        data = jsonDecode(value.body)['data'];
      }
    });
    return data;
  }

  static Future<List> getSubDistrict(int? idDistric) async {
    List data = [];
    await ConnectAPI()
        .postHeaders(jsonEncode({"district_id": idDistric}), 'get-subdistrict')
        .then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        data = jsonDecode(value.body)['data'];
      }
    });
    return data;
  }

  static Future<int> getZipcode(int? subDistrictId) async {
    int data = 0;
    await ConnectAPI()
        .postHeaders(jsonEncode({"sub_district_id": subDistrictId}), 'get-zipcode')
        .then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        data = jsonDecode(value.body)['data'];
      }
    });
    return data;
  }

  static Future<List> getEducationLevel() async {
    List data = [];
    await ConnectAPI()
        .postHeaders(jsonEncode({}), 'get-education-level')
        .then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        data = jsonDecode(value.body)['data'];
      }
    });
    return data;
  }
}
