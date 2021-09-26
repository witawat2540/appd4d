import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onde_app/model/practiceformmodel.dart';
import 'package:onde_app/model/practicemodel.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/page/profile.dart';
import 'package:onde_app/service/mydropdown.dart';
import 'package:onde_app/service/mytextfild.dart';
import 'package:onde_app/service/mywidget.dart';
import 'package:onde_app/service/validate.dart';

import 'fuction.dart';

class FromPractice extends StatefulWidget {
  final bool isForm;
  final DataPractice? dataPractice;

  const FromPractice({Key? key, this.isForm = false, this.dataPractice})
      : super(key: key);

  @override
  _FromPracticeState createState() => _FromPracticeState();
}

class _FromPracticeState extends State<FromPractice> {
  //bool isForm = false;
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _keyScaffoldState = GlobalKey<ScaffoldState>();
  PracticeFormModel _practiceFormModel = PracticeFormModel();
  List dataGroupId = [];
  List dataSubGroupId = [];
  List dataCategories = [];
  String? nameGroupId,nameSubGroupsId,nameAssetCategoriesId;

  Future sendPractice() async {
    if (_keyForm.currentState!.validate()) {
      _practiceFormModel.userId = await ConnectAPI.prefer.then((pre) =>
          jsonDecode(pre.getString('user').toString())['id'].toString());
      _keyForm.currentState!.save();
      await ConnectAPI()
          .postHeaders(
              practiceFormModelToJson(_practiceFormModel), 'practice/create')
          .then((value) async {
        if (value.statusCode == 200 &&
            jsonDecode(value.body)['status'] == true) {
          Navigator.pop(context, true);
        } else {
          MyWidget.showInSnackBar('เกิดข้อผิดพลาด', Colors.white,
              _keyScaffoldState, Colors.redAccent, 2, Icons.close);
        }
      }).catchError((onError) {
        MyWidget.showInSnackBar('เกิดข้อผิดพลาด', Colors.white,
            _keyScaffoldState, Colors.redAccent, 2, Icons.close);
      });
    }
    /*MyWidget.showInSnackBar('เกิดข้อผิดพลาด', Colors.white,
        _keyScaffoldState, Colors.redAccent, 2, Icons.close);*/
  }

  Future setDataGroupId() async {
    await MyFunction.getGroupId().then((value) {
      setState(() {
        dataGroupId = value;
      });
    });
  }

  Future setDataSubGroupId(int mainId) async {
    await MyFunction.getSubGroupId(mainId).then((value) {
      setState(() {
        dataSubGroupId = value;
      });
    });
  }

  Future setCategories(int subId) async {
    await MyFunction.getCategories(forGive: 'ยืม', subId: subId).then((value) {
      setState(() {
        dataCategories = value;
      });
    });
  }

  setDataIsForm() async {
  await  setDataGroupId();
    nameGroupId = await dataGroupId
        .where((element) => element['id'] == widget.dataPractice!.mainGroupsId).first['name'];

  await  setDataSubGroupId(widget.dataPractice!.mainGroupsId!);
  nameSubGroupsId = await dataSubGroupId
      .where((element) => element['id'] == widget.dataPractice!.subGroupsId).first['name'];

  await  setCategories(widget.dataPractice!.subGroupsId!);
  nameAssetCategoriesId = await dataCategories
      .where((element) => element['id'] == widget.dataPractice!.assetCategoriesId).first['name'];
    //print(nameGroupId);
  }

  @override
  void initState() {
    this.setDataGroupId();
    if (widget.isForm) {
      setDataIsForm();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyScaffoldState,
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
                  text: 'ข้อมูลลงทะเบียน',
                  onbtn: true,
                ),
                MyWidget.buildSizedBox('h', 20),
                widget.isForm
                    ? Column(
                        children: [
                          body(
                            text: '',
                            edit: true,
                            title: 'ชื่อหลักสตูร',
                            widget: Text("${widget.dataPractice?.name ?? ''}"),
                          ),
                          MyWidget.buildSizedBox('h', 20),
                          body(
                            text: '',
                            title: 'กลุ่มหลัก',
                            edit: true,
                            widget: Text(
                                "${nameGroupId ?? 'ไม่มีข้อมูล'}"),
                          ),
                          MyWidget.buildSizedBox('h', 20),
                          body(
                            text: 'เครื่องพิมพ์อักษรเบรลล์ด้วยระบบคอมพิวเตอร์',
                            title: 'กลุ่มย่อย',
                            edit: true,
                            widget: Text(
                                "${nameSubGroupsId ?? 'ไม่มีข้อมูล'}"),
                          ),
                          MyWidget.buildSizedBox('h', 20),
                          body(
                            text: 'EmprintSpotDot',
                            title: 'ชื่ออุปกรณ์',
                            edit: true,
                            widget: Text(
                              "${nameAssetCategoriesId ?? 'ไม่มีข้อมูล'}",
                            ),
                          ),
                          MyWidget.buildSizedBox('h', 25),
                          Mybtn(
                            text: 'ย้อนกลับ',
                            ontap: () {
                              Navigator.pop(context);
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
                    setCategories(value);
                  });
                },
                validator: MyValidate.checkEmptySelect,
              ),
              MyWidget.buildSizedBox('h', 25),
              mydropdown(
                label: 'ชื่ออุปกรณ์',
                listdata: dataCategories
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
