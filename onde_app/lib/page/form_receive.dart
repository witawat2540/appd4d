import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onde_app/model/form_receive_model.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/service/mywidget.dart';

import 'formborrow.dart';

class FormReceive extends StatefulWidget {
  const FormReceive({Key? key}) : super(key: key);

  @override
  _FormReceiveState createState() => _FormReceiveState();
}

class _FormReceiveState extends State<FormReceive> {

  GetFormReceiveModel _getFormReceiveModel = GetFormReceiveModel();

  Future _getFormReceive() async {
    await ConnectAPI().get('get-all-form-receive').then((value) {
      if (value.statusCode == 200 && jsonDecode(value.body)['status'] == true) {
        setState(() {
          //String data = jsonEncode(jsonDecode(value.body)['data']);
          _getFormReceiveModel = getFormReceiveModelFromJson(value.body);
        });
      }
      //this.setDataAddress();
    });
  }

  @override
  void initState() {
    _getFormReceive();
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
                text: 'รายการแบบคำขอรับอุปกรณ์และเครื่องมือ ฯ (ทก.02)',
                vertical: 5,
              ),
              MyWidget.buildSizedBox('h', 5),
              Column(
                children: _getFormReceiveModel.data?.map((e){
                  int index =  _getFormReceiveModel.data!.indexOf(e) + 1;
                  return MycardList(
                    no: '$index',
                    num: '${e.form?.id ?? ''}',
                    unit: '1 หน่วย',
                    name: 'อุปกรณ์ ${e.asset ??'0'}',
                    //onTapSend: () => _sendAuditorForm(e.id!.toInt()),
                    url: e.form!.id.toString(),
                    sendStatus: false,
                    startdate:
                    '${DateFormat('dd-MM-yyyy HH:mm:ss').format(e.form!.createdAt!)}',
                    //enddate: '',
                    enddate: e.form!.sendDate == null
                        ? 'ร่าง'
                        : '${DateFormat('dd-MM-yyyy HH:mm:ss').format(e.form!.sendDate!.toLocal())}',
                  );
                }).toList() ?? [],
              )
            ],
          ),
        ),
      ),
    );
  }
}
