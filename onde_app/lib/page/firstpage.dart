import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onde_app/model/dashboardmodel.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/myunitity.dart';
import 'package:onde_app/service/mywidget.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Dashboardmodel _dashboardModel = Dashboardmodel();

  Future<void> getDashboard() async {
    await ConnectAPI().get('dashboard').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          _dashboardModel = dashboardmodelFromJson(value.body);
        });
      }
    });
  }

  @override
  void initState() {
    this.getDashboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'อุปกรณ์และเครื่องมือด้าน ICT สำหรับคนพิการ',
                    style: Theme.of(context)
                        .textTheme
                        .body2!
                        .apply(fontWeightDelta: 1),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    'รายการอุปกรณ์',
                    style: Theme.of(context).textTheme.subtitle,
                  )
                ],
              ),
              MyWidget.buildSizedBox('h', 17),
              Row(
                children: [
                  mycard(
                    color: Color(0xff1CB485),
                    name: 'รายการอุปกรณ์',
                    count:
                        '${Unitity.f.format(_dashboardModel.data?.totalAssets ?? 0)}',
                  ),
                  MyWidget.buildSizedBox('w', 17),
                  mycard(
                    color: Color(0xffE632B6),
                    name: 'สมาชิก',
                    count:
                        '${Unitity.f.format(_dashboardModel.data?.totalUsers ?? 0)}',
                  ),
                ],
              ),
              MyWidget.buildSizedBox('h', 17),
              Row(
                children: [
                  mycard(
                    color: Color(0xffFCAC17),
                    name: 'การยืม',
                    count:
                        '${Unitity.f.format(_dashboardModel.data?.totalBookings ?? 0)}',
                  ),
                  MyWidget.buildSizedBox('w', 17),
                  mycard(
                    color: Color(0xff2C8FE3),
                    name: 'กิจกรรม',
                    count:
                        '${Unitity.f.format(_dashboardModel.data?.totalEvents ?? 0)}',
                  ),
                ],
              ),
              MyWidget.buildSizedBox('h', 17),
              Row(
                children: [
                  Text(
                    'ข่าวสารประชาสัมพันธ์',
                    style: TextStyle(
                        color: MyColors.colorText_label,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  )
                ],
              ),
              MyWidget.buildSizedBox('h', 17),
              Column(
                children: _dashboardModel.data?.news?.map((e) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          image_news(
                            image:
                                '${_dashboardModel.data!.path}/${e.coverName}',
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            width: MediaQuery.of(context).size.width,
                            //color: Colors.black12,
                            child:Text(
                              '${e.title}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          MyWidget.buildSizedBox('h', 17),
                        ],
                      );
                    }).toList() ??
                    [],
              )
              /*image_news(
                image:
                    'https://www.prachachat.net/wp-content/uploads/2020/07/KIT_3164.jpg',
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Text(
                        'สดช.จัดอบรมการสร้างการรับรู้การปฏิบัติตามแผนดำเนิน',
                      ),
                    ],
                  ))*/
            ],
          ),
        ),
      ),
    );
  }
}

class mycard extends StatelessWidget {
  final Color color;
  final String name, count;

  const mycard({
    Key? key,
    required this.color,
    required this.name,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 93,
        padding: EdgeInsets.all(13),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$name',
              style: Theme.of(context)
                  .textTheme
                  .subtitle!
                  .apply(color: Colors.white),
            ),
            Text(
              '$count',
              style:
                  Theme.of(context).textTheme.title!.apply(color: Colors.white),
            ),
          ],
        ),
        decoration: BoxDecoration(
          //color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 6,
              blurRadius: 20,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
          gradient: LinearGradient(
            //begin: Alignment.centerLeft,
            begin: FractionalOffset.topLeft, end: FractionalOffset.bottomRight,
            stops: [0.5, 4],
            colors: [color.withOpacity(.9), color.withOpacity(.4)],
          ),
        ),
      ),
    );
  }
}

class image_news extends StatelessWidget {
  final String image;

  const image_news({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 170,
      decoration: BoxDecoration(
        color: MyColors.colorText_bule,
        image: DecorationImage(
          image: NetworkImage('$image'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
