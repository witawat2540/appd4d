import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/service/mywidget.dart';
import 'package:onde_app/model/disapprovalResultsModel.dart';


class DisapprovalResults extends StatefulWidget {
  const DisapprovalResults({Key? key}) : super(key: key);

  @override
  _DisapprovalResultsState createState() => _DisapprovalResultsState();
}

class _DisapprovalResultsState extends State<DisapprovalResults> {
  disapprovalResultsModel _disapprovalResultsState = disapprovalResultsModel();

  Future _getDisapprovalResults() async {
    await ConnectAPI().get('disapproval-results').then((value) {
      if (value.statusCode == 200 && jsonDecode(value.body)['status'] == true) {
        setState(() {
          _disapprovalResultsState = disapprovalResultsModelModelFromJson(value.body);
          // print(_disapprovalResultsState);
        });
      }
    });
  }

  @override
  void initState() {
    this._getDisapprovalResults();
    super.initState();
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
                text: 'แบบสรุปผลการพิจารณายกเลิกการขอยืมอุปกรณ์ฯ (ทก.10)',
                vertical: 5,
              ),
              Column(
                children: _disapprovalResultsState.data?.map((e) {
                  int index = _disapprovalResultsState.data!.indexOf(e) + 1;
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
                    onTap: () => _gotoWeb(
                        (_disapprovalResultsState.filePath ?? '') +
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
                  child: Text('$name'),
                ),
                Text('$unit')
              ],
            ),
            MyWidget.buildSizedBox('h', 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'วัน/เวลา ที่ถูกยกเลิก',
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      Text('$startdate',
                          style: Theme.of(context).textTheme.subtitle),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ],
            ),
            MyWidget.buildSizedBox('h', 8),
            Container(
              //alignment: Alignment.centerRight,
              width: MediaQuery.of(context).size.width,
              child: Text('เอกสาร ทก.01',
                  style: Theme.of(context).textTheme.subtitle),
            ),
            MyWidget.buildSizedBox('h', 8),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Mybtnred(text: 'ดูเอกสาร', onTap: onTap),
                ],
              ),
            ),
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
