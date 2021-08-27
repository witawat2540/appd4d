import 'dart:convert';

import 'package:d4dapp/network/connect.dart';
import 'package:d4dapp/page/detail.dart';
import 'package:d4dapp/page/more_page.dart';
import 'package:d4dapp/service/my_fuction.dart';
import 'package:d4dapp/service/myitemapp.dart';
import 'package:d4dapp/service/mywidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List latest = [];
  List applications = [];
  String? path;

  Future<void> getData() async {
    await ConnectAPI().get('dashboard').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          latest = jsonDecode(value.body)['latest'];
          path = jsonDecode(value.body)['path_application'];
          applications = jsonDecode(value.body)['applications'];
          //print(applications[0]['relation_groups'][0]);
        });
      }
    });
  }

  gotoMorePage(data,title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MorePage(
          path: path!,
          data: data,
          titel: title,
        ),
      ),
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: latest.isEmpty || applications.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'แอพพลิเคชั่นมาใหม่',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      ElevatedButton(
                        onPressed: () => gotoMorePage(latest,'แอพพลิเคชั่นมาใหม่'),
                        child: Row(
                          children: [
                            Icon(Icons.navigate_next),
                            Text('ดูเพิ่ม'),
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: latest
                          .map(
                            (e) => MyItemApp(
                              nameApp: '${e['app_name_th']}',
                              /* onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detail(
                                    dataDetail: e,
                                    path: path!,
                                  ),
                                ),
                              ),*/
                              onTap: () =>
                                  MyFuction().getdata(e['id'], context),
                              //nameDev: 'nameDev',
                              rateApp: e['rating'],
                              android: e['link_android'] == null ? false : true,
                              windows: e['link_windows'] == null ? false : true,
                              ios: e['link_ios'] == null ? false : true,
                              iconApp: '$path/${e['icon']}',
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  MyWidget.buildSizedBox('h', 10),
                  Column(
                    children: applications
                        .map(
                          (app) => List.from(app['relation_groups']).isEmpty
                              ? Container(
                                  width: 0,
                                  height: 0,
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            '${app['group_name']}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1,
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              140,
                                        ),
                                        ElevatedButton(
                                          onPressed: () => gotoMorePage(
                                            List.from(app['relation_groups']),app['group_name']
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.navigate_next),
                                              Text('ดูเพิ่ม'),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.from(
                                                app['relation_groups'])
                                            .map(
                                              (e) => MyItemApp(
                                                onTap: () => MyFuction()
                                                    .getdata(
                                                        e['application_groups']
                                                            ['id'],
                                                        context),
                                                nameApp:
                                                    '${e['application_groups']['app_name_th']}',
                                                //nameDev: 'nameDev',
                                                rateApp: e['application_groups']
                                                    ['rating'],
                                                android: e['application_groups']
                                                            ['link_android'] ==
                                                        null
                                                    ? false
                                                    : true,
                                                windows: e['application_groups']
                                                            ['link_windows'] ==
                                                        null
                                                    ? false
                                                    : true,
                                                ios: e['application_groups']
                                                            ['link_ios'] ==
                                                        null
                                                    ? false
                                                    : true,
                                                iconApp:
                                                    '$path/${e['application_groups']['icon']}',
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                    MyWidget.buildSizedBox('h', 10),
                                  ],
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
