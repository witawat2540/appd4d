import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onde_app/model/detailquestionnairesmodel.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/service/mywidget.dart';

class DetailQuestionnaires extends StatefulWidget {
  final int id;

  const DetailQuestionnaires({Key? key, required this.id}) : super(key: key);

  @override
  _DetailQuestionnairesState createState() => _DetailQuestionnairesState();
}

class _DetailQuestionnairesState extends State<DetailQuestionnaires> {
  DetailQuestionnairesModel? _detailQuestion;

  Future _getDetailQuestionnaires() async {
    await ConnectAPI().get('get-questionnaire/${widget.id}').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          _detailQuestion = detailQuestionnairesModelFromJson(
              jsonEncode(jsonDecode(value.body)['data'][0]));
          //_detailQuestion = _detailQuestionnaires.questions ?? [];
          print(_detailQuestion);
        });
      }
      //this.setDataAddress();
    });
  }

  @override
  void initState() {
    this._getDetailQuestionnaires();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Mytitle(
                text: 'ตอบแบบสอบถาม',
              ),
              MyWidget.buildSizedBox('h', 10),
              Column(
                children: _detailQuestion!.questions!.map((e) {
                  int index = _detailQuestion!.questions!.indexOf(e) + 1;
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            '$index. ${e.text}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          {'value': 5, 'name': 'มากที่สุด'},
                          {'value': 4, 'name': 'มาก'},
                          {'value': 3, 'name': 'ปานกลาง'},
                          {'value': 2, 'name': 'น้อย'},
                          {'value': 1, 'name': 'น้อยที่สุด'},
                        ]
                            .map(
                              (e) => RadioListTile(
                                value: int.parse(e['value'].toString()),
                                groupValue: 0,
                                title: Text(
                                  "${e['name']}",
                                  style: Theme.of(context).textTheme.body1,
                                ),
                                onChanged: (int? value) {},
                              ),
                            )
                            .toList(),
                      )
                    ],
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
