import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onde_app/model/practicemodel.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/page/formpractice.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/myunitity.dart';
import 'package:onde_app/service/mywidget.dart';

class Practice extends StatefulWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  _PracticeState createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  List<DataPractice> _dataPractice = [];

  Future _getDataPractice() async {
    await ConnectAPI().get('practice').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          _dataPractice = getPracticeModelFromJson(value.body).data ?? [];
          print(_dataPractice[0].name);
        });
      }
      //this.setDataAddress();
    });
  }



  @override
  void initState() {
    this._getDataPractice();
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
                text: 'ลงทะเบียนความต้องการฝึกอบรมการใช้อุปกรณ์/เครื่องมือ',
              ),
              /*Mysutitle(
                text: 'อุปกรณ์และเครื่องมือคงเหลือทั้งหมด 2,591 รายการ',
                vertical: 5,
              ),*/
              MyWidget.buildSizedBox('h', 20),
              Mytexth2(
                text: 'รายการฝึกอบรม',
                onTap: () {},
                onbtn: true,
              ),
              MyWidget.buildSizedBox('h', 20),
              Mybtn(
                text: 'ลงทะเบียนความต้องการฝึกอบรม',
                ontap: () {
                  //setgoto();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FromPractice(),
                    ),
                  ).then((value) {
                    if (value ?? false) {
                      _getDataPractice();
                      MyWidget.showInSnackBarContext(
                          'ทำรายการสำเร็จ',
                          Colors.white,
                          context,
                          MyColors.colorText_bule,
                          2,
                          Icons.check_circle);
                    }
                  });
                },
              ),
              MyWidget.buildSizedBox('h', 15),
              Column(
                children: _dataPractice.map(
                  (e) {
                    int index = _dataPractice.indexOf(e);
                    return Mylistcross(
                      onTab: () {
                        Navigator.push(
                          context,
                          Unitity.materialPageRoute(
                            FromPractice(
                              isForm: true,
                              dataPractice: e,
                            ),
                          ),
                        );
                      },
                      title: '${index + 1}. ${e.name}',
                      datetime: e.createdAt == null
                          ? 'ไม่มีข้อมูลวันที่'
                          : DateFormat('yyyy-MM-dd HH:mm:ss')
                              .format(e.createdAt!),
                    );
                  },
                ).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Mylistcross extends StatelessWidget {
  final String title, datetime;
  final void Function()? onTab;

  const Mylistcross({
    Key? key,
    required this.title,
    required this.datetime,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              //color: Colors.black12,
              width: MediaQuery.of(context).size.width - 150,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$title'),
                  Text('  $datetime'),
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
}
