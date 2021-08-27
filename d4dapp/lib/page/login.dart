import 'dart:convert';

import 'package:d4dapp/network/connect.dart';
import 'package:d4dapp/page/register.dart';
import 'package:d4dapp/service/mycolors.dart';
import 'package:d4dapp/service/mytextfild.dart';
import 'package:d4dapp/service/mywidget.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

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

  Future<void> login() async {
    String data = jsonEncode({
      "email": _email.text,
      "password": _password.text
    });
    if (_keyForm.currentState!.validate()) {
      ConnectAPI().post(data, 'login').then((value) {
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
              'อีเมลหรือรหัสผ่านไม่ถูกต้อง', Colors.white, _keyScaffold,
              Colors.redAccent, 3, Icons.error);
        }
      }).catchError((onError) {
        MyWidget.showInSnackBar(
            'เกิดข้อผิดพลาดบางอย่าง', Colors.white, _keyScaffold,
            Colors.redAccent, 3, Icons.error);
      });
    }
  }

  savetoken(data) async {
    ConnectAPI.prefer.then((value) => value.setBool('isLogin', true));
    ConnectAPI.prefer
        .then((value) => value.setInt('id', int.parse(data['id'].toString())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyScaffold,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
            child: Form(
              key: _keyForm,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Text(
                    'เข้าสู่ระบบ',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .apply(color: MyColors.colorApp, fontWeightDelta: 20),
                  ),
                  MyWidget.buildSizedBox('h', 100),
                  mytextfield(
                    labelText: 'อีเมล',
                    validator: MyWidget.checkEmtyText,
                    controller: _email,
                    prefixIcon: Icon(Icons.person),
                  ),
                  MyWidget.buildSizedBox('h', 20),
                  mytextfield(
                    labelText: 'รหัสผ่าน',
                    validator: MyWidget.checkEmtyPassword,
                    obscureText: true,
                    controller: _password,
                    prefixIcon: Icon(Icons.lock),
                  ),
                  MyWidget.buildSizedBox('h', 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () =>login(),
                      child: Text('เข้าสู่ระบบ'),
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
                        'ไม่มีบัญชีผู้ใช้ ?',
                        style: TextStyle(color: MyColors.colorApp),
                      ),
                      Container(
                        height: 30,
                        child: TextButton(
                          onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Register(),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(5)),
                          child: Text(
                            'ลงทะเบียน',
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
    );
  }
}
