import 'package:flutter/material.dart';
import 'package:onde_app/service/mywidget.dart';

class ContractDocument extends StatefulWidget {
  const ContractDocument({Key? key}) : super(key: key);

  @override
  _ContractDocumentState createState() => _ContractDocumentState();
}

class _ContractDocumentState extends State<ContractDocument> {
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
                text: 'เอกสารสัญญา/หนังสือค้ำประกันดำเนินการแล้ว',
              ),
              Mysutitle(
                text: 'รายการเอกสารสัญญา/หนังสือค้ำประกันดำเนินการแล้ว',
                vertical: 5,
              ),
              MyCarddoc(
                no: '1',
                number: '33',
                name: 'เครื่องคอมพิวเตอร์แบบตั้งโต๊ะ',
                unit: '1 หน่วย',
                id: '01293847593845',
                startdate: '1 ต.ค. 2563 09:26',
                enddate: '1 ต.ค. 2563 09:26',
                nameuser: 'ฉันทนา ตั้งเรืองเกียรต',
              ),
              MyCarddoc(
                no: '2',
                number: '34',
                name: 'เครื่องคอมพิวเตอร์แบบตั้งโต๊ะ',
                unit: '1 หน่วย',
                id: '01293847593845',
                startdate: '1 ต.ค. 2563 09:26',
                enddate: '1 ต.ค. 2563 09:26',
                nameuser: 'ฉันทนา ตั้งเรืองเกียรต',
              ),
            ],
          ),
        ),
      ),
    );
  }

/*ConstrainedBox buildbtn(String text , VoidCallback onTap) {
    return Mybtnred();
  }*/

/*ConstrainedBox buildbtn2(String text, VoidCallback onTap) {
    return Mybtngreen();
  }*/
}

class MyCarddoc extends StatelessWidget {
  final String? no, number, name, unit, id, startdate, enddate, nameuser;

  const MyCarddoc({
    Key? key,
    this.no,
    this.number,
    this.name,
    this.unit,
    this.id,
    this.startdate,
    this.enddate,
    this.nameuser,
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
              children: [Text("ลำดับ: $no   เลขที่: $number")],
            ),
            MyWidget.buildSizedBox('h', 8),
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
            MyWidget.buildSizedBox('h', 8),
            Row(
              children: [Text("$id")],
            ),
            MyWidget.buildSizedBox('h', 8),
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
            MyWidget.buildSizedBox('h', 8),
            Container(
              width: MediaQuery.of(context).size.width,
              child:
                  Text('ผู้ยืม', style: Theme.of(context).textTheme.subtitle),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text('$nameuser',
                  style: Theme.of(context).textTheme.subtitle),
            ),
            MyWidget.buildSizedBox('h', 8),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text('เอกสารดาวน์โหลด',
                  style: Theme.of(context).textTheme.subtitle),
            ),
            MyWidget.buildSizedBox('h', 8),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Mybtnred(text: 'สัญญา', onTap: () {}),
                  MyWidget.buildSizedBox('w', 8),
                  Mybtnred(text: 'หนังสือค้ำประกัน', onTap: () {}),
                  MyWidget.buildSizedBox('w', 8),
                  Mybtnred(text: 'แบบฟอร์ม ทก.05', onTap: () {}),
                  // MyWidget.buildSizedBox('w', 8),
                ],
              ),
            ),
            MyWidget.buildSizedBox('h', 14),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text('ดำเนินการ',
                  style: Theme.of(context).textTheme.subtitle),
            ),
            MyWidget.buildSizedBox('h', 5),
            Row(
              children: [
                Mybtngreen(text: 'อัพโหลดเอกสาร', onTap: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Mybtngreen extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const Mybtngreen({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        height: 30,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(5), primary: Color(0xff26BA12)),
        child: Text('$text'),
        onPressed: onTap,
      ),
    );
  }
}

class Mybtnred extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const Mybtnred({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        height: 30,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(5), primary: Color(0xffF85C6E)),
        child: Text('$text'),
        onPressed: onTap,
      ),
    );
  }
}
