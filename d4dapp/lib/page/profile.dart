import 'dart:convert';

import 'package:d4dapp/network/connect.dart';
import 'package:d4dapp/service/mycolors.dart';
import 'package:d4dapp/service/mytextfild.dart';
import 'package:d4dapp/service/mywidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? nationId;
  int provinceId = 0, groupId = 0, gender = 1;
  List<Map<String, dynamic>> nation = [];
  List<Map<String, dynamic>> province = [];
  List<Map<String, dynamic>> group = [];
  Map<String, dynamic> dataProfile = Map<String, dynamic>();
  TextEditingController _name = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _idCard = TextEditingController();
  TextEditingController _birthDate = TextEditingController();
  TextEditingController _email = TextEditingController();
  bool statusBtn = false;
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  //GlobalKey<ScaffoldState> _keyScaffold = GlobalKey<ScaffoldState>();

  Future<void> getProvince() async {
    await ConnectAPI().get('general/provinces').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          province =
              List<Map<String, dynamic>>.from(jsonDecode(value.body)['data']);
        });
      }
    });
  }

  Future<void> getNation() async {
    await ConnectAPI().get('general/nations').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          nation =
              List<Map<String, dynamic>>.from(jsonDecode(value.body)['data']);
        });
      }
    });
  }

  Future<void> getGroup() async {
    await ConnectAPI().get('general/groups').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          group =
              List<Map<String, dynamic>>.from(jsonDecode(value.body)['data']);
        });
      }
    });
  }

  selectDate() async {
    DateTime? select = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if(select != null){
      _birthDate.text = DateFormat('yyyy-MM-dd').format(select);
      setState(() {
        statusBtn = true;
      });
    }
  }

  Future<void> updateProfile() async {
    int idProfile =
        await ConnectAPI.prefer.then((value) => value.getInt('id')!.toInt());
    String data = jsonEncode({
      "id": idProfile,
      "name": _name.text,
      "surname": _lastName.text,
      "citizen_id": _idCard.text == '' ? null : _idCard.text,
      "gender": gender == 0 ? null : gender,
      "group_id": groupId == 0 ? null : groupId,
      "birth_date": _birthDate.text == '' ? null : _birthDate.text,
      "province_id": provinceId == 0 ? null : provinceId,
    });
    if (nationId != 'THA') {
      jsonDecode(data)[''] = nationId;
    }
    //print(data);
    await ConnectAPI().posthaerder(data, 'member/update').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        getProfile();
        MyWidget.showInSnackBarContext('บันทึกสำเร็จ', Colors.white, context,
            MyColors.colorApp, 3, Icons.check_circle);
        statusBtn = false;
        setState(() {});
      } else {
        MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white, context,
            Colors.redAccent, 3, Icons.error);
      }
    }).catchError((onError) {
      MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white, context,
          Colors.redAccent, 3, Icons.error);
    });
  }

  Future<void> getProfile() async {
    print(dataProfile['nation_id']);
    int idProfile =
        await ConnectAPI.prefer.then((value) => value.getInt('id')!.toInt());
    await ConnectAPI().get('member/' + idProfile.toString()).then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          dataProfile =
              Map<String, dynamic>.from(jsonDecode(value.body)['data']);
        });
        _name.text = dataProfile['name'];
        _birthDate.text = dataProfile['birth_date'] ?? '';
        _idCard.text = dataProfile['citizen_id'] ?? '';
        _lastName.text = dataProfile['surname'] ?? '';
        _email.text = dataProfile['email'] ?? '';
        groupId = dataProfile['group_id'] ?? 0;
        gender = dataProfile['gender'] ?? 0;
        provinceId = dataProfile['province_id'] ?? 0;
        nationId = dataProfile['nation_id'] ?? 'THA';
      }
    });
  }

  setValueText(String? value) {
    if (value!.length > 0) {
      setState(() {
        statusBtn = true;
      });
    }
  }

  @override
  void initState() {
    this.getProvince();
    this.getNation();
    this.getGroup();
    this.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          child: Form(
            key: _keyForm,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Text(
                  'แก้ไขข้อมูลส่วนตัว',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .apply(color: MyColors.colorApp, fontWeightDelta: 20),
                ),
                MyWidget.buildSizedBox('h', 20),
                mytextfield(
                  labelText: 'ชื่อ',
                  //obscureText: true,
                  onChanged: setValueText,
                  controller: _name,
                  validator: MyWidget.checkEmtyText,
                  prefixIcon: Icon(Icons.person),
                ),
                MyWidget.buildSizedBox('h', 20),
                mytextfield(
                  labelText: 'นามสกุล',
                  controller: _lastName,
                  //obscureText: true,
                  onChanged: setValueText,
                  prefixIcon: Icon(Icons.person),
                ),
                MyWidget.buildSizedBox('h', 20),
                mytextfield(
                  labelText: 'เลขที่ประจำตัวประชาชน',
                  controller: _idCard,
                  onChanged: setValueText,
                  //obscureText: true,
                  prefixIcon: Icon(Icons.credit_card),
                ),
                MyWidget.buildSizedBox('h', 20),
                MyDropdown(
                  hintText: 'กรุณาเลือกประเภทความพิการ',
                  labelText: 'กรุณาเลือกประเภทความพิการ',
                  value: groupId == 0 ? null : groupId,
                  onChanged: (value) {
                    setState(() {
                      groupId = value;
                      statusBtn = true;
                    });
                  },
                  item: group
                      .map(
                        (e) => DropdownMenuItem<int>(
                          value: e['id'],
                          child: Text(
                            e['group_name'].toString(),
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                      )
                      .toList(),
                  prefixIcon: Icon(Icons.accessible_outlined),
                ),
                MyWidget.buildSizedBox('h', 20),
                Row(
                  children: [
                    Text(' เพศ'),
                  ],
                ),
                RadioListTile(
                  value: 1,
                  groupValue: gender,
                  title: Text(
                    'ชาย',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  onChanged: (int? value) {
                    setState(() {
                      gender = value!;
                      statusBtn = true;
                    });
                  },
                ),
                RadioListTile(
                  value: 2,
                  groupValue: gender,
                  title: Text(
                    'หญิง',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  onChanged: (int? value) {
                    setState(() {
                      gender = value!;
                      statusBtn = true;
                    });
                  },
                ),
                MyWidget.buildSizedBox('h', 20),
                mytextfield(
                  //labelText: 'ปีเกิด-เดือน-วัน (ค.ศ)',
                  //obscureText: true,
                  //validator: MyWidget.checkEmtyText,
                  hintText: 'ปีเกิด-เดือน-วัน (ค.ศ)',
                  readOnly: true,
                  controller: _birthDate,
                  onTap: () {
                    selectDate();
                  },
                  prefixIcon: Icon(Icons.date_range_sharp),
                ),
                MyWidget.buildSizedBox('h', 20),
                mytextfield(
                  labelText: 'อีเมล',
                  //obscureText: true,
                  validator: MyWidget.checkEmtyText,
                  onChanged: setValueText,
                  controller: _email,
                  prefixIcon: Icon(Icons.email),
                ),
                MyWidget.buildSizedBox('h', 20),
                Row(
                  children: [
                    Text(' ปัจจุบันคุณอาศัยอยู่'),
                  ],
                ),
                RadioListTile(
                  value: 'THA',
                  groupValue: nationId,
                  title: Text(
                    'ในประเทศไทย',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  onChanged: (String? value) {
                    setState(() {
                      nationId = value!;
                      statusBtn = true;
                    });
                  },
                ),
                RadioListTile(
                  value: '',
                  groupValue: nationId,
                  title: Text(
                    'ต่างประเทศ',
                    style: Theme.of(context).textTheme.body1,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  onChanged: (String? value) {
                    setState(() {
                      nationId = value!;
                      statusBtn = true;
                    });
                  },
                ),
                MyWidget.buildSizedBox('h', 20),
                nationId == 'THA'
                    ? Container(
                        child: MyDropdown(
                          hintText: 'กรุณาเลือกจังหวัดที่คุณพักอาศัย',
                          labelText: 'กรุณาเลือกจังหวัดที่คุณพักอาศัย',
                          value: provinceId == 0 ? null : provinceId,
                          item: province
                              .map((e) => DropdownMenuItem<int>(
                                    value: e['id'],
                                    child: Text(
                                      e['province_name_th'].toString(),
                                      style: Theme.of(context).textTheme.body1,
                                    ),
                                  ))
                              .toList(),
                          prefixIcon: Icon(Icons.location_on),
                          onChanged: (value) {
                            setState(() {
                              provinceId = value;
                              statusBtn = true;
                            });
                          },
                        ),
                      )
                    : Container(
                        child: MyDropdown(
                          hintText: 'กรุณาเลือกประเทศที่คุณพักอาศัย',
                          labelText: 'กรุณาเลือกประเทศที่คุณพักอาศัย',
                          value: nationId == '' ? null : nationId,
                          item: nation
                              .map((e) => DropdownMenuItem<String?>(
                                    value: e['nation_id'],
                                    child: Text(
                                      e['nation_name_th'].toString(),
                                      style: Theme.of(context).textTheme.body1,
                                    ),
                                  ))
                              .toList(),
                          prefixIcon: Icon(Icons.location_on),
                          onChanged: (value) {
                            nationId = value;
                            statusBtn = true;
                          },
                        ),
                      ),
                MyWidget.buildSizedBox('h', 20),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    //onPressed: () => register(),
                    onPressed: statusBtn
                        ? () {
                            if (_keyForm.currentState!.validate())
                              updateProfile();
                          }
                        : null,
                    child: Text('บันทึกข้อมูล'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
                MyWidget.buildSizedBox('h', 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyDropdown extends StatelessWidget {
  final String? labelText, hintText;
  final List<DropdownMenuItem<dynamic>>? item;
  final value;
  final Icon? prefixIcon;
  final String? Function(dynamic)? validator;
  final Function(dynamic)? onChanged;

  const MyDropdown({
    Key? key,
    this.labelText,
    this.hintText,
    required this.item,
    this.prefixIcon,
    this.validator,
    this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      //isDense: false,
      isExpanded: true,
      items: item,
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 13),
        labelStyle: Theme.of(context)
            .textTheme
            .body1!
            .apply(color: MyColors.colorTexthittext),
        //contentPadding: EdgeInsets.all(0),
        hintStyle: TextStyle(color: MyColors.colorTexthittext),
        filled: true,
        fillColor: MyColors.colorText_bule,
        contentPadding:
            new EdgeInsets.symmetric(vertical: 9.0, horizontal: 16.0),
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: BorderSide.none,
        ),
        // border: InputBorder.none,
        //suffixIcon: Icon(suffixIcon),
        prefixIcon: prefixIcon,
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
