import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onde_app/model/rightsmodel.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/page/profile.dart';
import 'package:onde_app/service/myunitity.dart';
import 'package:onde_app/service/mywidget.dart';

class RightsPage extends StatefulWidget {
  const RightsPage({Key? key}) : super(key: key);

  @override
  _RightsPageState createState() => _RightsPageState();
}

class _RightsPageState extends State<RightsPage> {
  RightsModel _rightsModel = RightsModel();

  Future _getRights() async {
    await ConnectAPI().get('user-rights').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        setState(() {
          _rightsModel = rightsModelFromJson(
              jsonEncode(jsonDecode(value.body)['data']));
          //print(_dataPractice[0].name);
        });
      }
      //this.setDataAddress();
    });
  }

  @override
  void initState() {
    this._getRights();
    super.initState();
  }

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
                text: 'ระบบตรวจสอบสิทธิ',
              ),
              Mysutitle(
                text: 'ตรวจสอบสิทธิ',
                vertical: 5,
              ),
              MyWidget.buildSizedBox('h', 25),
              Mytexth2(
                text: 'ข้อมูลคนพิการ',
                //onTap: () {},
                onbtn: true,
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadPrefixNameThai ?? '-',
                title: 'คำนำหน้าชื่อ ภาษาไทย',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadFirstNameThai ?? '-',
                title: 'ชื่อ ภาษาไทย',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadLastNameThai ?? '-',
                title: 'นามสกุล ภาษาไทย',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: Unitity.buildTextCitizenId(_rightsModel.maimadPersonCode ?? ''),
                title: 'เลขประจำตัวคนพิการ 13 หลัก',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadBirthDate ?? '-',
                title: 'วันเดือนปีเกิด',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadAge ?? '-',
                title: 'อายุ ณ วันออกบัตรครั้งแรก',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadSexCode ?? '-',
                title: 'รหัสเพศ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadSexNameThai ?? '-',
                title: 'ชื่อเพศ ภาษาไทย',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadCurrAddressNo ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (เลขที่)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadCurrMoo ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (หมู่ที่)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadCurrSoi ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (ซอย)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadCurrStreet ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (ถนน)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadCurrAddress ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (ที่อยู่)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadCurrSubdistrictName ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (ชื่อแขวง/ตำบล)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadCurrSubdistrictCode ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (รหัสแขวง/ตำบล)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadCurrDistrictName ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (ชื่อเขต/อำเภอ)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadCurrDistrictCode ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (รหัสเขตอำเภอ)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadCurrProvinceName ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (ชื่อจังหวัด)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadCurrProvinceCode ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (รหัสจังหวัด)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.maimadCurrPostCode ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (รหัสไปรษณีย์)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorPrefixCode ?? '-',
                title: 'รหัสคำนำหน้าชื่อ ผู้ดูแลคนพิการ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorPrefixName ?? '-',
                title: 'คำนำหน้าชื่อ ผู้ดูแลคนพิการ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorFirstName ?? '-',
                title: 'ชื่อ ผู้ดูแลคนพิการ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorLastName ?? '-',
                title: 'นามสกุล ผู้ดูแลคนพิการ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: Unitity.buildTextCitizenId(_rightsModel.curatorPersonCode ?? '-'),
                title: 'เลขประจำตัวประชาชน ผู้ดูแลคนพิการ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorRelationCode ?? '-',
                title: 'รหัสความสัมพันธ์ ผู้ดูแลคนพิการ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorRelationName ?? '-',
                title: 'ชื่อความสัมพันธ์',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorRelationOther ?? '-',
                title: 'ชื่อความสัมพันธ์ อื่น ๆ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorCurrAddressNo ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (เลขที่)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorCurrMoo ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (หมู่ที่)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorCurrSoi ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (ซอย)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorCurrStreet ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (ถนน)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorCurrAddress ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (ที่อยู่)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text:_rightsModel.curatorCurrSubdistrictName ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (ชื่อแขวง/ตำบล)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorCurrSubdistrictCode ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (รหัสแขวง/ตำบล)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorCurrDistrictName ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (ชื่อเขต/อำเภอ)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorCurrDistrictCode ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (รหัสเขตอำเภอ)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorCurrProvinceName ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (ชื่อจังหวัด)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorCurrProvinceCode ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (รหัสจังหวัด)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.curatorCurrPostCode ?? '-',
                title: 'ข้อมูลที่อยู่ปัจจุบัน (รหัสไปรษณีย์)',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.deformid ?? '-',
                title: 'รหัสประเภทความพิการ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.deformname ?? '-',
                title: 'ชื่อประเภทความพิการ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.cardIssueDate ?? '-',
                title: 'วันที่ออกบัตรประจำตัวคนพิการ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.cardExpireDate ?? '-',
                title: 'วันที่บัตรหมดอายุ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.permitDate ?? '-',
                title: 'วันที่ดำเนินการอนุมัติขึ้นทะเบียนคนพิการ',
              ),
              MyWidget.buildSizedBox('h', 18),
              body(
                text: _rightsModel.personSubtype ?? '-',
                title: 'สถานะบุคคล',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
