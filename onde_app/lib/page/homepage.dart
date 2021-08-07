import 'package:flutter/material.dart';
import 'package:onde_app/page/firstpage.dart';
import 'package:onde_app/service/mydrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget page = FirstPage();


  gotopage(Widget _page){
    setState(() {
      page = _page;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ONDE'),
        centerTitle: true,
      ),
      drawer: mydrawer(gotopage: gotopage,),
      body: page,
    );
  }
}


