import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onde_app/model/formborrowmodel.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/myunitity.dart';
import 'package:onde_app/service/mywidget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'addformborrow.dart';

class FormBorrow extends StatefulWidget {
  const FormBorrow({Key? key}) : super(key: key);

  @override
  _FormBorrowState createState() => _FormBorrowState();
}

class _FormBorrowState extends State<FormBorrow> {
  List<GetFormBorrowModel> _getFormBorrow = [];

  Future _getDataFormBorrow() async {
    await ConnectAPI().get('get-all-form-borrow').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          _getFormBorrow = getFormBorrowModelFromJson(
              jsonEncode(jsonDecode(value.body)['data']));
          //print(_dataPractice[0].name);
        });
      }
      //this.setDataAddress();
    });
  }

  Future _sendAuditorForm(int id) async {
    await ConnectAPI()
        .postHeaders(jsonEncode({"id": id}), 'sent-auditor-form-borrow')
        .then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        _getDataFormBorrow();
        MyWidget.showInSnackBarContext('ทำรายการสำเร็จ', Colors.white, context,
            MyColors.colorText_bule, 3, Icons.check_circle);
      } else {
        MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white, context,
            Colors.redAccent, 2, Icons.close);
      }
      //this.setDataAddress();
    }).catchError((onError) {
      MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white, context,
          Colors.redAccent, 2, Icons.close);
    });
  }

  @override
  void initState() {
    this._getDataFormBorrow();
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
                text: 'รายการแบบคำขอยืม',
              ),
              Mysutitle(
                text: 'รายการแบบคำขอยืมอุปกรณ์และเครื่องมือ ฯ (ทก.01)',
                vertical: 5,
              ),
              MyWidget.buildSizedBox('h', 5),
              Column(
                children: _getFormBorrow.map((e) {
                  int no = _getFormBorrow.indexOf(e) + 1;
                  return MycardList(
                      no: '$no',
                      num: '${e.id}',
                      unit: '1 หน่วย',
                      name: '${e.objective}',
                      onTapSend: () => _sendAuditorForm(e.id!.toInt()),
                      url: e.id.toString(),
                      sendStatus: e.sendStatus == '0' ? true : false,
                      startdate:
                          '${DateFormat('dd-MM-yyyy HH:mm:ss').format(e.createdAt!.toLocal())}',
                      enddate: e.sendDate == null
                          ? 'ร่าง'
                          : '${DateFormat('dd-MM-yyyy HH:mm:ss').format(e.sendDate!.toLocal())}');
                }).toList(),
              ),
              MyWidget.buildSizedBox('h', 10),
              Mybtn(
                text: 'สร้างแบบ ทก.01',
                color: Colors.green,
                ontap: () => Navigator.push(
                  context,
                  Unitity.materialPageRoute(
                    AddFormBorrow(),
                  ),
                ).then((value){
                  if(value??false){
                    _getDataFormBorrow();
                    MyWidget.showInSnackBarContext('ทำรายการสำเร็จ', Colors.white, context,
                        MyColors.colorText_bule, 3, Icons.check_circle);
                  }
                }),
              ),
              MyWidget.buildSizedBox('h', 10),
            ],
          ),
        ),
      ),
    );
  }
}

class MycardList extends StatelessWidget {
  final String no, num, unit, name, startdate, enddate, url;
  final bool? sendStatus;
  final Function()? onTapSend;

  const MycardList({
    Key? key,
    required this.no,
    required this.num,
    required this.unit,
    required this.name,
    required this.startdate,
    required this.enddate,
    this.sendStatus,
    required this.url,
    this.onTapSend,
  }) : super(key: key);

  Future<void> _gotoWeb(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
              children: [
                Text('ลำดับ: $no   เลขที่: $num'),
              ],
            ),
            MyWidget.buildSizedBox('h', 20),
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
            MyWidget.buildSizedBox('h', 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'วัน/เวลา ที่สร้าง',
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      Text('$startdate',
                          style: Theme.of(context).textTheme.subtitle),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                Expanded(
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
                ),
              ],
            ),
            MyWidget.buildSizedBox('h', 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: MyColors.colorText_bule,
                  child: IconButton(
                    onPressed: () =>
                        _gotoWeb(ConnectAPI.urlBASE + "pdf/" + url),
                    splashRadius: 20,
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                    ),
                  ),
                ),
                MyWidget.buildSizedBox('w', 10),
                CircleAvatar(
                  backgroundColor:
                      sendStatus! ? Colors.green : MyColors.colorText_bule,
                  child: IconButton(
                    onPressed: sendStatus! ? onTapSend : null,
                    splashRadius: 20,
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
