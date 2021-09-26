import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onde_app/model/helpdeskmodel.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/page/detailhelpdesks.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/myunitity.dart';
import 'package:onde_app/service/mywidget.dart';

class HelpDesks extends StatefulWidget {
  const HelpDesks({Key? key}) : super(key: key);

  @override
  _HelpDesksState createState() => _HelpDesksState();
}

class _HelpDesksState extends State<HelpDesks> {
  List<GetHelpdeskModel> _getHelpdeskModel = [];

  Future _getDataHelpdesk() async {
    await ConnectAPI().get('get-all-helpdesk').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          _getHelpdeskModel = getHelpdeskModelFromJson(
              jsonEncode(jsonDecode(value.body)['data']));
          //print(_dataPractice[0].name);
        });
      }
      //this.setDataAddress();
    });
  }

  @override
  void initState() {
    _getDataHelpdesk();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyWidget.buildEdgeInsets(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Mytitle(
                text: 'ประวัติการแจ้งปัญหา',
              ),
              Mysutitle(
                text: 'แจ้งปัญหาการใช้งาน',
                vertical: 5,
              ),
              MyWidget.buildSizedBox('h', 20),
              Mytexth2(
                text: 'ข้อมูลประวัติการแจ้งปัญหา',
                onTap: () {},
                onbtn: true,
              ),
              Column(
                children: _getHelpdeskModel.map((e) {
                  int index = _getHelpdeskModel.indexOf(e) + 1;
                  return MyCardHelp(
                    title: '$index. ${e.title}',
                    onTab: () => Navigator.push(
                      context,
                      Unitity.materialPageRoute(
                        DetailHelpDesks(data: e,),
                      ),
                    ),
                    date: e.createdAt == null
                        ? ''
                        : DateFormat('dd MMM yyyy HH:mm:ss')
                            .format(e.createdAt!),
                    status: '${e.status}',
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyCardHelp extends StatelessWidget {
  final String title, date, status;
  final VoidCallback? onTab;

  const MyCardHelp({
    Key? key,
    required this.title,
    required this.date,
    required this.status,
    this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              //color: Colors.black12,
              width: MediaQuery.of(context).size.width - 150,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$title'),
                  Text('$date'),
                  Row(
                    children: [
                      Text('สถานะ : '),
                      Text(
                        '${buildText()}',
                        style: TextStyle(color: buildColor()),
                      ),
                    ],
                  )
                ],
              ),
            ),
            CircleAvatar(
              backgroundColor: MyColors.colorText_bule,
              child: IconButton(
                onPressed: onTab,
                splashRadius: 20,
                icon: Icon(
                  Icons.remove_red_eye_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String buildText() {
    if (status == 'new') {
      return 'แจ้งใหม่';
    } else if (status == 'pending') {
      return 'ดำเนินการ';
    } else {
      return 'เสร็จสิ้น';
    }
  }

  Color buildColor() {
    if (status == 'new') {
      return Colors.red;
    } else if (status == 'pending') {
      return Colors.orange;
    } else {
      return MyColors.colorText_bule;
    }
  }
}
