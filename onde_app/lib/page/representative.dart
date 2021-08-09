import 'package:flutter/material.dart';
import 'package:onde_app/page/profile.dart';
import 'package:onde_app/service/mywidget.dart';

class Representative extends StatefulWidget {
  const Representative({Key? key}) : super(key: key);

  @override
  _RepresentativeState createState() => _RepresentativeState();
}

class _RepresentativeState extends State<Representative> {
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
                text: 'รายละเอียดผู้ยื่นคำขอแทน',
              ),
              Mysutitle(
                text: 'ข้อมูลผู้ยื่นคำขอแทนคนพิการ',
                vertical: 5,
              ),
              MyWidget.buildSizedBox('h', 18),
              Mybtn(
                text: 'เพิ่มข้อมูลผู้อื่นคำขอแทนคนที่ 2',
              ),
              MyWidget.buildSizedBox('h', 18),
              Mytexth2(
                text: 'ผู้ยื่นคำขอแทนคนที่ 1',
                onTap: () {},
                onbtn: true,
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'นาง',
                title: 'คำนำหน้าชื่อ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'มาลี',
                title: 'ชื่อ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'สุขสบาย',
                title: 'นามสกุล',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'ผู้ปกครอง',
                title: 'เกี่ยวข้องเป็น',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: '11 พ.ค. 2543',
                title: 'หนังสือมอบอำนาจลงวันที่',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: '1-2345-67890-12-3',
                title: 'เลขบัตรประชาชน',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: '222',
                title: 'บ้านเลขที่',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: '4',
                title: 'หมู่ที่',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'สุขมิตร',
                title: 'ซอย',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'บางตะไนย์',
                title: 'ตำบล',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'ปากเกร็ด',
                title: 'อำเภอ',
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
                title: 'ระดับการศึกษา',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'วิทยาลัยเทคนิคนนทบุรี',
                title: 'สถานศึกษา',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: '09848859394',
                title: 'เบอร์โทร',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: 'arrarya@gmail.com',
                title: 'อีเมล์',
              ),
              MyWidget.buildSizedBox('h', 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(0, 49), primary: Color(0xffFA601B)),
                      child: Text('เพิ่มข้อมูลคู่สมรส'),
                      onPressed: () {},
                    ),
                  ),
                  MyWidget.buildSizedBox('w', 15),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(0, 49), primary: Color(0xffFA601B)),
                      child: Text('แก้ไขข้อมูลผู้ยื่นคำขอแทน'),
                      onPressed: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
