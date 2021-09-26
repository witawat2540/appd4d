import 'package:flutter/material.dart';
import 'package:onde_app/model/helpdeskmodel.dart';
import 'package:onde_app/page/profile.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/mywidget.dart';

class DetailHelpDesks extends StatelessWidget {
  final GetHelpdeskModel data;

  const DetailHelpDesks({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _keyScaffoldState,
      appBar: MyWidget.buildAppBar(),
      body: Container(
        padding: MyWidget.buildEdgeInsets(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Mytitle(
                  text: 'ประวัติการแจ้งปัญหา',
                ),
                MyWidget.buildSizedBox('h', 20),
                Mytexth2(
                  text: 'ฟอร์มบันทึกการแก้ปัญหา',
                  onbtn: true,
                ),
                MyWidget.buildSizedBox('h', 10),
                body(
                  title: 'หัวข้อ',
                  edit: true,
                  widget: Text("${data.title ?? ''}"),
                  text: '',
                ),
                MyWidget.buildSizedBox('h', 20),
                body(
                  title: 'รายละเอียด',
                  edit: true,
                  widget: Text("${data.description}"),
                  text: '',
                ),
                MyWidget.buildSizedBox('h', 20),
                body(
                  title: 'รูปภาพปัญหาที่พบ',
                  edit: true,
                  widget: data.image == null
                      ? Container(
                          height: 200,
                          color: Colors.black38,
                        )
                      : Container(
                          height: 200,
                          color: MyColors.colorText_bule,
                          decoration: BoxDecoration(
                            color: MyColors.colorText_bule,
                            image: DecorationImage(
                              image: NetworkImage(
                                data.image,
                              ),
                            ),
                          ),
                        ),
                  text: '',
                ),
                MyWidget.buildSizedBox('h', 20),
                body(
                  title: 'สถานะการแก้ปัญหา',
                  edit: true,
                  widget: Text(
                    '${buildText(status: data.status!)}',
                    style: TextStyle(color: buildColor(status: data.status!)),
                  ),
                  text: '',
                ),
                MyWidget.buildSizedBox('h', 20),
                body(
                  title: 'วิธีการแก้ปัญหา',
                  edit: true,
                  widget: Text("${data.note ?? ''}"),
                  text: '',
                ),
                MyWidget.buildSizedBox('h', 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String buildText({required String status}) {
    if (status == 'new') {
      return 'แจ้งใหม่';
    } else if (status == 'pending') {
      return 'ดำเนินการ';
    } else {
      return 'เสร็จสิ้น';
    }
  }

  Color buildColor({required String status}) {
    if (status == 'new') {
      return Colors.red;
    } else if (status == 'pending') {
      return Colors.orange;
    } else {
      return MyColors.colorText_bule;
    }
  }
}
