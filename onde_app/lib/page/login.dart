import 'package:flutter/material.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/mytextfild.dart';
import 'package:onde_app/service/mywidget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    myh(text: "เข้าสู่ระบบสำหรับคนพิการ",),
                    Mysutitle(text: 'ระบบบริหารจัดการอุปกรณ์และเครื่องมือด้าน ICT สำหรับคนพิการ',vertical: 10,),
                    MyWidget.buildSizedBox('h', 25),
                    mytextfield(
                      hintText: 'อีเมล์',
                      labelText: 'อีเมล์',
                    ),
                    MyWidget.buildSizedBox('h', 25),
                    mytextfield(
                      hintText: 'Password',
                      labelText: 'Password',
                      obscureText: true,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: false,
                              side: BorderSide(
                                  color: MyColors.colorTexthittext, width: 1.5),
                              onChanged: (bool? value) {},
                            ),
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 49),
                      ),
                      child: Text('เข้าสู่ระบบ'),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}




