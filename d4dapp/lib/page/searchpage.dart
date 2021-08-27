import 'dart:convert';

import 'package:d4dapp/network/connect.dart';
import 'package:d4dapp/service/my_fuction.dart';
import 'package:d4dapp/service/myitemapp.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List data = [];
  String? path;
  bool status = false;
  TextEditingController _keyword = TextEditingController();

  Future<void> getData(String keyword) async {
    await ConnectAPI().get('get-all-application?search=$keyword').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          path = jsonDecode(value.body)['path'];
          data = jsonDecode(value.body)['data'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: TextField(
          controller: _keyword,
          onChanged: (String value) {
            if (value.length >= 1) {
              setState(() {
                status = true;
              });
            } else {
              setState(() {
                status = false;
              });
            }
          },
          decoration: InputDecoration(
            hintText: 'ค้นหาแอป',
            hintStyle:
                Theme.of(context).textTheme.body1!.apply(color: Colors.grey),
            border: OutlineInputBorder(
              //borderRadius: new BorderRadius.circular(25.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        actions: [
          IconButton(
            splashRadius: 20,
            onPressed: status
                ? () {
                    getData(_keyword.text);
                  }
                : null,
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: data.isEmpty
          ? Container()
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ค้นหา ${_keyword.text}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Wrap(
                      runAlignment: WrapAlignment.start,
                      children: data
                          .map(
                            (e) => MyItemApp(
                          onTap:()=> MyFuction().getdata(e['id'], context),
                          nameApp: e['app_name_th'],
                          iconApp: '$path/${e['icon']}',
                          rateApp: e['rating'],
                          android: e['link_android'] == null ? false : true,
                          windows: e['link_windows'] == null ? false : true,
                          ios: e['link_ios'] == null ? false : true,
                        ),
                      )
                          .toList(),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
