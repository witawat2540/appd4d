import 'package:flutter/material.dart';
import 'package:onde_app/service/mywidget.dart';

class DeviceReturn extends StatefulWidget {
  const DeviceReturn({Key? key}) : super(key: key);

  @override
  _DeviceReturnState createState() => _DeviceReturnState();
}

class _DeviceReturnState extends State<DeviceReturn> {
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
                text: 'แบบคำขอส่งคืนอุปกรณ์ (ทก. 06)',
              ),
              Mysutitle(
                text: 'รายการแบบฟอร์มที่ยืมมา',
                vertical: 5,
              ),
              MyCardreturn(
                on: '1',
                name: 'เครื่องคอมพิวเตอร์แบบตั้งโต๊ะ',
                unit: '1 หน่วย',
              ),
              MyCardreturn(
                on: '2',
                name: 'Samsung Galaxy Grand 2',
                unit: '1 หน่วย',
              ),
              MyCardreturn(
                on: '3',
                name: 'Samsung Galaxy Grand 2',
                unit: '1 หน่วย',
              ),
              MyCardreturn(
                on: '4',
                name: 'เครื่องคอมพิวเตอร์แบบตั้งโต๊ะ',
                unit: '1 หน่วย',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyCardreturn extends StatelessWidget {
  final String? on, name, unit;

  const MyCardreturn({
    Key? key,
    this.on,
    this.name,
    this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [Text('ลำดับ: $on')],
            ),
            MyWidget.buildSizedBox('h', 15),
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
            MyWidget.buildSizedBox('h', 15),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff2782EB),
                ),
                onPressed: () {},
                child: Text('สร้าง'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
