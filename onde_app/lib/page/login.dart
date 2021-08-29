import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/page/homepage.dart';
import 'package:onde_app/page/register.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/mytextfild.dart';
import 'package:onde_app/service/myunitity.dart';
import 'package:onde_app/service/mywidget.dart';
import 'package:onde_app/service/validate.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _keyScaffold = GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _systemLogin = false;
  String? token;

  Future<void> sendLogin() async {
    String data =
        jsonEncode({"email": _email.text, "password": _password.text});
    if (_keyForm.currentState!.validate()) {
      await ConnectAPI().post(data, 'login').then((value) {
        if (value.statusCode == 200) {
          Navigator.pushAndRemoveUntil(
              context, Unitity.materialPageRoute(HomePage()), (route) => false);
          if (_systemLogin) {
            ConnectAPI.prefer.then((pre) {
              pre.setString('token', jsonDecode(value.body)['token']);
              pre.setString('user', value.body);
            });
          }
        } else if (value.statusCode == 401) {
          MyWidget.showInSnackBar('รหัสหรืออีเมลผ่านไม่ถูกต้อง', Colors.white,
              _keyScaffold, Colors.redAccent, 2, Icons.close);
        } else {
          MyWidget.showInSnackBar('เกิดข้อผิดพลาด', Colors.white, _keyScaffold,
              Colors.redAccent, 2, Icons.close);
        }
      }).catchError((onError) {
        MyWidget.showInSnackBar('เกิดข้อผิดพลาด', Colors.white, _keyScaffold,
            Colors.redAccent, 2, Icons.close);
      });
    }
  }

  checkLogin() async {
    token = await ConnectAPI.prefer.then((value) => value.getString('token'));
    if (token != null) {
      Navigator.pushAndRemoveUntil(
          context, Unitity.materialPageRoute(HomePage()), (route) => false);
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          key: _keyScaffold,
    body: Form(
        key: _keyForm,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 100, bottom: 70),
                color: Colors.white38,
                alignment: Alignment.center,
                child: Image.asset('images/logoapp.png'),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 10),
                elevation: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Column(
                    children: [
                      myh(
                        text: "เข้าสู่ระบบสำหรับคนพิการ",
                      ),
                      Mysutitle14(
                        text:
                            'ระบบบริหารจัดการอุปกรณ์และเครื่องมือด้าน ICT สำหรับคนพิการ',
                        vertical: 10,
                      ),
                      MyWidget.buildSizedBox('h', 25),
                      mytextfield(
                        hintText: 'อีเมล์',
                        labelText: 'อีเมล์',
                        validator: MyValidate.checkEmpty,
                        controller: _email,
                      ),
                      MyWidget.buildSizedBox('h', 25),
                      MyTextFieldPass(
                        hintText: 'Password',
                        //maxLines: null,
                        labelText: 'Password',
                        validator: MyValidate.checkEmpty,
                        controller: _password,
                        obscureText: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                                child: Checkbox(
                                  value: _systemLogin,
                                  side: BorderSide(
                                      color: MyColors.colorTexthittext,
                                      width: 1.5),
                                  onChanged: (bool? value) {
                                    _systemLogin = value!;
                                    setState(() {});
                                  },
                                ),
                              ),
                              MyWidget.buildSizedBox('w', 10),
                              Text(
                                'จำข้อมูลไว้ในระบบ',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle!
                                    .apply(color: MyColors.colorTextsubtitle),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              ' ลืมรหัสผ่าน?',
                              style: TextStyle(
                                color: MyColors.colorText_label,
                              ),
                            ),
                          )
                        ],
                      ),
                      MyWidget.buildSizedBox('h', 20),
                      ElevatedButton(
                        onPressed: () => sendLogin(),
                        style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 49),
                        ),
                        child: Text('เข้าสู่ระบบ'),
                      ),
                      MyWidget.buildSizedBox('h', 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("ไม่มีบันชี ? "),
                          Container(
                            height: 23,
                            child: TextButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 2),
                                alignment: Alignment.center,
                                textStyle: GoogleFonts.prompt(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Resister(),
                                  ),
                                );
                              },
                              child: Text("สมัครสมาชิก"),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
    ),
        ),
      ),
    );
  }
}
