import 'package:d4dapp/page/contact.dart';
import 'package:d4dapp/page/login.dart';
import 'package:d4dapp/page/profile.dart';
import 'package:d4dapp/page/register.dart';
import 'package:d4dapp/service/mycolors.dart';
import 'package:d4dapp/service/mywidget.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final bool islogin;
  final getapp, gotohome, getData, setPageContact;

  const MyDrawer({
    Key? key,
    this.islogin = false,
    this.getapp,
    this.gotohome,
    this.getData,
    this.setPageContact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            /*Container(
              height: 100,
              color: MyColors.colorApp,
            ),*/
            AppBar(
              leading: Container(
                height: 0,
                width: 0,
              ),
              centerTitle: false,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("D4D APP PORTAL"),
                  Text(
                    "ศูนย์รวมแอพพลิเคชั่นของผู้พิการ",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              leadingWidth: 0,
            ),
            Container(
              height: 250,
              decoration: BoxDecoration(
                  //color: Colors.black12,
                  image: DecorationImage(
                      image: NetworkImage('https://d4dthai.com/logo-2.png'),
                      fit: BoxFit.fill)),
            ),
            Mylistmenu(
              text: 'หน้าหลัก',
              icon: Icon(Icons.grid_view_rounded),
              onTap: () {
                Navigator.pop(context);
                gotohome();
              },
            ),
            Mylistmenu(
              text: 'อันดับสูงสุด',
              icon: Icon(Icons.assessment),
              onTap: () {
                Navigator.pop(context);
                getapp('sort=desc', 'อันดับสูงสุด', 2);
              },
            ),
            Mylistmenu(
              text: 'มาใหม่',
              icon: Icon(Icons.star),
              onTap: () {
                Navigator.pop(context);
                getData();
              },
            ),
            Mylistmenu(
              text: 'ติดต่อสอบถาม',
              icon: Icon(Icons.quick_contacts_dialer_sharp),
              onTap: () {
                Navigator.pop(context);
                setPageContact(Contact());
              },
              /*onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Contact(),
                ),
              ),*/
            ),
            if (!islogin)
              Mylistmenu(
                text: 'เข้าใช้งานระบบ',
                icon: Icon(Icons.person),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
              ),
            if (!islogin)
              Mylistmenu(
                text: 'สมัครสมาชิก',
                icon: Icon(Icons.person_add_alt_1_rounded),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register(),
                    ),
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}

class Mylistmenu extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final VoidCallback? onTap;

  const Mylistmenu({
    Key? key,
    this.text,
    this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Row(
        children: [
          icon!,
          MyWidget.buildSizedBox('w', 10),
          Text(
            '$text',
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
