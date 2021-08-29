import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onde_app/model/registormodel.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/page/login.dart';
import 'package:onde_app/page/privacy.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/mydropdown.dart';
import 'package:onde_app/service/mytextfild.dart';
import 'package:onde_app/service/myunitity.dart';
import 'package:onde_app/service/mywidget.dart';
import 'package:onde_app/service/validate.dart';
import 'package:http/http.dart' as http;

class Resister extends StatefulWidget {
  const Resister({Key? key}) : super(key: key);

  @override
  _ResisterState createState() => _ResisterState();
}

class _ResisterState extends State<Resister> {
  GlobalKey<ScaffoldState> _keyScaffoldState = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  Registor modelData = Registor(
      firstName: TextEditingController(),
      citizenId: TextEditingController(),
      cPassword: TextEditingController(),
      email: TextEditingController(),
      lastName: TextEditingController(),
      password: TextEditingController(),
      pwdId: TextEditingController(),
      pwdPic: TextEditingController());
  bool ctCheck = false, statusSave = false;
  List<Map<String, dynamic>> disabilityType = [];
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  String? checkRePassword(String? value) {
    if (value!.isEmpty) {
      return 'กรุณากรอกช่องนี้';
    }
    if (value.length < 8) {
      return 'กรุณากรอกอย่างน้อย 8 ตัว';
    }

    if (value != modelData.password!.text) {
      return 'รหัสผ่านไม่ตรงกัน';
    }
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
  }

  Future<void> sendRegister() async {
    //print(jsonEncode(modelData.toJson()));
    if (_keyForm.currentState!.validate()) {
      setState(() {
        //statusSave = true;
        Unitity.isLoading = true;
      });
      List<Future<MultipartFile>?> image = [];
      if(_image != null){
        image.add(http.MultipartFile.fromPath('pwd_pic', _image!.path));
      }
      await ConnectAPI()
          .httpMultiForm(
              registorToJson(modelData),
              image,
              'register')
          .then((value) async {
        if (value.statusCode == 200) {
          await this.setLoadAndSave();
        } else {
          setState(() {
            //statusSave = true;
            Unitity.isLoading = false;
          });
          MyWidget.showInSnackBar('เกิดข้อผิดพลาด', Colors.white,
              _keyScaffoldState, Colors.redAccent, 2, Icons.close);
        }
      }).catchError((onError) {
        setState(() {
          //statusSave = true;
          Unitity.isLoading = false;
        });
        MyWidget.showInSnackBar('เกิดข้อผิดพลาด', Colors.white,
            _keyScaffoldState, Colors.redAccent, 2, Icons.close);
      });
    }
  }

