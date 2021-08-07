import 'package:flutter/material.dart';
import 'package:onde_app/page/firstpage.dart';
import 'package:onde_app/page/login.dart';
import 'package:onde_app/page/profile.dart';
import 'package:onde_app/page/register.dart';

class mydrawer extends StatelessWidget {
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

  menuIsLogin(BuildContext context) {
    return Column(
      children: [
        mylisticon(
          text: 'ข้อมูลส่วนตัว',
          ontap: () {
            Navigator.pop(context);
            gotopage(Profile());
          },
        ),
        mylisticon(
          text: 'ระบบยืมอุปกรณ์',
        ),
        mylisticon(
          text: 'กรอกแบบคำขอยืม/รับอุปกรณ์',
        ),
        mylisticon(
          text: 'ผลการพิจารณา',
        ),
        mylisticon(
          text: 'ส่งคืนอุปกรณ์',
        ),
        mylisticon(
          text: 'แจ้งปัญหาการใช้งาน',
        ),
        mylisticon(
          text: 'ตอบแบบสอบถาม',
        ),
        mylisticon(
          text: 'ระบบตรวจสอบสิทธิ',
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
            gotopage(Resister());
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
