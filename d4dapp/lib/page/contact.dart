import 'package:d4dapp/service/mycolors.dart';
import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
                //color: Colors.black12,
                image: DecorationImage(
                    image: NetworkImage(
                        'https://www.onde.go.th/assets-self/images/logo-400-200.jpg'))),
          ),
          Container(
            width: 250,
            margin: EdgeInsets.symmetric(vertical: 10),
            //height: 150,
            alignment: Alignment.center,
            child: Text(
              'ที่อยู่',
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),

              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 250,
            //height: 150,
            alignment: Alignment.center,
            child: Text(
              '120 หมู่ 3 ชั้น 9 อาคารรัฐประศาสนภักดี ศูนย์ราชการเฉลิมพระเกียรติ 80 พรรษา 5 ธันวาคม 2550 ถนนแจ้งวัฒนะ แขวงทุ่งสองห้อง เขตหลักสี่ กรุงเทพฯ 10210',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 250,
            margin: EdgeInsets.symmetric(vertical: 10),
            //height: 150,
            alignment: Alignment.center,
            child: Text(
              'ติดต่อ',
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),

              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 300,
            //height: 150,
            alignment: Alignment.center,
            child: Text(
              'โทร. 0 2142 1337 | แฟกซ์. 0 2143 8043 | อีเมล์. pwds@onde.go.th',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
