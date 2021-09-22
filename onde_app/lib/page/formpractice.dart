import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onde_app/model/practiceformmodel.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/page/profile.dart';
import 'package:onde_app/service/mydropdown.dart';
import 'package:onde_app/service/mytextfild.dart';
import 'package:onde_app/service/mywidget.dart';
import 'package:onde_app/service/validate.dart';

import 'fuction.dart';

class FromPractice extends StatefulWidget {
  const FromPractice({Key? key}) : super(key: key);

  @override
  _FromPracticeState createState() => _FromPracticeState();
}

class _FromPracticeState extends State<FromPractice> {
  bool isForm = false;
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  PracticeFormModel _practiceFormModel = PracticeFormModel();
  List dataGroupId = [];
  List dataSubGroupId = [];
  List dataCategories = [];

  Future sendPractice() async {
    if (_keyForm.currentState!.validate()) {
      _practiceFormModel.userId = await ConnectAPI.prefer
          .then((pre) => jsonDecode(pre.getString('user').toString())['id']);
      _keyForm.currentState!.save();
    }
  }

  Future setDataGroupId()async{
    await MyFunction.getGroupId().then((value) {
      setState(() {
        dataGroupId = value;
      });
    });
  }
  Future setDataSubGroupId(int mainId)async{
    await MyFunction.getSubGroupId(mainId).then((value) {
      setState(() {
        dataSubGroupId = value;
      });
    });
  }

  Future setCategories(int subId)async{
    await MyFunction.getCategories(forGive: 'ยืม',subId:subId).then((value) {
      setState(() {
        dataCategories = value;
      });
    });
  }

  @override
  void initState() {
    this.setDataGroupId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidget.buildAppBar(),
      body: Container(
        padding: MyWidget.buildEdgeInsets(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Mytitle(
                  text: 'ลงทะเบียนความต้องการฝึกอบรมการใช้อุปกรณ์/เครื่องมือ',
                ),
                MyWidget.buildSizedBox('h', 20),
                Mytexth2(
                  text: 'กรอกข้อมูลลงทะเบียน',
                  onbtn: true,
                ),
                MyWidget.buildSizedBox('h', 20),
                isForm
                    ? Column(
                        children: [
                          body(
                            text: 'วิธีการใช้งานเครื่องพิมพ์อักษรเบรลล์',
                            title: 'ชื่อหลักสตูร',
                          ),
                          MyWidget.buildSizedBox('h', 20),
                          body(
                            text: 'เทคโนโลยีสิ่งอำนวยความสะดวกเพื่อการสื่อสาร',
                            title: 'กลุ่มหลัก',
                          ),
                          MyWidget.buildSizedBox('h', 20),
                          body(
                            text: 'เครื่องพิมพ์อักษรเบรลล์ด้วยระบบคอมพิวเตอร์',
                            title: 'กลุ่มย่อย',
                          ),
                          MyWidget.buildSizedBox('h', 20),
                          body(
                            text: 'EmprintSpotDot',
                            title: 'ชื่ออุปกรณ์',
                          ),
                          MyWidget.buildSizedBox('h', 25),
                          Mybtn(
                            text: 'ย้อนกลับ',
                            ontap: () {
                              setState(() {
                                isForm = false;
                              });
                            },
                          )
                        ],
                      )
                    : buildform(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card buildform(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _keyForm,
          child: Column(
            children: [
              Row(
                children: [
                  Text('กรอกข้อมูลลงทะเบียน'),
                ],
              ),
              MyWidget.buildSizedBox('h', 25),
              mytextfield(
                hintText: 'ชื่อหลักสูตร',
                labelText: 'ชื่อหลักสูตร',
                validator: MyValidate.checkEmpty,
                onSave: (String? value) {
                  setState(() {
                    _practiceFormModel.name = value;
                  });
                },
              ),
              MyWidget.buildSizedBox('h', 25),
              mydropdown(
                label: 'กลุ่มหลัก',
                  listdata: dataGroupId
                      .map(
                        (e) => DropdownMenuItem<int>(
                      value: e['id'],
                      child: Text(
                        e['name'],
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                  )
                      .toList(),
                onChanged: (value) {
                  setState(() {
                    _practiceFormModel.mainGroupsId = value;
                    _practiceFormModel.subGroupsId = null;
                    _practiceFormModel.assetCategoriesId = null;
                    setDataSubGroupId(value);
                  });
                },
                validator: MyValidate.checkEmptySelect,
              ),
              MyWidget.buildSizedBox('h', 25),
              mydropdown(
                label: 'กลุ่มย่อย',
                  listdata: dataSubGroupId
                      .map(
                        (e) => DropdownMenuItem<int>(
                      value: e['id'],
                      child: Text(
                        e['name'],
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                  )
                      .toList(),
                onChanged: (value) {
                  setState(() {
                    _practiceFormModel.subGroupsId = value;
                    _practiceFormModel.assetCategoriesId = null;
                  });
                },
                validator: MyValidate.checkEmptySelect,
              ),
              MyWidget.buildSizedBox('h', 25),
              mydropdown(
                label: 'ชื่ออุปกรณ์',
                listdata: [],
                onChanged: (value) {
                  _practiceFormModel.assetCategoriesId = value;
                },
                validator: MyValidate.checkEmptySelect,
              ),
              MyWidget.buildSizedBox('h', 25),
              Mybtn(
                text: 'ลงทะเบียน',
                ontap: () => sendPractice(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
