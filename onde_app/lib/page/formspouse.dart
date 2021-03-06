import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onde_app/model/Substitutemodel.dart';
import 'package:onde_app/model/getsubstitute.dart';
import 'package:onde_app/model/spousemodel.dart';
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

class FormSpouse extends StatefulWidget {
  //final bool? statusEdit;
  final int? idSubstitute;
  final Spouse? data;

  const FormSpouse({Key? key, this.idSubstitute, this.data}) : super(key: key);

  @override
  _FormSpouseState createState() => _FormSpouseState();
}

class _FormSpouseState extends State<FormSpouse> {
  MyDataAddress _myDataAddress = MyDataAddress();
  SpouseModel _spouseModelModel = SpouseModel();
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _keyScaffold = GlobalKey<ScaffoldState>();
  bool statusForm = true;

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

    if (_spouseModelModel.provinceId != null) {
      _spouseModelModel.province = await _myDataAddress.dataProvince
          .where((element) => element['id'] == _spouseModelModel.provinceId)
          .first['name_th'];
      setState(() {});
    }
    //print(_spouseModelModel.province);
    await MyFunction.getDistrict(_spouseModelModel.provinceId).then((value) {
      setState(() {
        _myDataAddress.dataDistrict = value;
      });
    });

    if (_spouseModelModel.districtId != null) {
      _spouseModelModel.district = await _myDataAddress.dataDistrict
          .where((element) => element['id'] == _spouseModelModel.districtId)
          .first['name_th'];
      setState(() {});
    }

    await MyFunction.getSubDistrict(_spouseModelModel.districtId).then((value) {
      setState(() {
        _myDataAddress.dataSubDistrict = value;
      });
    });

