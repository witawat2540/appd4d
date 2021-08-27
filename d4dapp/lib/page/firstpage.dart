import 'dart:async';

import 'package:d4dapp/service/mycolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'homepage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
 /* AnimationController controller;
  Animation heartbeatAnimation;
  String version = '';*/

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
    //startTime();
  }

  /*Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      version = info.version;
    });
  }*/

  void initState() {
    Intl.defaultLocale = 'th_TH';
    super.initState();
   // _initPackageInfo();
    /*Future.delayed(Duration(seconds: 2)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
    });*/
   /* controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    heartbeatAnimation =
        Tween<double>(begin: 150.0, end: 200.0).animate(controller);
    controller.forward().whenComplete(() {
      controller.reverse();*/
      startTime();
   // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff6A58A6),
      body: Center(
        child: Container(child: Image.asset('images/logo.png'),height: 250,),
      ),
    );
  }

}
