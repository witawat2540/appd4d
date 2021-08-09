import 'package:flutter/material.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/mywidget.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
              ),
              MyWidget.buildSizedBox('h', 18),
              Mytexth2(
                text: 'ข้อมูลส่วนตัว',
                onTap: () {},
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'นาย',
                title: 'คำนำหน้าชื่อ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'รักดี',
                title: 'ชื่อ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'มีสุข',
                title: 'นามสกุล',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: '11 พ.ค. 2543',
                title: 'วันเกิด',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: '1-2345-67890-12-3',
                title: 'เลขบัตรประชาชน',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: '1-2345-67890-12-3',
                title: 'บัตรประจำตัวคนพิการ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'คนพิการทางการมองเห็น',
                title: 'ประเภทคนพิการ',
              ),
              MyWidget.buildSizedBox('h', 18),
              Mytexth2(
                text: 'ที่อยู่',
                onTap: () {},
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: '11/21',
                title: 'บ้านเลขที่',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: '3',
                title: 'หมู่ที่',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'สหกรณ์ 3',
                title: 'ซอย/ถนน',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'บางพูด',
                title: 'ตำบล/แขวง',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'ปากเกร็ด',
                title: 'อำเภอ/เขต',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'นนทบุรี',
                title: 'จังหวัด',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: '11120',
                title: 'รหัสไปรษณีย์',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'ปริญญาตรี',
                title: 'กำลังศึกษาระดับ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'มหาวิทยาลัยเทคโนโลยี',
                title: 'สถานศึกษา',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'เมือง',
                title: 'อำเภอ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'นนทบุรี',
                title: 'จังหวัด',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: '0894435642',
                title: 'เบอร์โทร',
              ),
            ],
          ),
        ),
      ),
    );
  }
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
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              '$title : ',
              //style: Theme.of(context).textTheme.subtitle,
            ),
          ),
        ),
        MyWidget.buildSizedBox('w', 10),
        Expanded(
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
