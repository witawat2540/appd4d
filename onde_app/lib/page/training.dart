import 'package:flutter/material.dart';
import 'package:onde_app/page/registertrainning.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/mywidget.dart';

class Training extends StatefulWidget {
  const Training({Key? key}) : super(key: key);

  @override
  _TrainingState createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
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
                text: 'ลงทะเบียนความต้องการฝึกอบรมการใช้อุปกรณ์/เครื่องมือ',
              ),
              Mysutitle(
                text: 'อุปกรณ์และเครื่องมือคงเหลือทั้งหมด 2,591 รายการ',
                vertical: 5,
              ),
              MyWidget.buildSizedBox('h', 20),
              Mytexth2(
                text: 'รายการฝึกอบรม',
                onTap: () {},
                onbtn: true,
              ),
              MyWidget.buildSizedBox('h', 20),
              Mybtn(
                text: 'ลงทะเบียนความต้องการฝึกอบรม',
                ontap: () {
                  //setgoto();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterTraining(),
                    ),
                  );
                },
              ),
              MyWidget.buildSizedBox('h', 15),
              Mylistcross(
                title: '1. วิธีการใช้งานเครื่องพิมพ์อักษรเบรลล์',
                datetime: '2020-09-28 09:26:28',
              ),
              //MyWidget.buildSizedBox('h', 20),
              Mylistcross(
                title: '2. วิธีการใช้งานเครื่องพิมพ์อักษรเบรลล์',
                datetime: '2020-09-28 09:26:28',
              ),
              //MyWidget.buildSizedBox('h', 20),
              Mylistcross(
                title: '3. วิธีการใช้งานเครื่องพิมพ์อักษรเบรลล์',
                datetime: '2020-09-28 09:26:28',
              ),
              //MyWidget.buildSizedBox('h', 20),
              Mylistcross(
                title: '1. วิธีการใช้งานเครื่องพิมพ์อักษรเบรลล์',
                datetime: '2020-09-28 09:26:28',
              ),
              //MyWidget.buildSizedBox('h', 20),
              Mylistcross(
                title: '1. วิธีการใช้งานเครื่องพิมพ์อักษรเบรลล์',
                datetime: '2020-09-28 09:26:28',
              ),
              //MyWidget.buildSizedBox('h', 20),
              Mylistcross(
                title: '1. วิธีการใช้งานเครื่องพิมพ์อักษรเบรลล์',
                datetime: '2020-09-28 09:26:28',
              ),
              //MyWidget.buildSizedBox('h', 20),
              Mylistcross(
                title: '1. วิธีการใช้งานเครื่องพิมพ์อักษรเบรลล์',
                datetime: '2020-09-28 09:26:28',
              ),
              //MyWidget.buildSizedBox('h', 20),
              Mylistcross(
                title: '1. วิธีการใช้งานเครื่องพิมพ์อักษรเบรลล์',
                datetime: '2020-09-28 09:26:28',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Mylistcross extends StatelessWidget {
  final String title, datetime;

  const Mylistcross({
    Key? key,
    required this.title,
    required this.datetime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              //color: Colors.black12,
              width: MediaQuery.of(context).size.width - 150,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$title'),
                  Text('  $datetime'),
                ],
              ),
            ),
            CircleAvatar(
              backgroundColor: MyColors.colorText_bule,
              child: IconButton(
                onPressed: () {},
                splashRadius: 20,
                icon: Icon(
                  Icons.remove_red_eye_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
