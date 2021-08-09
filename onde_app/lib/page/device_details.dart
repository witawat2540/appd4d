import 'package:flutter/material.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/mywidget.dart';

class DeviceDetail extends StatefulWidget {
  const DeviceDetail({Key? key}) : super(key: key);

  @override
  _DeviceDetailState createState() => _DeviceDetailState();
}

class _DeviceDetailState extends State<DeviceDetail> {
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
                text: 'รายละเอียดอุปกรณ์',
              ),
              Mysutitle(
                text: 'ข้อมูลผู้ยื่นคำขอแทนคนพิการ',
                vertical: 5,
              ),
              Mysutitle(
                text: 'เทคโนโลยีสารสนเทศและการสื่อสาร 1,919 รายการ',
                vertical: 20,
              ),
              buildtitel(context, '1.เครื่องคอมพิวเตอร์', '415'),
              MyCardDevice(
                title: '1.เครื่องคอมพิวเตอร์แบบตั้งโต๊ะ',
                num: '105',
              ),
              MyCardDevice(
                title: '2.เครื่องคอมพิวเตอร์แบบพกพา',
                num: '305',
              ),
              MyCardDevice(
                title: '3.เครื่องแท็บเล็ตSamsung Galaxy Tab 4 10.1”',
                num: '5',
              ),
              MyWidget.buildSizedBox('h', 25),
              buildtitel(
                  context, '2.อุปกรณ์สื่อสาร (โทรศัพท์เคลื่อนที่)', '1,504'),
              MyCardDevice(
                title: '1. Samsung Galaxy Grand 2',
                num: '1,504',
              ),
              Mysutitle(
                text: 'เทคโนโลยีสิ่งอำรวยความสะดวกเพื่อการสื่อสาร 672 รายการ',
                vertical: 40,
              ),
              buildtitel(
                  context, '1.เครื่องคอมพิวเตอร์', '415'),
              MyCardDevice(
                title: '1.เครื่องคอมพิวเตอร์แบบตั้งโต๊ะ',
                num: '105',
              ),
              MyCardDevice(
                title: '2.เครื่องคอมพิวเตอร์แบบพกพา',
                num: '305',
              ),
              MyCardDevice(
                title: '3.เครื่องแท็บเล็ตSamsung Galaxy Tab 4 10.1”',
                num: '5',
              ),
              MyWidget.buildSizedBox('h', 25),
              buildtitel(
                  context, '2.อุปกรณ์สื่อสาร (โทรศัพท์เคลื่อนที่)', '1,504'),
              MyCardDevice(
                title: '1. Samsung Galaxy Grand 2',
                num: '1,504',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row buildtitel(BuildContext context, String text, String count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(
            '$text',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          //color: Colors.black12,
          width: MediaQuery.of(context).size.width - 150,
        ),
        Text('$count'),
      ],
    );
  }
}

class MyCardDevice extends StatelessWidget {
  final String title, num;

  const MyCardDevice({
    Key? key,
    required this.title,
    required this.num,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(top: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 44,
                      width: 60,
                      color: MyColors.colorText_bule,
                    ),
                    Container(
                      child: Text(
                        '$title',
                      ),
                      //color: Colors.black12,
                      width: MediaQuery.of(context).size.width - 200,
                    )
                  ],
                ),
                Text('$num')
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //mainAxisSize: MainAxisSize.min,
            ),
            MyWidget.buildSizedBox('h', 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: MyColors.colorText_bule,
                  child: IconButton(
                    onPressed: () {},
                    splashRadius: 20,
                    icon: Icon(
                      Icons.bookmark,
                      color: Colors.white,
                    ),
                  ),
                ),
                MyWidget.buildSizedBox('w', 10),
                CircleAvatar(
                  backgroundColor: MyColors.colorText_bule,
                  child: IconButton(
                    onPressed: () {},
                    splashRadius: 20,
                    icon: Icon(
                      Icons.monitor,
                      color: Colors.white,
                    ),
                  ),
                ),
                MyWidget.buildSizedBox('w', 10),
                CircleAvatar(
                  backgroundColor: MyColors.colorText_bule,
                  child: IconButton(
                    onPressed: () {},
                    splashRadius: 20,
                    icon: Icon(
                      Icons.play_circle_fill,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
