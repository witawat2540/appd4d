import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onde_app/model/getsubstitute.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/page/formspouse.dart';
import 'package:onde_app/page/formsubsitute.dart';
import 'package:onde_app/page/profile.dart';
import 'package:onde_app/service/myunitity.dart';
import 'package:onde_app/service/mywidget.dart';

class Representative extends StatefulWidget {
  const Representative({Key? key}) : super(key: key);

  @override
  _RepresentativeState createState() => _RepresentativeState();
}

class _RepresentativeState extends State<Representative> {
  GetSubstituteModel dataSubstitute = GetSubstituteModel();
  bool statusEdit = true;

  getSubstitute() async {
    await ConnectAPI().get('get-all-substitute').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          if (List.from(jsonDecode(value.body)['data']).isNotEmpty) {
            dataSubstitute = getSubstituteModelFromJson(value.body);
            //_substituteModel.setText(json)

          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormSubstitute(),
                )).then((value) {
              if (value ?? false) {
                getSubstitute();
              }
            });
          }
          // print(_addressModel.toJson());
        });
      }
      //this.setDataAddress();
    });
  }

  @override
  void initState() {
    this.getSubstitute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyWidget.buildEdgeInsets(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: buildColumn(context),
        ),
      ),
    );
  }

  Column buildColumn(BuildContext context) {
    return Column(
      children: [
        Mytitle(
          text: 'รายละเอียดผู้ยื่นคำขอแทน',
        ),
        Mysutitle(
          text: 'ข้อมูลผู้ยื่นคำขอแทนคนพิการ',
          vertical: 5,
        ),
        dataSubstitute.data?.length == 2
            ? Container()
            : Column(
                children: [
                  MyWidget.buildSizedBox('h', 18),
                  Mybtn(
                    text:
                        'เพิ่มข้อมูลผู้อื่นคำขอแทนคนที่ ${(dataSubstitute.data?.length ?? 0) + 1}',
                    ontap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormSubstitute(),
                        )).then((value) {
                      if (value ?? false) {
                        getSubstitute();
                      }
                    }),
                  ),
                ],
              ),
        Column(
          children: dataSubstitute.data?.map((e) {
                int index = dataSubstitute.data!.indexOf(e);
                return Column(
                  children: [
                    MyWidget.buildSizedBox('h', 18),
                    Mytexth2(
                      text: 'ผู้ยื่นคำขอแทนคนที่ ${index + 1}',
                      //onTap: () {},
                      onbtn: true,
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: e.title ?? '-',
                      title: 'คำนำหน้าชื่อ',
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: e.firstName ?? '-',
                      title: 'ชื่อ',
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: e.lastName ?? '-',
                      title: 'นามสกุล',
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: e.related ?? '-',
                      title: 'เกี่ยวข้องเป็น',
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: DateFormat('dd MMM yyyy')
                          .format(e.proxyDate ?? DateTime.now()),
                      title: 'หนังสือมอบอำนาจลงวันที่',
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: DateFormat('dd MMM yyyy')
                          .format(e.brithday ?? DateTime.now()),
                      title: 'วันเกิด',
                      //edit: true,
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: Unitity.buildTextCitizenId(e.citizenId ?? ''),
                      title: 'เลขบัตรประชาชน',
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: e.houseNo ?? '-',
                      title: 'บ้านเลขที่',
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: e.villageNo ?? '-',
                      title: 'หมู่ที่',
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: e.lane ?? '-',
                      title: 'ซอย',
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: e.province ?? '-',
                      title: 'จังหวัด',
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: e.district ?? '-',
                      title: 'อำเภอ',
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: e.subDistrict ?? '-',
                      title: 'ตำบล',
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: e.postalCode ?? '-',
                      title: 'รหัสไปรษณีย์',
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: e.degree ?? '-',
                      title: 'ระดับการศึกษา',
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: e.eduPlace ?? '-',
                      title: 'สถานศึกษา',
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: e.tel ?? '-',
                      title: 'เบอร์โทร',
                    ),
                    MyWidget.buildSizedBox('h', 18),
                    body(
                      text: e.email ?? '-',
                      title: 'อีเมล์',
                    ),
                    MyWidget.buildSizedBox('h', 30),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(0, 49),
                                primary: Color(0xffFA601B)),
                            child: Text('เพิ่มข้อมูลคู่สมรส'),
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FormSpouse(
                                    idSubstitute: e.id,
                                  ),
                                )).then((value) {
                              if (value ?? false) {
                                getSubstitute();
                              }
                            }),
                          ),
                        ),
                        MyWidget.buildSizedBox('w', 15),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(0, 49),
                                primary: Color(0xffFA601B)),
                            child: Text('แก้ไขข้อมูลผู้ยื่นคำขอแทน'),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormSubstitute(
                                  statusEdit: true,
                                  data: e,
                                ),
                              ),
                            ).then((value) {
                              if (value ?? false) {
                                getSubstitute();
                              }
                            }),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }).toList() ??
              [],
        )
      ],
    );
  }
}
