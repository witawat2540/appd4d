import 'package:d4dapp/service/my_fuction.dart';
import 'package:d4dapp/service/myitemapp.dart';
import 'package:flutter/material.dart';

class PageSpitApp extends StatefulWidget {
  final List data;
  final String path, title;


  const PageSpitApp(
      {Key? key, required this.data, required this.path, required this.title})
      : super(key: key);

  @override
  _PageSpitAppState createState() => _PageSpitAppState();
}

class _PageSpitAppState extends State<PageSpitApp> {
  @override
  Widget build(BuildContext context) {
    return widget.data.isEmpty
        ? Center(
            child: Text('ไม่มีแอป'),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.title}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  Wrap(
                    runAlignment: WrapAlignment.start,
                    children: widget.data
                        .map(
                          (e) => MyItemApp(
                            onTap:()=> MyFuction().getdata(e['id'], context),
                            nameApp: e['app_name_th'],
                            iconApp: '${widget.path}/${e['icon']}',
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
          );
  }
}
