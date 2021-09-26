import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/mytextfild.dart';
import 'package:onde_app/service/myunitity.dart';
import 'package:onde_app/service/mywidget.dart';
import 'package:onde_app/service/validate.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _imageName = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {});
      //print(image.path);
      // _image = image;
      _imageName.text = image.path.split('/').last;
    }
  }

  Future sendReport() async {
    if (_keyForm.currentState!.validate()) {
      //print(toJson().toString());
      List<Future<MultipartFile>?> image = [];
      if (_image != null) {
        image.add(http.MultipartFile.fromPath('image', _image!.path));
      }
      await ConnectAPI()
          .httpMultiFormHeaders(toJson(), image, 'create-helpdesk')
          .then((value) async {
        // print(value.statusCode);
        //print();
        if (value.statusCode == 200 &&
            jsonDecode(
                (await value.stream.bytesToString()).toString())['status']) {
          MyWidget.showInSnackBarContext('ทำรายการสำเร็จ', Colors.white,
              context, MyColors.colorText_bule, 2, Icons.check_circle);
          _imageName.clear();
          _title.clear();
          _description.clear();
          _image = null;
          setState(() {

          });

        } else {
          setState(() {
            //statusSave = true;
            Unitity.isLoading = false;
          });
          MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white,
              context, Colors.redAccent, 2, Icons.close);
        }
      }).catchError((onError) {
        print(onError);
        setState(() {
          //statusSave = true;
          Unitity.isLoading = false;
        });
        MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white, context,
            Colors.redAccent, 2, Icons.close);
      });
      /*await ConnectAPI()
          .postHeaders(
          jsonEncode({

          }), 'practice/create')
          .then((value) async {
        if (value.statusCode == 200 &&
            jsonDecode(value.body)['status'] == true) {
          //Navigator.pop(context, true);
        } else {
          MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white,
              context, Colors.redAccent, 2, Icons.close);
        }
      }).catchError((onError) {
        MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white,
            context, Colors.redAccent, 2, Icons.close);
      });*/
    }
    /*MyWidget.showInSnackBar('เกิดข้อผิดพลาด', Colors.white,
        _keyScaffoldState, Colors.redAccent, 2, Icons.close);*/
  }

  Map<String, String> toJson() => Map<String, String>.from(
      {"title": "${_title.text}", "description": "${_description.text}"});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyWidget.buildEdgeInsets(),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _keyForm,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Mytitle(
                  text: 'แจ้งปัญหา',
                ),
                Mysutitle(
                  text: 'แจ้งปัญหาการใช้งาน',
                  vertical: 5,
                ),
                MyWidget.buildSizedBox('h', 20),
                mytextfield(
                  labelText: 'หัวข้อ',
                  hintText: 'หัวข้อ',
                  validator: MyValidate.checkEmpty,
                  controller: _title,
                ),
                MyWidget.buildSizedBox('h', 20),
                mytextfield(
                  labelText: 'รายละเอียด',
                  hintText: 'รายละเอียด',
                  controller: _description,
                  validator: MyValidate.checkEmpty,
                  maxLines: 3,
                ),
                MyWidget.buildSizedBox('h', 20),
                mytextfield(
                  //labelText: 'แนบรูปปัญหาที่พบ',
                  hintText: 'แนบรูปปัญหาที่พบ',
                  readOnly: true,
                  controller: _imageName,
                  onTap: () => getImage(),
                  suffixIcon: Icons.photo_camera_rounded,
                ),
                MyWidget.buildSizedBox('h', 25),
                Mybtn(
                  text: 'ส่งปัญหา',
                  ontap: () => sendReport(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