    if (_spouseModelModel.subDistrictId != null) {
      _spouseModelModel.subDistrict = await _myDataAddress.dataSubDistrict
          .where((element) => element['id'] == _spouseModelModel.subDistrictId)
          .first['name_th'];
      setState(() {});
      await MyFunction.getZipcode(_spouseModelModel.subDistrictId)
          .then((value) {
        setState(() {
          _spouseModelModel.postalCode.text = value.toString();
          //print(value);
        });
      });
    }
  }

  Future<void> sendSpouseSubstitute() async {
    //print(jsonEncode(modelData.toJson()));
    _spouseModelModel.substituteId = widget.idSubstitute;
    if (_keyForm.currentState!.validate()) {
      await ConnectAPI()
          .postHeaders(jsonEncode(_spouseModelModel.toJson()),
              'substitute/spouse/create')
          .then((value) async {
            print(value.body);
        if (value.statusCode == 200) {
          //Navigator.pop(context,true);
          setState(() {});
          statusForm = false;
          MyWidget.showInSnackBar('????????????????????????????????????', Colors.white, _keyScaffold,
              MyColors.colorText_bule, 2, Icons.check_circle);
        } else {
          MyWidget.showInSnackBar('??????????????????????????????????????????', Colors.white, _keyScaffold,
              Colors.redAccent, 2, Icons.close);
        }
      }).catchError((onError) {
        MyWidget.showInSnackBar('??????????????????????????????????????????', Colors.white, _keyScaffold,
            Colors.redAccent, 2, Icons.close);
      });
    }
  }

  Future<void> sendSpouseProfile() async {
    //print(jsonEncode(modelData.toJson()));
    //_spouseModelModel.substituteId = widget.idSubstitute;
    if (_keyForm.currentState!.validate()) {
      await ConnectAPI()
          .postHeaders(jsonEncode(_spouseModelModel.toJson()), 'create-spouse')
          .then((value) async {
        if (value.statusCode == 200) {
          //Navigator.pop(context,true);
          setState(() {});
          statusForm = false;
          MyWidget.showInSnackBar('????????????????????????????????????', Colors.white, _keyScaffold,
              MyColors.colorText_bule, 2, Icons.check_circle);
        } else {
          MyWidget.showInSnackBar('??????????????????????????????????????????', Colors.white, _keyScaffold,
              Colors.redAccent, 2, Icons.close);
        }
      }).catchError((onError) {
        MyWidget.showInSnackBar('??????????????????????????????????????????', Colors.white, _keyScaffold,
            Colors.redAccent, 2, Icons.close);
      });
    }
  }

  checkEdit() {
    if(widget.data == null){
      widget.idSubstitute == null
          ? sendSpouseProfile()
          : sendSpouseSubstitute();
    }else{
      widget.idSubstitute == null
          ? this.updateSpouseProfile()
          : this.updateSpouseSubstitute();
    }
    /*if (!statusForm) {

    } else {

    }*/
  }

  Future<void> updateSpouseSubstitute() async {
    //print(jsonEncode(modelData.toJson()));
    _spouseModelModel.substituteId = widget.idSubstitute;
    if (_keyForm.currentState!.validate()) {
      await ConnectAPI()
          .postHeaders(jsonEncode(_spouseModelModel.toJson()),
              'substitute/spouse/update')
          .then((value) async {
        if (value.statusCode == 200) {
          setState(() {});
          statusForm = false;
          MyWidget.showInSnackBar('????????????????????????????????????', Colors.white, _keyScaffold,
              MyColors.colorText_bule, 2, Icons.check_circle);
        } else {
          MyWidget.showInSnackBar('??????????????????????????????????????????', Colors.white, _keyScaffold,
              Colors.redAccent, 2, Icons.close);
        }
      }).catchError((onError) {
        MyWidget.showInSnackBar('??????????????????????????????????????????', Colors.white, _keyScaffold,
            Colors.redAccent, 2, Icons.close);
      });
    }
  }

  Future<void> updateSpouseProfile() async {
    //print(jsonEncode(modelData.toJson()));
    // _spouseModelModel.substituteId = widget.idSubstitute;
    if (_keyForm.currentState!.validate()) {
      await ConnectAPI()
          .postHeaders(jsonEncode(_spouseModelModel.toJson()), 'update-spouse')
          .then((value) async {
        if (value.statusCode == 200) {
          setState(() {});
          statusForm = false;
          MyWidget.showInSnackBar('????????????????????????????????????', Colors.white, _keyScaffold,
              MyColors.colorText_bule, 2, Icons.check_circle);
        } else {
          MyWidget.showInSnackBar('??????????????????????????????????????????', Colors.white, _keyScaffold,
              Colors.redAccent, 2, Icons.close);
        }
      }).catchError((onError) {
        MyWidget.showInSnackBar('??????????????????????????????????????????', Colors.white, _keyScaffold,
            Colors.redAccent, 2, Icons.close);
      });
    }else{
      print(_keyForm.currentState!.validate());
    }
  }

  @override
  void initState() {
    if (widget.data != null) {
      setState(() {
        statusForm = false;
      });
      this.setDataAddress();
      _spouseModelModel.setText(widget.data!.toJson());
    } else {
      this.setDataAddress();
    }
    print(statusForm);
    //this.setDataAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _keyScaffold,
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
                    text: '??????????????????????????????????????????????????????',
                  ),
                  Mysutitle(
                    text: '???????????????????????????????????????',
                    vertical: 5,
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _spouseModelModel.title ?? '-',
                    title: '????????????????????????????????????',
                    edit: statusForm,
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
                          _spouseModelModel.title = value;
                          //statusChanged = true;
                        });
                      },
                      label: '????????????????????????????????????',
                      value: _spouseModelModel.title,
                    ),
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _spouseModelModel.firstName.text,
                    edit: statusForm,
                    widget: MyTextfFieldNopading(
                      controller: _spouseModelModel.firstName,
                      hintText: '????????????',
                      labelText: '????????????',
                      validator: MyValidate.checkEmpty,
                    ),
                    title: '????????????',
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _spouseModelModel.lastName.text,
                    title: '?????????????????????',
                    edit: statusForm,
                    widget: MyTextfFieldNopading(
                      controller: _spouseModelModel.lastName,
                      validator: MyValidate.checkEmpty,
                      hintText: '?????????????????????',
                      labelText: '?????????????????????',
                    ),
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _spouseModelModel.birthday.text.isEmpty
                        ? '-'
                        : DateFormat('dd-MMM-yyyy').format(
                            DateTime.parse(_spouseModelModel.birthday.text),
                          ),
                    title: '?????????????????????',
                    edit: statusForm,
                    widget: MyTextfFieldNopading(
                      labelText: '?????????????????????',
                      hintText: '?????????????????????',
                      controller: _spouseModelModel.birthday,
                      validator: MyValidate.checkEmpty,
                      onTap: () {
                        DateTime _data = DateTime(1993);
                        Unitity.selectDate(context, _data).then((value) {
                          if (value != null) {
                            setState(() {
                              _spouseModelModel.birthday.text =
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
                    text: _spouseModelModel.citizenId.text,
                    title: '??????????????????????????????????????????',
                    widget: MyTextfFieldNopading(
                      controller: _spouseModelModel.citizenId,
                      validator: MyValidate.checkEmpty,
                      labelText: '??????????????????????????????????????????',
                      hintText: '??????????????????????????????????????????',
                      maxLength: 13,
                    ),
                    edit: statusForm,
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _spouseModelModel.houseNo.text,
                    title: '??????????????????????????????',
                    widget: MyTextfFieldNopading(
                      controller: _spouseModelModel.houseNo,
                      validator: MyValidate.checkEmpty,
                      labelText: '??????????????????????????????',
                      hintText: '??????????????????????????????',
                    ),
                    edit: statusForm,
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _spouseModelModel.villageNo.text,
                    title: '?????????????????????',
                    widget: MyTextfFieldNopading(
                      controller: _spouseModelModel.villageNo,
                      validator: MyValidate.checkEmpty,
                      labelText: '?????????????????????',
                      hintText: '?????????????????????',
                    ),
                    edit: statusForm,
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _spouseModelModel.province ?? '-',
                    title: '?????????????????????',
                    widget: mydropdown(
                      listdata: _myDataAddress.dataProvince
                          .map(
                            (e) => DropdownMenuItem(
                              value: e['id'],
                              child: Text(
                                e['name_th'].toString(),
                                style: Theme.of(context).textTheme.body1,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _spouseModelModel.provinceId = value;
                          _spouseModelModel.districtId = null;
                          _spouseModelModel.subDistrictId = null;
                          _spouseModelModel.postalCode.text = '';
                          //statusAddress = true;
                          setDataAddress();
                        });
                      },
                      label: '?????????????????????',
                      value: _spouseModelModel.provinceId,
                    ),
                    edit: statusForm,
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _spouseModelModel.district ?? '-',
                    title: '???????????????',
                    widget: mydropdown(
                      listdata: _myDataAddress.dataDistrict
                          .map(
                            (e) => DropdownMenuItem(
                              value: e['id'],
                              child: Text(
                                e['name_th'].toString(),
                                style: Theme.of(context).textTheme.body1,
                              ),
                            ),
                          )
                          .toList(),
                      validator: MyValidate.checkEmptySelect,
                      onChanged: (value) {
                        _spouseModelModel.subDistrictId = null;
                        _spouseModelModel.districtId = value;
                        _spouseModelModel.postalCode.text = '';
                        setDataAddress();
                        //statusAddress = true;
                        setState(() {});
                      },
                      label: '???????????????/?????????',
                      value: _spouseModelModel.districtId,
                    ),
                    edit: statusForm,
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _spouseModelModel.subDistrict ?? '-',
                    title: '????????????',
                    widget: mydropdown(
                      listdata: _myDataAddress.dataSubDistrict
                          .map(
                            (e) => DropdownMenuItem(
                              value: e['id'],
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
                        _spouseModelModel.subDistrictId = value;
                        //statusAddress = true;
                        setDataAddress();
                        setState(() {});
                      },
                      label: '??????????????????????????????????????????/????????????',
                      value: _spouseModelModel.subDistrictId,
                    ),
                    edit: statusForm,
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _spouseModelModel.postalCode.text,
                    title: '????????????????????????????????????',
                    edit: statusForm,
                    widget: MyTextfFieldNopading(
                      readOnly: true,
                      controller: _spouseModelModel.postalCode,
                      hintText: '????????????????????????????????????',
                      labelText: '????????????????????????????????????',
                    ),
                  ),
                  MyWidget.buildSizedBox('h', 18),
                  body(
                    text: _spouseModelModel.tel.text,
                    title: '????????????????????????',
                    edit: statusForm,
                    widget: MyTextfFieldNopading(
                      //readOnly: true,
                      controller: _spouseModelModel.tel,
                      validator: MyValidate.checkPhoneNotEmpty,
                      maxLength: 10,
                      hintText: '????????????????????????',
                      labelText: '????????????????????????',
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
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Mybtn(
                    text: statusForm ? '??????????????????' : '???????????????',
                    ontap: statusForm
                        ? () => checkEdit()
                        : () {
                            setState(() {
                              statusForm = true;
                            });
                          },
                    color: Color(0xffFA601B),
                  ),
                ),
                MyWidget.buildSizedBox('w', 10),
                Expanded(
                  child: Mybtn(
                    text: '??????????????????',
                    ontap: () => Navigator.pop(context),
                    color: Color(0xffFA601B),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