  Future<void> getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {});
      print(image.path);
      // _image = image;
      modelData.pwdPic!.text = image.path.split('/').last;
    }
  }

  Future setLoadAndSave() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        statusSave = true;
        Unitity.isLoading = false;
      });
    });
    //await setData();
  }

  @override
  void initState() {
    //this.getDisabilityType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _keyScaffoldState,
        appBar: AppBar(
          title: Text('ONDE'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: statusSave
            ? Center(
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 120,
                          color: MyColors.colorText_bule,
                        ),
                        MyWidget.buildSizedBox('h', 20),
                        Text(
                          "ดำเนินการสำเร็จ",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .apply(fontWeightDelta: 20),
                        ),
                        MyWidget.buildSizedBox('h', 10),
                        Text(
                          "โปรดยืนยันอีเมล์ โดยกดปุ่มยืนยันในอีเมล์ที่เราจัดส่งให้ท่าน",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        MyWidget.buildSizedBox('h', 10),
                        Mybtn(
                          text: 'กลับไปหน้า Login',
                          ontap: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Stack(
                children: [
                  Form(
                    key: _keyForm,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                      child: SingleChildScrollView(
                        child: Card(
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                myh(text: 'สมัครสมาชิก'),
                                Mysutitle14(
                                    vertical: 10,
                                    text:
                                        'ระบบบริหารจัดการอุปกรณ์และเครื่องมือด้าน ICT สำหรับคนพิการ'),
                                MyWidget.buildSizedBox('h', 10),
                                Mytexth(
                                  text: "กรอกข้อมูลสำหรับสมัครสมาชิก",
                                ),
                                MyWidget.buildSizedBox('h', 30),
                                mytextfield(
                                  labelText: 'ชื่อ',
                                  controller: modelData.firstName,
                                  keyboardType: TextInputType.text,
                                  validator: MyValidate.checkEmpty,
                                  /*onSave: (String? value){
                        setState(() {
                          modelData.firstName = value;
                        });
                      },*/
                                  hintText: 'ชื่อ',
                                ),
                                MyWidget.buildSizedBox('h', 30),
                                mytextfield(
                                  labelText: 'นามสกุล',
                                  controller: modelData.lastName,
                                  keyboardType: TextInputType.text,
                                  validator: MyValidate.checkEmpty,
                                  /*onSave: (String? value){
                        setState(() {
                          modelData.lastName = value;
                        });
                      },*/
                                  hintText: 'นามสกุล',
                                ),
                                MyWidget.buildSizedBox('h', 30),
                                mytextfield(
                                  labelText: 'อีเมล์',
                                  controller: modelData.email,
                                  keyboardType: TextInputType.emailAddress,
                                  hintText: 'อีเมล์',
                                  validator: MyValidate.checkEmpty,
                                  /* onSave: (String? value){
                        setState(() {
                          modelData.email = value;
                        });
                      },*/
                                ),
                                MyWidget.buildSizedBox('h', 30),
                                MyTextFieldPass(
                                    labelText: 'รหัสผ่าน',
                                    controller: modelData.password,
                                    obscureText: true,
                                    hintText:
                                        'รหัสผ่าน (ไม่น้อยกว่า 8 ตัวอักษร)',
                                    validator: MyValidate.checkEmptyPass,
                                    keyboardType: TextInputType.visiblePassword
                                    /*onSave: (String? value){
                        setState(() {
                          modelData.password!.text = value;
                        });
                      },*/
                                    ),
                                MyWidget.buildSizedBox('h', 30),
                                MyTextFieldPass(
                                  labelText: 'รหัสผ่านอีกครั้ง',
                                  obscureText: true,
                                  controller: modelData.cPassword,
                                  keyboardType: TextInputType.visiblePassword,
                                  hintText: 'รหัสผ่านอีกครั้ง',
                                  validator: checkRePassword,
                                  /*onSave: (String? value){
                        setState(() {
                          modelData.password = value;
                        });
                      },*/
                                ),
                                MyWidget.buildSizedBox('h', 30),
                                mytextfield(
                                  labelText: 'เลขประจำตัวประชาชน',
                                  hintText: 'เลขประจำตัวประชาชน',
                                  keyboardType: TextInputType.number,
                                  maxLength: 13,
                                  controller: modelData.citizenId,
                                ),
                                MyWidget.buildSizedBox('h', 30),
                                mytextfield(
                                  labelText: 'เลขบัตรประจำตัวคนพิการ',
                                  hintText: 'เลขบัตรประจำตัวคนพิการ',
                                  keyboardType: TextInputType.number,
                                  controller: modelData.pwdId,
                                ),
                                MyWidget.buildSizedBox('h', 30),
                                mydropdown(
                                  label: 'เลือกความพิการ',
                                  value: modelData.disabilityTypeId,
                                  listdata: disabilityType
                                      .map(
                                        (e) => DropdownMenuItem<int>(
                                          value: e['id'],
                                          child: Text(
                                            e['description'].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .body1,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {},
                                ),
                                MyWidget.buildSizedBox('h', 30),
                                mytextfield(
                                  labelText: 'แนบบัตรคนพิการ',
                                  hintText: 'แนบบัตรคนพิการ',
                                  controller: modelData.pwdPic,
                                  suffixIcon: Icons.wysiwyg,
                                  onTap: () => getImage(),
                                  readOnly: true,
                                ),
                                MyWidget.buildSizedBox('h', 15),
                                Row(
                                  children: [Text('เพศ')],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 20,
                                      child: Radio(
                                          value: 1,
                                          groupValue: modelData.gender,
                                          onChanged: (int? value) {
                                            setState(() {
                                              modelData.gender = value!;
                                            });
                                          },
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap
                                          //visualDensity: VisualDensity(horizontal: 0),
                                          ),
                                    ),
                                    MyWidget.buildSizedBox('w', 10),
                                    Text('ชาย'),
                                    MyWidget.buildSizedBox('w', 25),
                                    SizedBox(
                                      height: 40,
                                      width: 20,
                                      child: Radio(
                                          value: 2,
                                          groupValue: modelData.gender,
                                          onChanged: (int? value) {
                                            setState(() {
                                              modelData.gender = value!;
                                            });
                                          },
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap
                                          //visualDensity: VisualDensity(horizontal: 0),
                                          ),
                                    ),
                                    MyWidget.buildSizedBox('w', 10),
                                    Text('หญิง')
                                  ],
                                ),
                                MyWidget.buildSizedBox('h', 5),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      child: Checkbox(
                                        value: ctCheck,
                                        side: BorderSide(
                                            color: MyColors.colorTexthittext,
                                            width: 1.5),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            ctCheck = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    MyWidget.buildSizedBox('w', 10),
                                    Text(
                                      'ยอมรับ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle!
                                          .apply(
                                              color:
                                                  MyColors.colorTextsubtitle),
                                    ),
                                    //MyWidget.buildSizedBox('w', 10),
                                    Container(
                                      padding: EdgeInsets.only(top: 5),
                                      height: 25,
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            fixedSize: Size(30, 10),
                                            padding: EdgeInsets.all(0.0)),
                                        onPressed: () => Navigator.push(
                                          context,
                                          Unitity.materialPageRoute(
                                            Privacy(),
                                          ),
                                        ),
                                        child: Text(
                                          "นโยบาย",
                                          style: TextStyle(
                                            shadows: [
                                              Shadow(
                                                  color:
                                                      MyColors.colorText_bule,
                                                  offset: Offset(0, -3))
                                            ],
                                            color: Colors.transparent,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                MyColors.colorText_bule,
                                            decorationThickness: 2,
                                            decorationStyle:
                                                TextDecorationStyle.solid,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                MyWidget.buildSizedBox('h', 15),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            fixedSize: Size(0, 60)),
                                        onPressed: ctCheck
                                            ? () => sendRegister()
                                            : null,
                                        child: Text('ยืนยัน'),
                                      ),
                                    ),
                                    MyWidget.buildSizedBox('w', 30),
                                    Expanded(
                                      flex: 2,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(0, 60),
                                          primary: Color(0xffE5E5E5),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(
                                          'ย้อนกลับ',
                                          style: TextStyle(
                                              color: Color(0xff9F9F9F)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                MyWidget.buildSizedBox('h', 15),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (Unitity.isLoading)
                    Container(
                      color: Colors.black54,
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                          MyWidget.buildSizedBox('h', 10),
                          Text(
                            "กำลังโหลด ....",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                ],
              ));
  }
}
