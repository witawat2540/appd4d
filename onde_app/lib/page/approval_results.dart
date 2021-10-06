import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onde_app/model/approval_results_model.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/service/mywidget.dart';
import 'package:url_launcher/url_launcher.dart';

class ApprovalResults extends StatefulWidget {
  const ApprovalResults({Key? key}) : super(key: key);

  @override
  _ApprovalResultsState createState() => _ApprovalResultsState();
}

class _ApprovalResultsState extends State<ApprovalResults> {
  ApprovalResultsModel _approvalResultsModel = ApprovalResultsModel();

  Future _getApprovalResults() async {
    await ConnectAPI().get('approval-results').then((value) {
      if (value.statusCode == 200 && jsonDecode(value.body)['status'] == true) {
        setState(() {
          //String data = jsonEncode(jsonDecode(value.body)['data']);
          _approvalResultsModel = approvalResultsModelFromJson(value.body);
        });
      }
      //this.setDataAddress();
    });
  }

  Future<void> _gotoWeb(String url) async {
    //print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    this._getApprovalResults();
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
                text: 'ผลการพิจารณา',
              ),
              Mysutitle(
                text: 'แบบสรุปผลการพิจารณาอนุมัติการขอยืมอุปกรณ์ฯ ทก.09',
                vertical: 5,
              ),
              Column(
                children: _approvalResultsModel.data?.map((e) {
                  int index = _approvalResultsModel.data!.indexOf(e) + 1;
                      return MyCardItem(
                        no: '$index',
                        number: '${e.id ?? ''}',
                        name:
                            '${e.category?.name ?? ''}\n${e.asset?.description ?? ''}',
                        unit: '1 หน่วย',
                        id: '${e.asset?.code ?? ''}',
                        startdate: e.approveDate == null
                            ? ''
                            : '${DateFormat('dd MMM yyy HH:mm:ss').format(e.approveDate!.toLocal())}',
                        //enddate: '1 ต.ค. 2563 09:26',
                        onTap: () => _gotoWeb(
                            (_approvalResultsModel.filePath ?? '') +
                                '/' +
                                e.id.toString()),
                      );
                    }).toList() ??
                    [],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyCardItem extends StatelessWidget {
  final String? no, number, name, unit, id, startdate, enddate, nameuser;
  final VoidCallback? onTap;

  const MyCardItem({
    Key? key,
    this.no,
    this.number,
    this.name,
    this.unit,
    this.id,
    this.startdate,
    this.enddate,
    this.nameuser,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [Text("ลำดับ: $no   เลขที่: $number")],
            ),
            MyWidget.buildSizedBox('h', 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 150,
                  //color: Colors.black12,
                  child: Text('$name'),
                ),
                Text('$unit')
              ],
            ),
            MyWidget.buildSizedBox('h', 8),
            Row(
              children: [Text("รหัสอุปกรณ์")],
            ),
            //MyWidget.buildSizedBox('h', 8),
            Row(
              children: [
                Text("$id"),
              ],
            ),
            MyWidget.buildSizedBox('h', 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'วัน/เวลา ที่อนุมัติ',
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      Text('$startdate',
                          style: Theme.of(context).textTheme.subtitle),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                /*Expanded(
                  child: Column(
                    children: [
                      Text(
                        'วัน/เวลา ที่ส่ง',
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      Text('$enddate',
                          style: Theme.of(context).textTheme.subtitle),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),*/
              ],
            ),
            // MyWidget.buildSizedBox('h', 8),
            /*Container(
              width: MediaQuery.of(context).size.width,
              child:
              Text('ผู้ยืม', style: Theme.of(context).textTheme.subtitle),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text('$nameuser',
                  style: Theme.of(context).textTheme.subtitle),
            ),*/
            MyWidget.buildSizedBox('h', 8),
            Container(
              //alignment: Alignment.centerRight,
              width: MediaQuery.of(context).size.width,
              child: Text('เอกสารดาวน์โหลด',
                  style: Theme.of(context).textTheme.subtitle),
            ),
            MyWidget.buildSizedBox('h', 8),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Mybtnred(text: 'ดูเอกสาร', onTap: onTap),
                  /*MyWidget.buildSizedBox('w', 8),
                  Mybtnred(text: 'หนังสือค้ำประกัน', onTap: () {}),
                  MyWidget.buildSizedBox('w', 8),
                  Mybtnred(text: 'แบบฟอร์ม ทก.05', onTap: () {}),*/
                  // MyWidget.buildSizedBox('w', 8),
                ],
              ),
            ),
            /*MyWidget.buildSizedBox('h', 14),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text('ดำเนินการ',
                  style: Theme.of(context).textTheme.subtitle),
            ),
            MyWidget.buildSizedBox('h', 5),
            Row(
              children: [
                Mybtngreen(text: 'อัพโหลดเอกสาร', onTap: () {}),
              ],
            )*/
          ],
        ),
      ),
    );
  }
}

class Mybtngreen extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const Mybtngreen({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        height: 30,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(5), primary: Color(0xff26BA12)),
        child: Text('$text'),
        onPressed: onTap,
      ),
    );
  }
}

class Mybtnred extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const Mybtnred({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        height: 30,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(5), primary: Color(0xffF85C6E)),
        child: Text('$text'),
        onPressed: onTap,
      ),
    );
  }
}
