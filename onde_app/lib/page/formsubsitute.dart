import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onde_app/model/Substitutemodel.dart';
import 'package:onde_app/model/getsubstitute.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/page/profile.dart';
import 'package:onde_app/service/getDataAddress.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/mydropdown.dart';
import 'package:onde_app/service/mytextfild.dart';
import 'package:onde_app/service/myunitity.dart';
import 'package:onde_app/service/mywidget.dart';
import 'package:onde_app/service/validate.dart';

import 'fuction.dart';

class FormSubstitute extends StatefulWidget {
  final bool? statusEdit;
  final Datum? data;

  const FormSubstitute({Key? key, this.statusEdit, this.data}) : super(key: key);

  @override
  _FormSubstituteState createState() => _FormSubstituteState();
}

class _FormSubstituteState extends State<FormSubstitute> {
  MyDataAddress _myDataAddress = MyDataAddress();
  DataSubstituteModel _substituteModel = DataSubstituteModel();
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  Future setDataAddress() async {
    await MyFunction.getPrefix().then((value) {
      setState(() {
        _myDataAddress.dataPrefixName = value;
      });
    });

    await MyFunction.getRelated().then((value) {
      setState(() {
        _myDataAddress.dataRelated = value;
      });
    });

    await MyFunction.getProvince().then((value) {
      setState(() {
        _myDataAddress.dataProvince = value;
      });
    });

    if (_substituteModel.province?.isNotEmpty ?? false) {
      _substituteModel.idProvince = await _myDataAddress.dataProvince
          .where((element) => element['name_th'] == _substituteModel.province)
          .first['id'];
      setState(() {});
    }

    await MyFunction.getDistrict(_substituteModel.idProvince).then((value) {
      setState(() {
        _myDataAddress.dataDistrict = value;
      });
    });

    if (_substituteModel.district?.isNotEmpty ?? false) {
      _substituteModel.idDistrict = await _myDataAddress.dataDistrict
          .where((element) => element['name_th'] == _substituteModel.district)
          .first['id'];
      setState(() {});
    }

    await MyFunction.getSubDistrict(_substituteModel.idDistrict).then((value) {
      setState(() {
        _myDataAddress.dataSubDistrict = value;
      });
    });

    if (_substituteModel.subDistrict?.isNotEmpty ?? false) {
      _substituteModel.idSubDistrict = await _myDataAddress.dataSubDistrict
          .where(
              (element) => element['name_th'] == _substituteModel.subDistrict)
          .first['id'];
      setState(() {});
      await MyFunction.getZipcode(_substituteModel.idSubDistrict).then((value) {
        setState(() {
          _substituteModel.postalCode.text = value.toString();
          //print(value);
        });
      });
    }
    await MyFunction.getEducationLevel().then((value) {
      setState(() {
        _myDataAddress.dataEducation = value;
        //print(value);
      });
    });

    //print(_myDataAddress.dataPrefixName);
  }

