import 'package:flutter/material.dart';
import 'package:onde_app/service/mytextfild.dart';
import 'package:onde_app/service/mywidget.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
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
                text: 'แจ้งปัญหา',
              ),
              Mysutitle(
                text: 'ฟอร์มแจ้งปัญหาการใช้งาน',
                vertical: 5,
              ),
              MyWidget.buildSizedBox('h', 20),
              mytextfield(
                labelText: 'หัวข้อ',
                hintText: 'หัวข้อ',
              ),
              MyWidget.buildSizedBox('h', 20),
              mytextfield(
                labelText: 'รายละเอียด',
                hintText: 'รายละเอียด',
                maxLines: 3,
              ),
              MyWidget.buildSizedBox('h', 20),
              mytextfield(
                labelText: 'แนบรูปปัญหาที่พบ',
                hintText: 'แนบรูปปัญหาที่พบ',
                suffixIcon: Icons.photo_camera_rounded,
              ),
              MyWidget.buildSizedBox('h', 25),
              Mybtn(
                text: 'ส่งปัญหา',
                ontap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
