import 'package:flutter/material.dart';
import 'package:onde_app/service/mywidget.dart';

class HelpDesks extends StatefulWidget {
  const HelpDesks({Key? key}) : super(key: key);

  @override
  _HelpDesksState createState() => _HelpDesksState();
}

class _HelpDesksState extends State<HelpDesks> {
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
                text: 'ประวัติการแจ้งปัญหา',
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
