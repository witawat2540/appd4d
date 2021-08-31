import 'dart:convert';

import 'package:onde_app/network/connect.dart';

class MyFunction{

  static Future<List> getPrefix()async{
    List data = [];
    await ConnectAPI().postHeaders(jsonEncode({}),'get-prefix-name').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        data = jsonDecode(value.body)['data'];
      }
    });
    return data;
  }
}