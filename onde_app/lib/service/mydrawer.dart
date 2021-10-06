import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/page/approval_results.dart';
import 'package:onde_app/page/contract_document.dart';
import 'package:onde_app/page/form_receive.dart';
import 'package:onde_app/page/tutorial.dart';
import 'package:onde_app/page/devicereturn.dart';
import 'package:onde_app/page/docpage.dart';
import 'package:onde_app/page/firstpage.dart';
import 'package:onde_app/page/helpdesks.dart';
import 'package:onde_app/page/helpfaqs.dart';
import 'package:onde_app/page/formborrow.dart';
import 'package:onde_app/page/login.dart';
import 'package:onde_app/page/profile.dart';
import 'package:onde_app/page/questionnaires.dart';
import 'package:onde_app/page/register.dart';
import 'package:onde_app/page/formpractice.dart';
import 'package:onde_app/page/report.dart';
import 'package:onde_app/page/representative.dart';
import 'package:onde_app/page/practice.dart';
import 'package:onde_app/page/rights.dart';
import 'package:onde_app/service/mywidget.dart';

import 'myunitity.dart';

class MyDrawer extends StatefulWidget {
  final gotopage;

  const MyDrawer({Key? key, this.gotopage}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  /*AnimationController? _animationController;

  final DecorationTween decorationTween = DecorationTween(
    begin: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      //border: Border.all(style: BorderStyle.none),
      //borderRadius: BorderRadius.circular(60.0),
      //shape: BoxShape.rectangle,
     */ /* boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x66666666),
          blurRadius: 10.0,
          spreadRadius: 3.0,
          offset: Offset(0, 6.0),
        )
      ],*/ /*
    ),
    end: BoxDecoration(
      */ /*color: const Color(0xFFFFFFFF),
      border: Border.all(
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.zero,*/ /*
      // No shadow.
    ),
  );*/

  /* late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(reverse: false);*/

  @override
  void initState() {
    /*_animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animationController!.addListener(() => setState(() {}));*/

    /*
    TickerFuture tickerFuture = _animationController!.repeat();
    tickerFuture.timeout(Duration(seconds:  3), onTimeout:  () {
      _animationController!.forward(from: 0);
      _animationController!.stop(canceled: true);
    });*/
    super.initState();
  }

  @override
  void dispose() {
    //_animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            height: 500,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 60, bottom: 20, left: 15),
                        color: Colors.white38,
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          'images/logoapp.png',
                          height: 54,
                          width: 100,
                        ),
                      ),
                      mylistnoicon(
                        text: 'หน้าแรก',
                        ontap: () {
                          Navigator.pop(context);
                          widget.gotopage(FirstPage());
                        },
                      ),
                      //menuNotLogin(context)
                      menuIsLogin(context),
                      mylistnoicon(
                        text: 'คนพิการทางการมองเห็น',
                      ),
                      mylistnoicon(
                        text: "ออกจากระบบ",
                        ontap: () {
                          ConnectAPI.prefer.then((value) => value.clear());
                          Navigator.pushAndRemoveUntil(
                              context,
                              Unitity.materialPageRoute(Login()),
                              (route) => false);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  menuIsLogin(BuildContext context) {
    return Column(
      children: [
        mylisticon(
          text: 'ข้อมูลส่วนตัว',
          ontap: () {
            //_controller.stop();
            if (Unitity.indexMenu == 0) {
              setState(() {
                Unitity.indexMenu = null;
              });
            } else {
              setState(() {
                Unitity.indexMenu = 0;
              });
            }
          },
        ),
        Unitity.indexMenu == 0
            ? Column(
                children: [
                  MyListSub(
                    text: 'ข้อมูลคนพิการ',
                    ontap: () {
                      Navigator.pop(context);
                      widget.gotopage(Profile());
                    },
                  ),
                  MyListSub(
                    text: 'ข้อมูลผู้ยื่นคำขอแทน',
                    ontap: () {
                      Navigator.pop(context);
                      widget.gotopage(Representative());
                    },
                  ),
                ],
              )
            : Container(
                width: 0,
                height: 0,
              ),
        mylisticon(
          text: 'ระบบยืมอุปกรณ์',
          ontap: () {
            if (Unitity.indexMenu == 1) {
              setState(() {
                Unitity.indexMenu = null;
              });
            } else {
              setState(() {
                Unitity.indexMenu = 1;
              });
            }
          },
        ),
        Unitity.indexMenu == 1
            ? Column(
                children: [
                  MyListSub(
                    text: 'รายละเอียดอุปกรณ์',
                    ontap: () {
                      Navigator.pop(context);
                      widget.gotopage(Tutorial());
                    },
                  ),
                  MyListSub(
                    text: 'ลงทะเบียนความต้องการฝึกอบรมการใช้อุปกรณ์/เครื่องมือ',
                    ontap: () {
                      Navigator.pop(context);
                      widget.gotopage(Practice());
                    },
                  ),
                  MyListSub(
                    text: 'เอกสารที่เกี่ยวข้อง',
                    ontap: () {
                      Navigator.pop(context);
                      widget.gotopage(DocumentPage());
                    },
                  ),
                ],
              )
            : Container(
                width: 0,
                height: 0,
              ),
        mylisticon(
          text: 'กรอกแบบคำขอยืม/รับอุปกรณ์',
          ontap: () {
            /* Navigator.pop(context);
            widget.gotopage(ListRequest());*/
            if (Unitity.indexMenu == 2) {
              setState(() {
                Unitity.indexMenu = null;
              });
            } else {
              setState(() {
                Unitity.indexMenu = 2;
              });
            }
          },
        ),
        Unitity.indexMenu == 2
            ? Column(
                children: [
                  MyListSub(
                    text: 'แบบคำขอยืมอุปกรณ์ฯ ทก.01',
                    ontap: () {
                      Navigator.pop(context);
                      widget.gotopage(FormBorrow());
                    },
                  ),
                  MyListSub(
                    text: 'แบบคำขอรับอุปกรณ์ฯ ทก.02',
                    ontap: () {
                      Navigator.pop(context);
                      widget.gotopage(FormReceive());
                    },
                  ),

                ],
              )
            : Container(
                width: 0,
                height: 0,
              ),
        mylisticon(
          text: 'ผลการพิจารณา',
          ontap: () {
            if (Unitity.indexMenu == 3) {
              setState(() {
                Unitity.indexMenu = null;
              });
            } else {
              setState(() {
                Unitity.indexMenu = 3;
              });
            }
          },
        ),
        Unitity.indexMenu == 3
            ? Column(
                children: [
                  MyListSub(
                    text: 'แบบสรุปผลการพิจารณาอนุมัติการขอยืมอุปกรณ์ฯ ทก.09',
                    ontap: () {
                      Navigator.pop(context);
                      widget.gotopage(ApprovalResults());
                    },
                  ),
                  MyListSub(
                    text: 'แบบสรุปผลการพิจารณายกเลิกการขอยืมอุปกรณ์ฯ ทก.10',
                    ontap: () {
                      Navigator.pop(context);
                      //widget.gotopage(FormBorrow());
                    },
                  ),
                  MyListSub(
                    text: 'แบบสรุปผลการพิจารณาอนุมัติการขอรับอุปกรณ์ฯ ทก.11',
                    ontap: () {
                      Navigator.pop(context);
                      //widget.gotopage(FormBorrow());
                    },
                  ),
                  MyListSub(
                    text: 'แบบสรุปผลการพิจารณายกเลิกการขอรับอุปกรณ์ฯ ทก.12',
                    ontap: () {
                      Navigator.pop(context);
                      //widget.gotopage(FormBorrow());
                    },
                  ),
                  MyListSub(
                    text: 'แบบสรุปผลการขอยืมอุปกรณ์เสร็จสิ้น',
                    ontap: () {
                      Navigator.pop(context);
                      //widget.gotopage(FormBorrow());
                    },
                  ),
                  MyListSub(
                    text: 'แบบสรุปผลการขอรับอุปกรณ์เสร็จสิ้น',
                    ontap: () {
                      Navigator.pop(context);
                      //widget.gotopage(FormBorrow());
                    },
                  ),
                ],
              )
            : Container(
                width: 0,
                height: 0,
              ),
        mylisticon(
          text: 'ส่งคืนอุปกรณ์',
          ontap: () {
            Navigator.pop(context);
            //gotopage(ContractDocument());
            widget.gotopage(DeviceReturn());
          },
        ),
        mylisticon(
          text: 'แจ้งปัญหาการใช้งาน',
          ontap: () {
            //Navigator.pop(context);
            if (Unitity.indexMenu == 5) {
              setState(() {
                Unitity.indexMenu = null;
              });
            } else {
              setState(() {
                Unitity.indexMenu = 5;
              });
            }
            //gotopage(ContractDocument());
            //widget.gotopage(Report());
          },
        ),
        Unitity.indexMenu == 5
            ? Column(
                children: [
                  MyListSub(
                    text: 'แจ้งปัญหา',
                    ontap: () {
                      Navigator.pop(context);
                      widget.gotopage(Report());
                    },
                  ),
                  MyListSub(
                    text: 'ประวัติการแจ้งปัญหา',
                    ontap: () {
                      Navigator.pop(context);
                      widget.gotopage(HelpDesks());
                    },
                  ),
                  MyListSub(
                    text: 'ปัญหาที่พบบ่อย',
                    ontap: () {
                      Navigator.pop(context);
                      widget.gotopage(HelpFaqs());
                    },
                  ),
                ],
              )
            : Container(
                width: 0,
                height: 0,
              ),
        /*mylisticon(
          text: 'ตอบแบบสอบถาม',
        ),*/
        mylistnoicon(
          text: 'ตอบแบบสอบถาม',
          ontap: () {
            Navigator.pop(context);
            widget.gotopage(Questionnaires());
          },
        ),
        mylistnoicon(
          text: 'ระบบตรวจสอบสิทธิ',
          ontap: () {
            Navigator.pop(context);
            widget.gotopage(RightsPage());
          },
        ),
      ],
    );
  }

  menuNotLogin(BuildContext context) {
    return Column(
      children: [
        mylistnoicon(
          text: 'เข้าสู่ระบบ',
          ontap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
            //gotopage(FirstPage());
          },
        ),
        mylistnoicon(
          text: 'สมัครสมาชิก',
          ontap: () {
            Navigator.pop(context);
            widget.gotopage(Resister());
          },
        ),
      ],
    );
  }
}

class mylistnoicon extends StatelessWidget {
  final String? text;
  final VoidCallback? ontap;

