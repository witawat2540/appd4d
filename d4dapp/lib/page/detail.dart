import 'dart:convert';

import 'package:d4dapp/network/connect.dart';
import 'package:d4dapp/page/detailtext.dart';
import 'package:d4dapp/page/searchpage.dart';
import 'package:d4dapp/service/my_fuction.dart';
import 'package:d4dapp/service/mycolors.dart';
import 'package:d4dapp/service/mywidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Detail extends StatefulWidget {
  final dataDetail;
  final String path;
  final int countDownload;
  final datauser;
  final datagroup;

  const Detail(
      {Key? key,
      required this.dataDetail,
      required this.path,
      this.countDownload = 0,
      required this.datauser,
      required this.datagroup})
      : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Future<void> gotowebapp(
      String url, int idapp, int iduser, String type) async {
    _launchURL(url);

    await ConnectAPI()
        .posthaerder(
      jsonEncode({
        'member_id': iduser == 0 ? null : iduser,
        "application_id": idapp,
        'device': type
      }),
      'statistics',
    )
        .then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        MyFuction().getdata2(idapp, context);
      }
    });
  }

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        //iconTheme: IconThemeData(color: Colors.black),
        title: Text('D4D Portal App'),
        centerTitle: true,
        actions: [
          IconButton(
            splashRadius: 20,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(),
              ),
            ),
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 8,
                            offset: Offset(0, 5))
                      ],
                      image: DecorationImage(
                        image: NetworkImage(
                            '${widget.path}/${widget.dataDetail['icon']}'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 180,
                    //color: Colors.black12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.dataDetail['app_name_th']}',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'เผยแพร่โดย: ${widget.datauser['departments']['department_name']}',
                          style:
                              TextStyle(fontSize: 14, color: MyColors.colorApp),
                        ),
                        MyWidget.buildSizedBox('h', 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildIcon(),
                            if (widget.dataDetail['specific'] == 1)
                              Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.award,
                                    color: Colors.red,
                                    size: 14,
                                  ),
                                  MyWidget.buildSizedBox('w', 3),
                                  Text(
                                    'ใช้ได้เฉพาะกลุ่ม',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.red),
                                  ),
                                ],
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              MyWidget.buildSizedBox('h', 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      //width: 100,
                      padding: EdgeInsets.all(10),
                      //color: Colors.black12,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text('รองรับ'),
                          MyWidget.buildSizedBox('h', 12),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (widget.dataDetail['link_android'] != null)
                                  FaIcon(
                                    FontAwesomeIcons.googlePlay,
                                    size: 18,
                                  ),
                                if (widget.dataDetail['link_ios'] != null)
                                  MyWidget.buildSizedBox('w', 5),
                                if (widget.dataDetail['link_ios'] != null)
                                  FaIcon(
                                    FontAwesomeIcons.appStoreIos,
                                    size: 18,
                                  ),
                                if (widget.dataDetail['link_windows'] != null)
                                  MyWidget.buildSizedBox('w', 5),
                                if (widget.dataDetail['link_windows'] != null)
                                  FaIcon(
                                    FontAwesomeIcons.windows,
                                    size: 18,
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                     // width: 120,
                      padding: EdgeInsets.all(10),
                      //color: Colors.black12,
                      child: Column(
                        children: [
                          Text('เข้าชม'),
                          MyWidget.buildSizedBox('h', 10),
                          Text('${widget.dataDetail['view_count']} ครั้ง')
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      //width: 120,
                      padding: EdgeInsets.all(10),
                      //color: Colors.black12,
                      child: Column(
                        children: [
                          Text(
                            'เว็บไชต์',
                            style: TextStyle(fontSize: 16),
                          ),
                          MyWidget.buildSizedBox('h', 10),
                          Container(
                            height: 23,
                            child: TextButton(
                              style: ElevatedButton.styleFrom(
                                  //fixedSize: Size(0, 5),
                                  padding: EdgeInsets.all(0)),
                              onPressed: () =>
                                  _launchURL(widget.dataDetail['website']),
                              child: Text(
                                'ไปเว็บ',
                                style: TextStyle(
                                  color: MyColors.colorApp,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black54,
              ),
              MyWidget.buildSizedBox('h', 10),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (widget.dataDetail['link_android'] != null)
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff38ea56),
                            onPrimary: Colors.black,
                          ),
                          onPressed: () => gotowebapp(
                              widget.dataDetail['link_android'],
                              widget.dataDetail['id'],
                              0,
                              'android'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(FontAwesomeIcons.googlePlay),
                              MyWidget.buildSizedBox('w', 10),
                              Text("ติดตั้ง"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (widget.dataDetail['link_ios'] != null)
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => gotowebapp(
                              widget.dataDetail['link_ios'],
                              widget.dataDetail['id'],
                              0,
                              'ios'),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff6c757d),
                            onPrimary: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(FontAwesomeIcons.appStoreIos),
                              MyWidget.buildSizedBox('w', 10),
                              Text("ติดตั้ง"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (widget.dataDetail['link_windows'] != null)
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => gotowebapp(
                              widget.dataDetail['link_windows'],
                              widget.dataDetail['id'],
                              0,
                              'windows'),
                          child: Row(
                            children: [
                              FaIcon(FontAwesomeIcons.windows),
                              MyWidget.buildSizedBox('w', 10),
                              Text("ติดตั้ง"),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              MyWidget.buildSizedBox('h', 10),
              Divider(
                color: Colors.black54,
              ),
              MyWidget.buildSizedBox('h', 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("ความเหมาะสมสำหรับผู้ใช้งาน"),
                ],
              ),
              MyWidget.buildSizedBox('h', 10),
              Column(
                children: List.from(widget.datagroup)
                    .map((e) => MyTextTypeapp(text: e['group_name']))
                    .toList(),
              ),
              MyWidget.buildSizedBox('h', 10),
              Divider(
                color: Colors.black54,
              ),
              //MyWidget.buildSizedBox('h', 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("คำอธิบายเกี่ยวกับแอพลิเคชั่น"),
                  IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailText(
                          path: '${widget.path}/${widget.dataDetail['icon']}',
                          detail: widget.dataDetail['description'],
                          nameapp: widget.dataDetail['app_name_th'],
                        ),
                      ),
                    ),
                    splashRadius: 20,
                    icon: Icon(Icons.navigate_next),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  '${widget.dataDetail['description']}',
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Divider(
                color: Colors.black54,
              ),
              MyWidget.buildSizedBox('h', 10),
              Row(
                children: [
                  Text('ข้อมูลเพิ่มเติม'),
                ],
              ),
              MyWidget.buildSizedBox('h', 10),
              Myinof(
                widget: widget,
                textstart: 'เผยแพร่ศูนย์รวมแอพพลิเคชั่นของผู้พิการ',
                textend: DateFormat('dd-MM-yyyy HH:mm')
                    .format(DateTime.parse(widget.dataDetail['created_at'])),
              ),
              MyWidget.buildSizedBox('h', 20),
              Myinof(
                widget: widget,
                textstart: 'ปรับปรุงข้อมูลล่าสุด',
                textend: DateFormat('dd-MM-yyyy HH:mm')
                    .format(DateTime.parse(widget.dataDetail['updated_at'])),
              ),
              MyWidget.buildSizedBox('h', 20),
              Myinof(
                  widget: widget,
                  textstart: 'คลิ๊กดาวโหลดทั้งหมด',
                  textend: '${widget.countDownload} ครั้ง'),
              MyWidget.buildSizedBox('h', 20),
              Myinof(
                  widget: widget,
                  textstart: 'ผู้ทำการเผยแพร่',
                  textend: '${widget.datauser['name']}'),
              MyWidget.buildSizedBox('h', 20),
              Myinof(
                  widget: widget,
                  textstart: 'หน่วยงาน',
                  textend:
                      '${widget.datauser['departments']['department_name']}'),
              MyWidget.buildSizedBox('h', 20),
              Myinof(
                  widget: widget,
                  textstart: 'รองรับภาษา',
                  textend: buildtextlang()),
              MyWidget.buildSizedBox('h', 20),
            ],
          ),
        ),
      ),
    );
  }

  buildtextlang() {
    String text = '';
    if (widget.dataDetail['domestic'] == null) {
      text += '-';
      text += ' / ';
    } else {
      text += 'ภาษาไทย';
      text += ' / ';
    }
    if (widget.dataDetail['international'] == null) {
      text += '-';
      //text += ' / ';
    } else {
      text += 'ภาษาอังกฤษ';
      //text += ' / ';
    }
    return text;
  }

  buildIcon() {
    return Row(
      children: [
        for (int i = 0; i < widget.dataDetail['rating']; i++)
          Icon(
            Icons.star,
            size: 18,
          ),
        for (int i = 0; i < (5 - widget.dataDetail['rating']); i++)
          Icon(
            Icons.star_border,
            size: 18,
          ),
      ],
    );
  }
}

class MyTextTypeapp extends StatelessWidget {
  final String text;

  const MyTextTypeapp({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: MyColors.colorApp,
            size: 20,
          ),
          MyWidget.buildSizedBox('w', 10),
          Text(
            "$text",
            style: TextStyle(fontSize: 13),
          )
        ],
      ),
    );
  }
}

class Myinof extends StatelessWidget {
  final String textstart, textend;

  const Myinof({
    Key? key,
    required this.widget,
    required this.textstart,
    required this.textend,
  }) : super(key: key);

  final Detail widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          // color: Colors.black12,
          child: Text('$textstart'),
          width: MediaQuery.of(context).size.width - 216,
        ),
        Text(textend)
      ],
    );
  }
}
