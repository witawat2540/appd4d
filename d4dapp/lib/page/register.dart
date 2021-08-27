import 'dart:convert';

import 'package:d4dapp/network/connect.dart';
import 'package:d4dapp/page/homepage.dart';
import 'package:d4dapp/service/mycolors.dart';
import 'package:d4dapp/service/mytextfild.dart';
import 'package:d4dapp/service/mywidget.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _keyScaffold = GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _surname = TextEditingController();
  TextEditingController _rePassword = TextEditingController();
  TextEditingController _password = TextEditingController();

  Future<void> register() async {
    String data = jsonEncode({
      "email": _email.text,
      "password": _password.text,
      "name": _name.text,
      "surname": _surname.text,
      "password_confirmation": _rePassword.text
    });
    if (_keyForm.currentState!.validate()) {
      ConnectAPI().post(data, 'register').then((value) {
        print(value.body);
        if (value.statusCode == 200 &&
            jsonDecode(value.body)['status'] == true) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
                  (route) => false);
          savetoken(jsonDecode(value.body)['data']);
        } else {
          //checkerror(value.body);
          MyWidget.showInSnackBar(
              'มีอีเมลนี้ในระบบแล้ว', Colors.white, _keyScaffold,
              Colors.redAccent, 3, Icons.error);
        }
      }).catchError((onError) {
        MyWidget.showInSnackBar(
            'เกิดข้อผิดพลาดบางอย่าง', Colors.white, _keyScaffold,
            Colors.redAccent, 3, Icons.error);
      });
    }
  }
  /*checkerror(value){
    if(jsonDecode(value)['errors']['name']!=null){
    MyWidget.showInSnackBar(
    'มีชื่อนี้ในระบบแล้ว', Colors.white, _keyScaffold,
    Colors.redAccent, 3, Icons.error);
    }
  }*/

  savetoken(data) async {
    ConnectAPI.prefer.then((value) => value.setBool('isLogin', true));
    ConnectAPI.prefer
        .then((value) => value.setInt('id', int.parse(data['id'].toString())));
  }

  String? checkEmtyRePassword(String? value) {
    if (value!.isEmpty) {
      return "กรุณากรอกช่องนี้";
    }
    if (value != _password.text) return 'ยืนยันรหัสผ่านไม่ตรงกัน';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyScaffold,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                child: Form(
                  key: _keyForm,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      Text(
                        'ลงทะเบียน',
                        style: Theme
                            .of(context)
                            .textTheme
                            .caption!
                            .apply(
                            color: MyColors.colorApp, fontWeightDelta: 20),
                      ),
                      /*MyWidget.buildSizedBox('h', 20),
                      mytextfield(
                        labelText: 'ชื่อผู้ใช้ (Username)',
                        prefixIcon: Icon(Icons.person),
                      ),*/
                      MyWidget.buildSizedBox('h', 20),
                      mytextfield(
                        labelText: 'อีเมล',
                        //obscureText: true,
                        validator: MyWidget.checkEmtyText,
                        controller: _email,
                        prefixIcon: Icon(Icons.email),
                      ),
                      MyWidget.buildSizedBox('h', 20),
                      mytextfield(
                        labelText: 'รหัสผ่าน',
                        obscureText: true,
                        controller: _password,
                        prefixIcon: Icon(Icons.lock),
                        validator: MyWidget.checkEmtyPassword,
                      ),
                      MyWidget.buildSizedBox('h', 20),
                      mytextfield(
                        labelText: 'ยืนยันรหัสผ่าน',
                        obscureText: true,
                        prefixIcon: Icon(Icons.lock),
                        controller: _rePassword,
                        validator: checkEmtyRePassword,
                      ),
                      MyWidget.buildSizedBox('h', 20),
                      mytextfield(
                        labelText: 'ชื่อ',
                        //obscureText: true,
                        controller: _name,
                        validator: MyWidget.checkEmtyText,
                        prefixIcon: Icon(Icons.person),
                      ),
                      MyWidget.buildSizedBox('h', 20),
                      mytextfield(
                        labelText: 'นามสกุล',
                        controller: _surname,
                        //obscureText: true,
                        prefixIcon: Icon(Icons.person),
                      ),
                      /* MyWidget.buildSizedBox('h', 20),
                      mytextfield(
                        labelText: 'เบอร์โทร',
                        //obscureText: true,
                        prefixIcon: Icon(Icons.phone),
                      ),*/
                      MyWidget.buildSizedBox('h', 20),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => register(),
                          child: Text('ลงทะเบียน'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                            ),
                          ),
                        ),
                      ),
                      MyWidget.buildSizedBox('h', 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'มีบัญชีผู้ใช้แล้ว ?',
                            style: TextStyle(color: MyColors.colorApp),
                          ),
                          Container(
                            height: 30,
                            child: TextButton(
                              onPressed: () =>
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ),
                                  ),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(5)),
                              child: Text(
                                'เข้าสู่ระบบ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