  const mylistnoicon({
    Key? key,
    this.text,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      title: Text(
        '$text',
        style: Theme.of(context).textTheme.body1,
      ),
      onTap: ontap,
    );
  }
}

class mylisticon extends StatelessWidget {
  final String? text;
  final VoidCallback? ontap;

  const mylisticon({
    Key? key,
    this.text,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$text',
            style: Theme.of(context).textTheme.body1,
          ),
          Icon(Icons.navigate_next)
        ],
      ),
      onTap: ontap,
    );
  }
}

class MyListSub extends StatelessWidget {
  final String? text;
  final VoidCallback? ontap;

  const MyListSub({
    Key? key,
    this.text,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyWidget.buildSizedBox('w', 10),
          Icon(Icons.navigate_next),
          MyWidget.buildSizedBox('w', 10),
          Container(
            width: MediaQuery.of(context).size.width - 230,
            child: Text(
              '$text',
              //maxLines: 1,
              style: Theme.of(context).textTheme.body1,
            ),
          )
          //Icon(Icons.navigate_next)
        ],
      ),
      onTap: ontap,
    );
  }
}

/*class mydrawer extends StatelessWidget {
  final gotopage;

  const mydrawer({
    Key? key,
    this.gotopage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 60, bottom: 20, left: 15),
                    color: Colors.white38,
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'images/logoapp.png',
                      height: 54,
                      width: 100,
                    ),
                  ),
                  mylistnoicon(
                    text: 'หน้าแรก',
                    ontap: () {
                      Navigator.pop(context);
                      gotopage(FirstPage());
                    },
                  ),
                  //menuNotLogin(context)
                  menuIsLogin(context)
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(bottom: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    mylistnoicon(
                      text: 'คนพิการทางการมองเห็น',
                    ),
                    mylistnoicon(
                      text: "ออกจากระบบ",
                      ontap: () {
                        ConnectAPI.prefer.then((value) => value.clear());
                        Navigator.pushAndRemoveUntil(
                            context,
                            Unitity.materialPageRoute(Login()),
                            (route) => false);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}

*/
