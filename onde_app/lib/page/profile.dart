import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onde_app/model/addressmodel.dart';
import 'package:onde_app/model/profilemodel.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/page/fuction.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/mydropdown.dart';
import 'package:onde_app/service/mytextfild.dart';
import 'package:onde_app/service/myunitity.dart';
import 'package:onde_app/service/mywidget.dart';
import 'package:onde_app/service/validate.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  ProfileModel _profileModel = ProfileModel();
  AddressModel _addressModel = AddressModel();
  String? nameDisabilityType = '';
  List<Map<String, dynamic>> disabilityType = [];
  bool editProfile = false,
      statusChanged = false,
      editAddress = false,
      statusAddress = false;
  List dataPrefixName = [];
  List dataProvince = [];
  List dataDistrict = [];
  List dataSubDistrict = [];
  List dataEducation = [];
  List dataEducDistrict = [];

  //GlobalKey<ScaffoldState> _keyScaffold = GlobalKey<ScaffoldState>();

  Future<void> getProfile() async {
    await ConnectAPI().get('get-profile').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          _profileModel.setText(jsonDecode(value.body)['data']);
          _addressModel.setText(jsonDecode(value.body)['data']['profile']);
          // print(_addressModel.toJson());
        });
      }
    });
    await getDisabilityType();
  }

  Future<void> getDisabilityType() async {
    await ConnectAPI().get('disability-type').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          disabilityType =
              List<Map<String, dynamic>>.from(jsonDecode(value.body)['data']);
        });
      }
    });
    await findDisabilityType(_profileModel.disabilityTypeId!);
  }

  findDisabilityType(int id) async {
    setState(() {});
    var data = disabilityType.firstWhere((element) => element['id'] == id);
    nameDisabilityType = data['description'];
  }

  textChanged(String? value) {
    print(value);
    setState(() {
      statusChanged = true;
    });
  }

  textAddress(String? value) {
    //print(value);
    setState(() {
      statusAddress = true;
    });
  }

  Future<void> sendUpdateProfile() async {
    //print(jsonEncode(modelData.toJson()));
    await ConnectAPI()
        .postHeaders(_profileModel.toJson(), 'update-profile-information')
        .then((value) async {
      if (value.statusCode == 200) {
        MyWidget.showInSnackBarContext('บันทึกสำเร็จ', Colors.white, context,
            MyColors.colorText_bule, 2, Icons.check_circle);
        statusChanged = false;
        this.getProfile();
      } else {
        MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white, context,
            Colors.redAccent, 2, Icons.close);
      }
    }).catchError((onError) {
      MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white, context,
          Colors.redAccent, 2, Icons.close);
    });
  }


  Future<void> sendUpdateAddress() async {
    //print(jsonEncode(modelData.toJson()));
    if(_keyForm.currentState!.validate()){
      await ConnectAPI()
          .postHeaders(jsonEncode(_addressModel.toJson()), 'update-profile-address')
          .then((value) async {
        if (value.statusCode == 200) {
          MyWidget.showInSnackBarContext('บันทึกสำเร็จ', Colors.white, context,
              MyColors.colorText_bule, 2, Icons.check_circle);
          statusAddress = false;
          this.getProfile();
        } else {
          MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white, context,
              Colors.redAccent, 2, Icons.close);
        }
      }).catchError((onError) {
        MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white, context,
            Colors.redAccent, 2, Icons.close);
      });
    }
  }

  Future setData() async {
    await MyFunction.getPrefix().then((value) {
      setState(() {
        dataPrefixName = value;
      });
    });
    await MyFunction.getProvince().then((value) {
      setState(() {
        dataProvince = value;
        //

        //print(idProvice);
      });
    });
    _addressModel.idProvince = await dataProvince
        .where((element) => element['name_th'] == _addressModel.province)
        .first['id'];
    setState(() {});

    await MyFunction.getDistrict(_addressModel.idProvince).then((value) {
      setState(() {
        dataDistrict = value;
      });
    });
    if (_addressModel.district != null) {
      _addressModel.idDistrict = await dataDistrict
          .where((element) => element['name_th'] == _addressModel.district)
          .first['id'];
      setState(() {});
    }
    await MyFunction.getSubDistrict(_addressModel.idDistrict).then((value) {
      setState(() {
        dataSubDistrict = value;
      });
    });
    if (_addressModel.subDistrict != null) {
      _addressModel.idSubDistrict = await dataSubDistrict
          .where((element) => element['name_th'] == _addressModel.subDistrict)
          .first['id'];
      setState(() {});
    }

    await MyFunction.getZipcode(_addressModel.idSubDistrict).then((value) {
      setState(() {
        _addressModel.postalCode.text = value.toString();
        //print(value);
      });
    });

    await MyFunction.getEducationLevel().then((value) {
      setState(() {
        dataEducation = value;
        //print(value);
      });
    });
    await this.setAddressEduc();
  }

  setAddressEduc() async {
    _addressModel.idEduProvince = await dataProvince
        .where((element) => element['name_th'] == _addressModel.eduProvine)
        .first['id'];
    setState(() {});

    await MyFunction.getDistrict(_addressModel.idEduProvince).then((value) {
      setState(() {
        dataEducDistrict = value;
      });
    });
  }

  @override
  void initState() {
    this.getProfile();
    this.setData();
    // this.getDisabilityType();
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
                text: 'จัดการข้อมูลส่วนตัว',
              ),
              Mysutitle(
                text: 'ข้อมูลคนพิการ',
                vertical: 5,
              ),
              MyWidget.buildSizedBox('h', 18),
              Mybtn(
                text: 'เพิ่มข้อมูลคู่สมรส',
                ontap: () {},
              ),
              MyWidget.buildSizedBox('h', 18),
              Mytexth2(
                text: 'ข้อมูลส่วนตัว',
                statusEdit: editProfile,
                onClose: () {
                  setState(() {
                    editProfile = false;
                  });
                },
                onTap: statusChanged || !editProfile
                    ? () {
                        setState(() {
                          editProfile = true;
                        });
                        if (statusChanged == true) {
                          sendUpdateProfile();
                          setState(() {
                            editProfile = !editProfile;
                          });
                        }
                      }
                    : null,
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _profileModel.title ?? '',
                title: 'คำนำหน้าชื่อ',
                edit: editProfile,
                widget: mydropdown(
                  listdata: dataPrefixName
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
                      _profileModel.title = value;
                      statusChanged = true;
                    });
                  },
                  label: 'คำนำหน้าชื่อ',
                  value: _profileModel.title,
                ),
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _profileModel.firstName.text,
                edit: editProfile,
                widget: MyTextfFieldNopading(
                  hintText: 'ชื่อ',
                  controller: _profileModel.firstName,
                  validator: MyValidate.checkEmpty,
                  onChanged: textChanged,
                ),
                title: 'ชื่อ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _profileModel.lastName.text,
                title: 'นามสกุล',
                edit: editProfile,
                widget: MyTextfFieldNopading(
                  hintText: 'นามสกุล',
                  controller: _profileModel.lastName,
                  onChanged: textChanged,
                  validator: MyValidate.checkEmpty,
                ),
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _profileModel.birthday.text.isEmpty
                    ? ''
                    : DateFormat('dd MMM yyyy').format(
                        DateTime.parse(_profileModel.birthday.text).toLocal(),
                      ),
                edit: editProfile,
                widget: MyTextfFieldNopading(
                  hintText: 'วันเกิด',
                  readOnly: true,
                  onTap: () {
                    DateTime _data = DateTime(1993);
                    Unitity.selectDate(context, _data).then((value) {
                      if (value != null) {
                        setState(() {
                          _profileModel.birthday.text =
                              DateFormat('yyyy-MM-dd').format(value);
                          statusChanged = true;
                        });
                      }
                    });
                  },
                  controller: _profileModel.birthday,
                  validator: MyValidate.checkEmpty,
                ),
                title: 'วันเกิด',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: Unitity.buildTextCitizenId(_profileModel.citizenId.text),
                title: 'เลขบัตรประชาชน',
                edit: editProfile,
                widget: MyTextfFieldNopading(
                  onChanged: textChanged,
                  hintText: 'เลขบัตรประชาชน',
                  controller: _profileModel.citizenId,
                  maxLength: 13,
                  validator: MyValidate.checkEmptyIdCard,
                ),
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: Unitity.buildTextCitizenId(_profileModel.pwdId.text),
                title: 'บัตรประจำตัวคนพิการ',
                edit: editProfile,
                widget: MyTextfFieldNopading(
                  hintText: 'บัตรประจำตัวคนพิการ',
                  controller: _profileModel.pwdId,
                  onChanged: textChanged,
                  maxLength: 13,
                  validator: MyValidate.checkEmptyIdCard,
                ),
              ),
              //MyWidget.buildSizedBox('h', 18),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _profileModel.email.text,
                title: 'อีเมล',
                edit: editProfile,
                widget: MyTextfFieldNopading(
                  hintText: 'อีเมล',
                  controller: _profileModel.email,
                  onChanged: textChanged,
                  maxLength: 13,
                  validator: MyValidate.checkTextEmail,
                ),
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _profileModel.gender == 1 ? 'ชาย' : 'หญิง',
                title: 'เพศ',
                edit: editProfile,
                widget: mydropdown(
                  onChanged: (value) {
                    _profileModel.gender = value;
                    statusChanged = true;
                    setState(() {});
                  },
                  value: _profileModel.gender,
                  label: 'กรุณาเลือกเพศ',
                  listdata: [
                    DropdownMenuItem<int>(
                      value: 1,
                      child: Text(
                        'ชาย',
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                    DropdownMenuItem<int>(
                      value: 2,
                      child: Text(
                        'หญิง',
                        style: Theme.of(context).textTheme.body1,
                      ),
                    ),
                  ],
                ),
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: nameDisabilityType!,
                title: 'ประเภทคนพิการ',
                edit: editProfile,
                widget: mydropdown(
                    onChanged: (value) {
                      _profileModel.disabilityTypeId = value;
                      statusChanged = true;
                      setState(() {});
                    },
                    value: _profileModel.disabilityTypeId,
                    label: 'กรุณาเลือกเพศ',
                    listdata: disabilityType
                        .map(
                          (e) => DropdownMenuItem<int>(
                            value: e['id'],
                            child: Text(
                              e['description'],
                              style: Theme.of(context).textTheme.body1,
                            ),
                          ),
                        )
                        .toList()),
              ),
              MyWidget.buildSizedBox('h', 18),
              Mytexth2(
                text: 'ที่อยู่',
                statusEdit: editAddress,
                onClose: () {
                  setState(() {
                    editAddress = false;
                  });
                },
               /* onTap: statusAddress || !editAddress
                    ? () {
                        setState(() {
                          editAddress = true;
                        });
                        if (statusAddress == true) {
                          //sendUpdateProfile();
                          sendUpdateAddress();
                          setState(() {
                            editAddress = !editAddress;
                          });
                        }
                      }
                    : null,*/
                onTap: statusAddress || !editAddress
                    ? () {
                  setState(() {
                    editAddress = true;
                  });
                  if (statusAddress == true) {
                    sendUpdateAddress();
                    setState(() {
                      editAddress = !editAddress;
                    });
                  }
                }
                    : null,
              ),
              Form(
                key: _keyForm,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: _addressModel.houseNo.text,
                      edit: editAddress,
                      widget: MyTextfFieldNopading(
                        controller: _addressModel.houseNo,
                        labelText: "บ้านเลขที่",
                        onChanged: textAddress,
                      ),
                      title: 'บ้านเลขที่',
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: _addressModel.villageNo.text,
                      title: 'หมู่ที่',
                      edit: editAddress,

                      widget: MyTextfFieldNopading(
                        onChanged: textAddress,
                        controller: _addressModel.villageNo,
                        labelText: "หมู่ที่",
                      ),
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: _addressModel.lane.text,
                      title: 'ซอย/ถนน',
                      edit: editAddress,
                      widget: MyTextfFieldNopading(
                        controller: _addressModel.lane,
                        onChanged: textAddress,
                        labelText: "ซอย/ถนน",
                      ),
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: _addressModel.province ?? '',
                      title: 'จังหวัด',
                      edit: editAddress,
                      widget: mydropdown(
                        listdata: dataProvince
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
                        onChanged: (value) {
                          setState(() {
                            _addressModel.province = value;
                            _addressModel.district = null;
                            _addressModel.subDistrict = null;
                            statusAddress = true;
                            setData();
                          });
                        },
                        label: 'จังหวัด',
                        value: _addressModel.province,
                      ),
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: _addressModel.district ?? '',
                      title: 'อำเภอ/เขต',
                      edit: editAddress,
                      widget: mydropdown(
                        listdata: dataDistrict
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
                        onChanged: (value) {
                          //_addressModel.subDistrict = null;
                          _addressModel.district = value;
                          setData();
                          statusAddress = true;
                          setState(() {});
                        },
                        label: 'อำเภอ/เขต',
                        value: _addressModel.district,
                      ),
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: _addressModel.subDistrict ?? '',
                      title: 'ตำบล/แขวง',
                      edit: editAddress,
                      widget: mydropdown(
                        listdata: dataSubDistrict
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
                        onChanged: (value) {
                          //_addressModel.postalCode.clear();
                          _addressModel.subDistrict = value;
                          statusAddress = true;
                          setData();
                          setState(() {});
                        },
                        label: 'กรุณาเลือกตำบล/แขวง',
                        value: _addressModel.subDistrict,
                      ),
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: _addressModel.postalCode.text,
                      title: 'รหัสไปรษณีย์',
                      edit: editAddress,
                      widget: mytextfield(
                        hintText: 'รหัสไปรษณีย์',
                        labelText: "รหัสไปรษณีย์",
                        readOnly: true,
                        controller: _addressModel.postalCode,
                        validator: MyValidate.checkEmpty,
                      ),
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: _addressModel.eduLevel ?? '',
                      title: 'กำลังศึกษาระดับ',
                      edit: editAddress,
                      widget: mydropdown(
                        listdata: dataEducation
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
                        onChanged: (value) {
                          _addressModel.eduLevel = value;
                          statusAddress = true;
                          setState(() {});
                        },
                        label: 'กำลังศึกษาระดับ',
                        value: _addressModel.eduLevel,
                      ),
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: _addressModel.eduPlace.text,
                      title: 'สถานศึกษา',
                      edit: editAddress,

                      widget: mytextfield(
                        onChanged: textAddress,
                        controller: _addressModel.eduPlace,
                        labelText: 'สถานศึกษา',
                      ),
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: _addressModel.eduProvine ?? '',
                      title: 'จังหวัด',
                      edit: editAddress,
                      widget: mydropdown(
                        listdata: dataProvince
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
                        onChanged: (value) {
                          setState(() {
                            _addressModel.eduProvine = value;
                            _addressModel.eduDistrict = null;
                            statusAddress = true;
                            setAddressEduc();
                          });
                        },
                        label: 'จังหวัด',
                        value: _addressModel.eduProvine,
                      ),
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: _addressModel.eduDistrict ?? '',
                      title: 'อำเภอ',
                      edit: editAddress,
                      widget: mydropdown(
                        listdata: dataEducDistrict
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
                        onChanged: (value) {
                          setState(() {
                            _addressModel.eduDistrict = value;
                            statusAddress = true;
                          });
                        },
                        label: 'อำเภอ',
                        value: _addressModel.eduDistrict,
                      ),
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: _addressModel.tel.text,
                      title: 'เบอร์โทร',
                      edit: editAddress,
                      widget: mytextfield(
                        controller: _addressModel.tel,
                        onChanged: textAddress,
                        labelText: 'เบอร์โทร',
                        maxLength: 10,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /*buildTextCitizenId(String? test) {
    String text = '';
    if (test!.isNotEmpty) {
      text += '${test.substring(0, 1)}-';
      text += '${test.substring(1, 5)}-';
      text += '${test.substring(5, 10)}-';
      text += '${test.substring(10, 12)}-';
      text += '${test.substring(12, 13)}';
    }
    return text;
  }*/
}

class body extends StatelessWidget {
  final String title, text;
  final bool edit;
  final Widget? widget;

  const body({
    Key? key,
    required this.title,
    required this.text,
    this.edit = false,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: edit ? 1 : 2,
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              '$title : ',
              textAlign: TextAlign.end,
              //style: Theme.of(context).textTheme.subtitle,
            ),
          ),
        ),
        MyWidget.buildSizedBox('w', 10),
        Expanded(
          flex: edit ? 2 : 2,
          child: edit
              ? widget!
              : Container(
                  alignment: Alignment.centerLeft,
                  //width: MediaQuery.of(context).size.width - 200,
                  //color: Colors.black12,
                  child: Text(
                    '$text',
                    maxLines: 2,
                    //style: Theme.of(context).textTheme,
                  ),
                ),
        )
      ],
    );
  }
}
