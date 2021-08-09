import 'package:flutter/material.dart';
import 'package:onde_app/page/login.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/mydropdown.dart';
import 'package:onde_app/service/mytextfild.dart';
import 'package:onde_app/service/mywidget.dart';

class Resister extends StatefulWidget {
  const Resister({Key? key}) : super(key: key);

  @override
  _ResisterState createState() => _ResisterState();
}

class _ResisterState extends State<Resister> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
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
                  hintText: 'ชื่อ',
                ),
                MyWidget.buildSizedBox('h', 30),
                mytextfield(
                  labelText: 'นามสกุล',
                  hintText: 'นามสกุล',
                ),
                MyWidget.buildSizedBox('h', 30),
                mytextfield(
                  labelText: 'อีเมล์',
                  hintText: 'อีเมล์',
                ),
                MyWidget.buildSizedBox('h', 30),
                mytextfield(
                  labelText: 'รหัสผ่าน',
                  hintText: 'รหัสผ่าน (ไม่น้อยกว่า 8 ตัวอักษร)',
                ),
                MyWidget.buildSizedBox('h', 30),
                mytextfield(
                  labelText: 'รหัสผ่านอีกครั้ง',
                  hintText: 'รหัสผ่านอีกครั้ง',
                ),
                MyWidget.buildSizedBox('h', 30),
                mytextfield(
                  labelText: 'เลขประจำตัวประชาชน',
                  hintText: 'เลขประจำตัวประชาชน',
                ),
                MyWidget.buildSizedBox('h', 30),
                mytextfield(
                  labelText: 'เลขบัตรประจำตัวคนพิการ',
                  hintText: 'เลขบัตรประจำตัวคนพิการ',
                ),
                MyWidget.buildSizedBox('h', 30),
                mydropdown(
                  label: 'เลือกความพิการ',
                ),
                MyWidget.buildSizedBox('h', 30),
                mytextfield(
                  labelText: 'แนบบัตรคนพิการ',
                  hintText: 'แนบบัตรคนพิการ',
                  suffixIcon: Icons.wysiwyg,
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
                          value: '',
                          groupValue: '',
                          onChanged: (String? value) {},
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
                          value: 'หญิง',
                          groupValue: '',
                          onChanged: (String? value) {},
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
                        value: false,
                        side: BorderSide(
                            color: MyColors.colorTexthittext, width: 1.5),
                        onChanged: (bool? value) {},
                      ),
                    ),
                    MyWidget.buildSizedBox('w', 10),
                    Text(
                      'ยอมรับ',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle!
                          .apply(color: MyColors.colorTextsubtitle),
                    ),
                    //MyWidget.buildSizedBox('w', 10),
                    TextButton(
                      style: TextButton.styleFrom(
                          fixedSize: Size(30, 10),
                          padding: EdgeInsets.all(0.0)),
                      onPressed: () {},
                      /* child: Text(
                        'นโยบาย',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationThickness: 2,
                        ),
                      ),*/
                      child: Text(
                        "นโยบาย",
                        style: TextStyle(
                          shadows: [
                            Shadow(
                                color: MyColors.colorText_bule,
                                offset: Offset(0, -3))
                          ],
                          color: Colors.transparent,
                          decoration: TextDecoration.underline,
                          decorationColor: MyColors.colorText_bule,
                          decorationThickness: 2,
                          decorationStyle: TextDecorationStyle.solid,
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
                        style: ElevatedButton.styleFrom(fixedSize: Size(0, 60)),
                        onPressed: () {},
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
                        onPressed: () {},
                        child: Text(
                          'ยกเลิก',
                          style: TextStyle(color: Color(0xff9F9F9F)),
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
    );
  }
}
