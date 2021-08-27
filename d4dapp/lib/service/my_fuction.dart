import 'dart:convert';

import 'package:d4dapp/network/connect.dart';
import 'package:d4dapp/page/detail.dart';
import 'package:flutter/material.dart';

class MyFuction {
  Future<void> getdata(int id,BuildContext context)async{
    await ConnectAPI().get('get-application/$id').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detail(
              dataDetail: jsonDecode(value.body)['data'],
              countDownload: jsonDecode(value.body)['download'],
              datagroup: jsonDecode(value.body)['group'],
              datauser: jsonDecode(value.body)['user'],
              path: jsonDecode(value.body)['path']!,
            ),
          ),
        );
      }
    });
  }

  Future<void> getdata2(int id,BuildContext context)async{
    await ConnectAPI().get('get-application/$id').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Detail(
              dataDetail: jsonDecode(value.body)['data'],
              countDownload: jsonDecode(value.body)['download'],
              datagroup: jsonDecode(value.body)['group'],
              datauser: jsonDecode(value.body)['user'],
              path: jsonDecode(value.body)['path']!,
            ),
          ),
        );
      }
    });
  }
}