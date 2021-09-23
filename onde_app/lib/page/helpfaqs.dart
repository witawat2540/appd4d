import 'package:flutter/material.dart';
import 'package:onde_app/service/mywidget.dart';

class HelpFaqs extends StatefulWidget {
  const HelpFaqs({Key? key}) : super(key: key);

  @override
  _HelpFaqsState createState() => _HelpFaqsState();
}

class _HelpFaqsState extends State<HelpFaqs> {



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
                text: 'ปัญหาที่พบบ่อย',
              ),
              Mysutitle(
                text: 'แจ้งปัญหาการใช้งาน',
                vertical: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
