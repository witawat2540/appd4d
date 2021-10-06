import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onde_app/model/detailquestionnairesmodel.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/mywidget.dart';

class DetailQuestionnaires extends StatefulWidget {
  final int id;

  const DetailQuestionnaires({Key? key, required this.id}) : super(key: key);

  @override
  _DetailQuestionnairesState createState() => _DetailQuestionnairesState();
}

class _DetailQuestionnairesState extends State<DetailQuestionnaires> {
  DetailQuestionnairesModel? _detailQuestion;
  var quest;
  bool statusBtn = true;
  GlobalKey<ScaffoldState> _keyScaffoldState = GlobalKey<ScaffoldState>();

  Future _getDetailQuestionnaires() async {
    await ConnectAPI().get('get-questionnaire/${widget.id}').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          _detailQuestion = detailQuestionnairesModelFromJson(
              jsonEncode(jsonDecode(value.body)['data'][0]));
          //_detailQuestion = _detailQuestionnaires.questions ?? [];

          quest = {
            'survey_id': _detailQuestion!.id,
            "questions":{}
            //'${data.id}':value,
          };
          _detailQuestion!.questions!.forEach((element) {
            quest['questions'][element.id.toString()] = 0;
            setState(() {});
          });
          print(quest);
        });
      }
      //this.setDataAddress();
    });
  }

  Future sendQuestionnaire() async {
    /*_practiceFormModel.userId = await ConnectAPI.prefer.then((pre) =>
          jsonDecode(pre.getString('user').toString())['id'].toString());
      _keyForm.currentState!.save();*/
    await ConnectAPI()
        .postHeaders(jsonEncode(quest), 'submit-questionnaire')
        .then((value) async {
          print(value.body);
      if (value.statusCode == 200 && jsonDecode(value.body)['status'] == true) {
        /*Navigator.pop(context, true);*/
        MyWidget.showInSnackBar(
          'ทำรายการสำเร็จ',
          Colors.white,
          _keyScaffoldState,
          MyColors.colorText_bule,
          2,
          Icons.check_circle,
        );
        setState(() {
          statusBtn = false;
        });
      } else {
        MyWidget.showInSnackBar('เกิดข้อผิดพลาด', Colors.white,
            _keyScaffoldState, Colors.redAccent, 2, Icons.close);
      }
    }).catchError((onError) {
      MyWidget.showInSnackBar('เกิดข้อผิดพลาด', Colors.white, _keyScaffoldState,
          Colors.redAccent, 2, Icons.close);
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
      key: _keyScaffoldState,
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
                children: _detailQuestion?.questions?.map((data) {
                      int index = _detailQuestion!.questions!.indexOf(data) + 1;
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                '$index. ${data.text}',
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
                                    groupValue: int.parse(
                                        quest['questions'][data.id.toString()].toString()),
                                    title: Text(
                                      "${e['name']}",
                                      style: Theme.of(context).textTheme.body1,
                                    ),
                                    onChanged: (int? value) {
                                      quest['questions']['${data.id}'] = value;
                                      setState(() {});
                                      //print(quest);
                                    },
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      );
                    }).toList() ??
                    [],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Mybtn(
                  text: 'ส่งแบบสอบถาม',
                  ontap:statusBtn ?() =>sendQuestionnaire():null,
                  color: Colors.green,
                ),
              ),
              MyWidget.buildSizedBox('w', 10),
              Expanded(
                child: Mybtn(
                  text: 'ย้อนกลับ',
                  ontap: () => Navigator.pop(context),
                  color: Color(0xffFA601B),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
