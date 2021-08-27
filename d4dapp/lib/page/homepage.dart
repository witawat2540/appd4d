import 'dart:convert';

import 'package:d4dapp/network/connect.dart';
import 'package:d4dapp/page/pagespitapp.dart';
import 'package:d4dapp/page/profile.dart';
import 'package:d4dapp/page/searchpage.dart';
import 'package:d4dapp/page/selecttypeapp.dart';
import 'package:d4dapp/service/mycolors.dart';
import 'package:d4dapp/service/mydrawer.dart';
import 'package:d4dapp/service/mytextfild.dart';
import 'package:d4dapp/service/mywidget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'contact.dart';
import 'mainpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget page = MainPage();
  int index = 1;
  bool islogin = false;
  List data = [];
  List latest = [];
  String? path;

  Future<void> getapp(String url, title, int _index) async {
    await ConnectAPI().get('get-all-application?$url').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          data = jsonDecode(value.body)['data'];
          path = jsonDecode(value.body)['path'];
          index = _index;
          page = PageSpitApp(
            title: title,
            data: data,
            path: path!,
          );
        });
      }
    });
  }

  Future<void> getData() async {
    await ConnectAPI().get('dashboard').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          latest = jsonDecode(value.body)['latest'];
          path = jsonDecode(value.body)['path_application'];
          index = 3;
          page = PageSpitApp(
            title: 'แอพพลิเคชั่นมาใหม่',
            data: latest,
            path: path!,
          );
          //applications = jsonDecode(value.body)['applications'];
          //print(applications[0]['relation_groups'][0]);
        });
      }
    });
  }

  /*setindex(int index){

  }*/

  Future<void> getappbytype(String url, title) async {
    await ConnectAPI().get('get-all-application/group/$url').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          data = jsonDecode(value.body)['data'];
          path = jsonDecode(value.body)['path'];
          index = 0;
          page = PageSpitApp(
            title: title,
            data: data,
            path: path!,
          );
        });
      }
    });
  }

  gotoSelectApp() async {
    await ConnectAPI().get('get-all-group').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectTypeApp(
              data: jsonDecode(value.body)['data'],
            ),
          ),
        ).then((value) async {
          if (value != null) {
            getappbytype(value['id'].toString(), value['name']);
          }
        });
      }
    });
  }

  gotohome() {
    setState(() {
      index = 1;
      page = MainPage();
    });
  }

  setPageContact(Widget _page){
    setState(() {
      index = 9;
      page = _page;
    });
  }

  checklogin() {
    ConnectAPI.prefer.then((value) {
      setState(() {
        islogin = value.getBool('isLogin') ?? false;
        print(islogin);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    /* ConnectAPI.prefer.then((value) => value.setString('token',
        ''''''));*/
    super.initState();
    checklogin();
    Intl.defaultLocale = 'th_TH';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(
        islogin: islogin,
        getapp: getapp,
        gotohome: gotohome,
        setPageContact: setPageContact,
        getData: getData,
      ),
      appBar: AppBar(
        title: Text('D4D Portal App'),
        centerTitle: true,
        /*title: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: mytextfield(
            hintText: 'ค้นหา',
            suffixIcon: Icons.search,
          ),
          height: 40,
        ),*/
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
          if (islogin)
            /*IconButton(
            splashRadius: 20,
            onPressed: () {},
            icon: Icon(Icons.tune_rounded),
          ),*/
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text("แก้ไขข้อมูลส่วนตัว"),
                  value: 2,
                ),
                PopupMenuItem(
                  child: Text("ออกจากระบบ"),
                  value: 1,
                ),

              ],
              onSelected: (int value) {
               if(value == 2){
                 setPageContact(ProfilePage());
               }else{
                 Navigator.pushAndRemoveUntil(
                     context,
                     MaterialPageRoute(
                       builder: (context) => HomePage(),
                     ),
                         (route) => false);
                 ConnectAPI.prefer.then((value) {
                   value.remove('isLogin');
                   value.remove('id');
                 });
               }
              },
            )
        ],
      ),
      body: Column(
        children: [
          if(index != 9)
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 10),
            //color: Colors.red,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  MyBtnH(
                    text: 'หมวดหมู่',
                    click: index == 0,
                    onPressed: () => gotoSelectApp(),
                  ),
                  Container(
                    width: 2,
                    color: Colors.black45,
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  MyBtnH(
                    text: 'หน้าแรก',
                    click: index == 1,
                    onPressed: () {
                      setState(() {
                        index = 1;
                        page = MainPage();
                      });
                    },
                  ),
                  MyWidget.buildSizedBox('w', 10),
                  MyBtnH(
                    text: 'อันดับสูงสุด',
                    click: index == 2,
                    onPressed: () {
                      setState(() {
                        getapp('sort=desc', 'อันดับสูงสุด', 2);
                      });
                    },
                  ),
                  MyWidget.buildSizedBox('w', 10),
                  MyBtnH(
                    text: 'มาใหม่',
                    click: index == 3,
                    onPressed: () {
                      getData();
                    },
                  ),
                  MyWidget.buildSizedBox('w', 10),
                  MyBtnH(
                    text: 'ใช้ได้เฉพาะกลุ่ม',
                    click: index == 4,
                    onPressed: () {
                      setState(() {
                        //index = 4;
                        getapp('specific=1', 'ใช้ได้เฉพาะกลุ่ม', 4);
                        //page = PageSpitApp();
                      });
                    },
                  ),
                  Container(
                    width: 2,
                    color: Colors.black45,
                    height: 30,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  MyBtnH(
                    text: 'Android',
                    click: index == 5,
                    icon: Icon(Icons.android),
                    onPressed: () {
                      setState(() {
                        index = 5;
                        getapp('android=true', 'Android', 5);
                      });
                    },
                  ),
                  MyWidget.buildSizedBox('w', 10),
                  MyBtnH(
                    text: 'IOS',
                    click: index == 6,
                    icon: FaIcon(
                      FontAwesomeIcons.apple,
                      size: 18,
                    ),
                    onPressed: () {
                      setState(() {
                        index = 6;
                        getapp('ios=true', 'IOS', 6);
                      });
                    },
                  ),
                  MyWidget.buildSizedBox('w', 10),
                  MyBtnH(
                    text: 'Windows',
                    click: index == 7,
                    onPressed: () {
                      setState(() {
                        //index = 7;
                        getapp('windows=true', 'Windows', 7);
                      });
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.windows,
                      size: 18,
                    ),
                    // icon: Icon(Icons.laptop_windows_rounded),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 0.3),
              ),
            ),
          ),
          Expanded(
            child: page,
          )
        ],
      ),
    );
  }
}

class MyBtnH extends StatelessWidget {
  final String text;
  final icon;
  final bool click;
  final VoidCallback? onPressed;

  const MyBtnH({
    Key? key,
    required this.text,
    this.icon,
    this.click = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: click ? MyColors.colorApp : Colors.white,
        onPrimary: click ? Colors.white : Colors.black45,
        side: BorderSide(
          width: 1.0,
          color: Colors.black45,
        ),
      ),
      child: Row(
        children: [
          icon == null
              ? Container(
                  height: 0,
                  width: 0,
                )
              : icon!,
          icon == null
              ? Container(
                  height: 0,
                  width: 0,
                )
              : MyWidget.buildSizedBox('w', 5),
          Text('$text'),
        ],
      ),
    );
  }
}
