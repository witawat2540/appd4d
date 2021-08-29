import 'package:flutter/material.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/mywidget.dart';

class ListRequest extends StatefulWidget {
  const ListRequest({Key? key}) : super(key: key);

  @override
  _ListRequestState createState() => _ListRequestState();
}

class _ListRequestState extends State<ListRequest> {
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
                text: 'รายการแบบคำขอยืม',
              ),
              Mysutitle(
                text: 'รายการแบบคำขอยืมอุปกรณ์และเครื่องมือ ฯ (ทก.01)',
                vertical: 5,
              ),
              MyWidget.buildSizedBox('h', 5),
              MycardList(
                no: '1',
                num: '33',
                name: 'เครื่องคอมพิวเตอร์แบบตั้งโต๊ะ',
                unit: '1 หน่วย',
                enddate: '2020-09-28 09:26:28',
                startdate: '2020-09-28 09:26:28',
              ),
              MycardList(
                no: '2',
                num: '34',
                name: 'เครื่องคอมพิวเตอร์แบบตั้งโต๊ะ',
                unit: '1 หน่วย',
                enddate: '2020-09-28 09:26:28',
                startdate: '2020-09-28 09:26:28',
              ),
              MycardList(
                no: '3',
                num: '35',
                name: 'เครื่องคอมพิวเตอร์แบบตั้งโต๊ะ',
                unit: '1 หน่วย',
                enddate: '2020-09-28 09:26:28',
                startdate: '2020-09-28 09:26:28',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MycardList extends StatelessWidget {
  final String no, num, unit, name, startdate, enddate;

  const MycardList({
    Key? key,
    required this.no,
    required this.num,
    required this.unit,
    required this.name,
    required this.startdate,
    required this.enddate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text('ลำดับ: $no   เลขที่: $num'),
              ],
            ),
            MyWidget.buildSizedBox('h', 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 150,
                  //color: Colors.black12,
                  child: Text('$name'),
                ),
                Text('$unit')
              ],
            ),
            MyWidget.buildSizedBox('h', 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'วัน/เวลา ที่สร้าง',
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      Text('$startdate',
                          style: Theme.of(context).textTheme.subtitle),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'วัน/เวลา ที่ส่ง',
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      Text('$enddate',
                          style: Theme.of(context).textTheme.subtitle),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ],
            ),
            MyWidget.buildSizedBox('h', 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: MyColors.colorText_bule,
                  child: IconButton(
                    onPressed: () {},
                    splashRadius: 20,
                    icon: Icon(
                      Icons.remove_red_eye,
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
                      Icons.send,
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
