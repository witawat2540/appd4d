import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onde_app/model/questionnaire.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/page/practice.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/myunitity.dart';
import 'package:onde_app/service/mywidget.dart';

import 'detailquestionnaires.dart';

class Questionnaires extends StatefulWidget {
  const Questionnaires({Key? key}) : super(key: key);

  @override
  _QuestionnairesState createState() => _QuestionnairesState();
}

class _QuestionnairesState extends State<Questionnaires> {
  List<GetQuestionnaireModel> _dataQuestionnaires = [];

  Future _getDataQuestionnaires() async {
    await ConnectAPI().get('get-all-questionnaire').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          _dataQuestionnaires = getQuestionnaireModelFromJson(
              jsonEncode(jsonDecode(value.body)['data']));
          //print(_dataPractice[0].name);
        });
      }
      //this.setDataAddress();
    });
  }

  @override
  void initState() {
    this._getDataQuestionnaires();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Mytitle(
              text: 'ตอบแบบสอบถาม',
            ),
            MyWidget.buildSizedBox('h', 20),
            Mytexth2(
              text: 'รายการแบบสอบถาม',
              onTap: () {},
              onbtn: true,
            ),
            MyWidget.buildSizedBox('h', 10),
            Column(
              children: _dataQuestionnaires.map((e) {
                int index = _dataQuestionnaires.indexOf(e) + 1;
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
                          width: MediaQuery.of(context).size.width - 150,
                          child: Text('$index. ${e.title}'),
                        ),
                        CircleAvatar(
                          backgroundColor: MyColors.colorText_bule,
                          child: IconButton(
                            onPressed: () => Navigator.push(
                              context,
                              Unitity.materialPageRoute(
                                DetailQuestionnaires(id: e.id!.toInt(),),
                              ),
                            ).then((value){
                              if(value ?? false){

                              }
                            }),
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
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
