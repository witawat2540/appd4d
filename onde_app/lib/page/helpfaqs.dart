import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onde_app/model/helpfaqsModel.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/service/mywidget.dart';

class HelpFaqs extends StatefulWidget {
  const HelpFaqs({Key? key}) : super(key: key);

  @override
  _HelpFaqsState createState() => _HelpFaqsState();
}

class _HelpFaqsState extends State<HelpFaqs> {
  List<GetHelpFaqsModel> _getHelpFaqsModel = [];

  Future _getDataHelpdesk() async {
    await ConnectAPI().get('get-all-faqs').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          _getHelpFaqsModel = getHelpFaqsModelFromJson(
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
                text: 'ปัญหาที่พบบ่อย',
              ),
              Mysutitle(
                text: 'แจ้งปัญหาการใช้งาน',
                vertical: 5,
              ),
              MyWidget.buildSizedBox('h', 20),
              Mytexth2(
                text: 'ฟอร์มบันทึกการแก้ปัญหา',
                onbtn: true,
              ),
              MyWidget.buildSizedBox('h', 5),
              Column(
                children: _getHelpFaqsModel
                    .map(
                      (e) => Card(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ExpansionTile(
                          title: Text(
                            "F: ${e.question}",
                            style: Theme.of(context).textTheme.body1,
                          ),
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          childrenPadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          tilePadding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          expandedAlignment: Alignment.centerLeft,
                          children: <Widget>[
                            Text(
                                "Q: ${e.answer}"),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