  Future<void> sendSubstitute() async {
    //print(jsonEncode(modelData.toJson()));
    if (_keyForm.currentState!.validate()) {
      _substituteModel.userId = await ConnectAPI.prefer.then((pre)=>jsonDecode(pre.getString('user').toString())['id']);
      await ConnectAPI()
          .postHeaders(
              jsonEncode(_substituteModel.toJson()), 'create-substitute')
          .then((value) async {
        if (value.statusCode == 200&&jsonDecode(value.body)['status'] == true) {
          Navigator.pop(context,true);
          //print(value.body);
        } else {
          MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white,
              context, Colors.redAccent, 2, Icons.close);
        }
      }).catchError((onError) {
        MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white, context,
            Colors.redAccent, 2, Icons.close);
      });
    }
  }
  checkEdit(){
    if(widget.statusEdit?? false){
      this.updateSubstitute();
    }else{
      sendSubstitute();
    }
  }

  Future<void> updateSubstitute() async {
    //print(jsonEncode(modelData.toJson()));
    if (_keyForm.currentState!.validate()) {
      await ConnectAPI()
          .postHeaders(
          jsonEncode(_substituteModel.toJson()), 'update-substitute')
          .then((value) async {
        if (value.statusCode == 200) {
          Navigator.pop(context,true);
        } else {
          MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white,
              context, Colors.redAccent, 2, Icons.close);
        }
      }).catchError((onError) {
        MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white, context,
            Colors.redAccent, 2, Icons.close);
      });
    }
  }

  @override
  void initState() {
    if(widget.statusEdit??false == true){
      //print();
      this.setDataAddress();
      _substituteModel.setText(widget.data!.toJson());
    }else{
      this.setDataAddress();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _keyForm,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Mytitle(
                    text: 'เพิ่มรายละเอียดผู้ยื่นคำขอแทน',
                  ),
                  Mysutitle(
                    text: 'ข้อมูลผู้ยื่นคำขอแทนคนพิการ',
                    vertical: 5,
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: 'นาง',
                    title: 'คำนำหน้าชื่อ',
                    edit: true,
                    widget: mydropdown(
                      listdata: _myDataAddress.dataPrefixName
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e.toString(),
                                style: Theme.of(context).textTheme.body1,
                              ),
                            ),
                          )
                          .toList(),
                      validator: MyValidate.checkEmptySelect,
                      onChanged: (value) {
                        setState(() {
                          _substituteModel.title = value;
                          //statusChanged = true;
                        });
                      },
                      label: 'คำนำหน้าชื่อ',
                      value: _substituteModel.title,
                    ),
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _substituteModel.firstName.text,
                    edit: true,
                    widget: MyTextfFieldNopading(
                      controller: _substituteModel.firstName,
                      hintText: 'ชื่อ',
                      labelText: 'ชื่อ',
                      validator: MyValidate.checkEmpty,
                    ),
                    title: 'ชื่อ',
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _substituteModel.lastName.text,
                    title: 'นามสกุล',
                    edit: true,
                    widget: MyTextfFieldNopading(
                      controller: _substituteModel.lastName,
                      validator: MyValidate.checkEmpty,
                      hintText: 'นามสกุล',
                      labelText: 'นามสกุล',
                    ),
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _substituteModel.related ?? '',
                    title: 'เกี่ยวข้องเป็น',
                    edit: true,
                    widget: mydropdown(
                      listdata: _myDataAddress.dataRelated
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                e.toString(),
                                style: Theme.of(context).textTheme.body1,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _substituteModel.related = value;
                          //statusChanged = true;
                        });
                      },
                      label: 'เกี่ยวข้องเป็น',
                      validator: MyValidate.checkEmptySelect,
                      value: _substituteModel.related,
                    ),
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _substituteModel.proxyDate.text,
                    title: 'หนังสือมอบอำนาจลงวันที่',
                    edit: true,
                    widget: MyTextfFieldNopading(
                      labelText: 'หนังสือมอบอำนาจลงวันที่',
                      hintText: 'หนังสือมอบอำนาจลงวันที่',
                      controller: _substituteModel.proxyDate,
                      validator: MyValidate.checkEmpty,
                      onTap: () {
                        DateTime _data = DateTime(1993);
                        Unitity.selectDate(context, _data).then((value) {
                          if (value != null) {
                            setState(() {
                              _substituteModel.proxyDate.text =
                                  DateFormat('yyyy-MM-dd').format(value);
                              //statusChanged = true;
                            });
                          }
                        });
                      },
                      readOnly: true,
                    ),
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _substituteModel.birthday.text,
                    title: 'วันเกิด',
                    edit: true,
                    widget: MyTextfFieldNopading(
                      labelText: 'วันเกิด',
                      hintText: 'วันเกิด',
                      controller: _substituteModel.birthday,
                      validator: MyValidate.checkEmpty,
                      onTap: () {
                        DateTime _data = DateTime(1993);
                        Unitity.selectDate(context, _data).then((value) {
                          if (value != null) {
                            setState(() {
                              _substituteModel.birthday.text =
                                  DateFormat('yyyy-MM-dd').format(value);
                              //statusChanged = true;
                            });
                          }
                        });
                      },
                      readOnly: true,
                    ),
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _substituteModel.citizenId.text,
                    title: 'เลขบัตรประชาชน',
                    widget: MyTextfFieldNopading(
                      controller: _substituteModel.citizenId,
                      validator: MyValidate.checkEmpty,
                      labelText: 'เลขบัตรประชาชน',
                      hintText: 'เลขบัตรประชาชน',
                      maxLength: 13,
                    ),
                    edit: true,
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _substituteModel.houseNo.text,
                    title: 'บ้านเลขที่',
                    widget: MyTextfFieldNopading(
                      controller: _substituteModel.houseNo,
                      //validator: MyValidate.checkEmpty,
                      labelText: 'บ้านเลขที่',
                      hintText: 'บ้านเลขที่',
                    ),
                    edit: true,
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _substituteModel.villageNo.text,
                    title: 'หมู่ที่',
                    widget: MyTextfFieldNopading(
                      controller: _substituteModel.villageNo,
                      //validator: MyValidate.checkEmpty,
                      labelText: 'หมู่ที่',
                      hintText: 'หมู่ที่',
                    ),
                    edit: true,
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _substituteModel.lane.text,
                    title: 'ซอย',
                    widget: MyTextfFieldNopading(
                      controller: _substituteModel.lane,
                      labelText: 'ซอย',
                      hintText: 'ซอย',
                    ),
                    edit: true,
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _substituteModel.province ?? '',
                    title: 'จังหวัด',
                    widget: mydropdown(
                      listdata: _myDataAddress.dataProvince
                          .map(
                            (e) => DropdownMenuItem(
                              value: e['name_th'],
                              child: Text(
                                e['name_th'].toString(),
                                style: Theme.of(context).textTheme.body1,
                              ),
                            ),
                          )
                          .toList(),
                      validator: MyValidate.checkEmptySelect,
                      onChanged: (value) {
                        setState(() {
                          _substituteModel.province = value;
                          _substituteModel.district = null;
                          _substituteModel.subDistrict = null;
                          _substituteModel.postalCode.text = '';
                          //statusAddress = true;
                          setDataAddress();
                        });
                      },
                      label: 'จังหวัด',
                      value: _substituteModel.province,
                    ),
                    edit: true,
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _substituteModel.district ?? '',
                    title: 'อำเภอ',
                    widget: mydropdown(
                      listdata: _myDataAddress.dataDistrict
                          .map(
                            (e) => DropdownMenuItem(
                              value: e['name_th'],
                              child: Text(
                                e['name_th'].toString(),
                                style: Theme.of(context).textTheme.body1,
                              ),
                            ),
                          )
                          .toList(),
                      validator: MyValidate.checkEmptySelect,
                      onChanged: (value) {
                        _substituteModel.subDistrict = null;
                        _substituteModel.district = value;
                        setDataAddress();
                        //statusAddress = true;
                        setState(() {});
                      },
                      label: 'อำเภอ/เขต',
                      value: _substituteModel.district,
                    ),
                    edit: true,
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _substituteModel.subDistrict ?? '',
                    title: 'ตำบล',
                    widget: mydropdown(
                      listdata: _myDataAddress.dataSubDistrict
                          .map(
                            (e) => DropdownMenuItem(
                              value: e['name_th'],
                              child: Text(
                                e['name_th'].toString(),
                                style: Theme.of(context).textTheme.body1,
                              ),
                            ),
                          )
                          .toList(),
                      validator: MyValidate.checkEmptySelect,
                      onChanged: (value) {
                        //_addressModel.postalCode.clear();
                        _substituteModel.subDistrict = value;
                        //statusAddress = true;
                        setDataAddress();
                        setState(() {});
                      },
                      label: 'กรุณาเลือกตำบล/แขวง',
                      value: _substituteModel.subDistrict,
                    ),
                    edit: true,
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _substituteModel.postalCode.text,
                    title: 'รหัสไปรษณีย์',
                    edit: true,
                    widget: MyTextfFieldNopading(
                      readOnly: true,
                      controller: _substituteModel.postalCode,
                      hintText: 'รหัสไปรษณีย์',
                      labelText: 'รหัสไปรษณีย์',
                      validator: MyValidate.checkEmpty,
                    ),
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _substituteModel.degree ?? '',
                    title: 'ระดับการศึกษา',
                    edit: true,
                    widget: mydropdown(
                      listdata: _myDataAddress.dataEducation
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.toString(),
                                style: Theme.of(context).textTheme.body1,
                              ),
                            ),
                          )
                          .toList(),
                      //validator: MyValidate.checkEmptySelect,
                      onChanged: (value) {
                        _substituteModel.degree = value;
                        //statusAddress = true;
                        setState(() {});
                      },
                      label: 'ระดับการศึกษา',
                      value: _substituteModel.degree,
                    ),
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _substituteModel.eduPlace.text,
                    title: 'สถานศึกษา',
                    edit: true,
                    widget: MyTextfFieldNopading(
                      //readOnly: true,
                      controller: _substituteModel.eduPlace,
                      hintText: 'สถานศึกษา',
                      labelText: 'สถานศึกษา',
                    ),
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _substituteModel.tel.text,
                    title: 'เบอร์โทร',
                    edit: true,
                    widget: MyTextfFieldNopading(
                      //readOnly: true,
                      controller: _substituteModel.tel,
                      hintText: 'เบอร์โทร',
                      labelText: 'เบอร์โทร',
                    ),
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _substituteModel.email.text,
                    title: 'อีเมล์',
                    edit: true,
                    widget: MyTextfFieldNopading(
                      //readOnly: true,
                      controller: _substituteModel.email,
                      validator: MyValidate.checkTextEmailNoEmy,
                      hintText: 'อีเมล์',
                      labelText: 'อีเมล์',
                    ),
                  ),
                  MyWidget.buildSizedBox('h', 18),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Mybtn(
                    text: 'ยืนยัน',
                    ontap: () => checkEdit(),
                    color: Color(0xffFA601B),
                  ),
                ),
                MyWidget.buildSizedBox('w', 10),
                Expanded(
                  child: Mybtn(
                    text: 'ยกเลิก',
                    ontap: () =>Navigator.pop(context),
                    color: Color(0xffFA601B),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
