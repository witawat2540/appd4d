import 'package:flutter/material.dart';
import 'package:onde_app/page/profile.dart';
import 'package:onde_app/service/mydropdown.dart';
import 'package:onde_app/service/mytextfild.dart';
import 'package:onde_app/service/mywidget.dart';

class RegisterTraining extends StatefulWidget {
  const RegisterTraining({Key? key}) : super(key: key);

  @override
  _RegisterTrainingState createState() => _RegisterTrainingState();
}

class _RegisterTrainingState extends State<RegisterTraining> {
  bool isform = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidget.buildAppBar(),
      body: Container(
        padding: MyWidget.buildEdgeInsets(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Mytitle(
                  text: 'ลงทะเบียนความต้องการฝึกอบรมการใช้อุปกรณ์/เครื่องมือ',
                ),
                MyWidget.buildSizedBox('h', 20),
                Mytexth2(
                  text: 'กรอกข้อมูลลงทะเบียน',
                  onbtn: true,
                ),
                MyWidget.buildSizedBox('h', 20),
                isform ? Column(
                  children: [
                    body(
                      text: 'วิธีการใช้งานเครื่องพิมพ์อักษรเบรลล์',
                      title: 'ชื่อหลักสตูร',
                    ),
                    MyWidget.buildSizedBox('h', 20),
                    body(
                      text: 'เทคโนโลยีสิ่งอำนวยความสะดวกเพื่อการสื่อสาร',
                      title: 'กลุ่มหลัก',
                    ),
                    MyWidget.buildSizedBox('h', 20),
                    body(
                      text: 'เครื่องพิมพ์อักษรเบรลล์ด้วยระบบคอมพิวเตอร์',
                      title: 'กลุ่มย่อย',
                    ),
                    MyWidget.buildSizedBox('h', 20),
                    body(
                      text: 'EmprintSpotDot',
                      title: 'ชื่ออุปกรณ์',
                    ),
                    MyWidget.buildSizedBox('h', 25),
                    Mybtn(
                      text: 'ย้อนกลับ',
                      ontap: () {
                        setState(() {
                          isform = false;
                        });
                      },
                    )
                  ],
                ) : buildform(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card buildform(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [Text('กรอกข้อมูลลงทะเบียน')],
            ),
            MyWidget.buildSizedBox('h', 25),
            mytextfield(
              hintText: 'ชื่อหลักสูตร',
              labelText: 'ชื่อหลักสูตร',
            ),
            MyWidget.buildSizedBox('h', 25),
            mydropdown(
              label: 'กลุ่มหลัก',
            ),
            MyWidget.buildSizedBox('h', 25),
            mytextfield(
              hintText: 'กลุ่มย่อย',
              labelText: 'กลุ่มย่อย',
            ),
            MyWidget.buildSizedBox('h', 25),
            mytextfield(
              hintText: 'ชื่ออุปกรณ์',
              labelText: 'ชื่ออุปกรณ์',
            ),
            MyWidget.buildSizedBox('h', 25),
            Mybtn(
              text: 'ลงทะเบียน',
              ontap: () {
                setState(() {
                  isform = true;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
