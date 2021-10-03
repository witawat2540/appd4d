import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onde_app/model/formaddborrowmodel.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/service/mydropdown.dart';
import 'package:onde_app/service/mytextfild.dart';
import 'package:onde_app/service/mywidget.dart';
import 'package:onde_app/service/validate.dart';

import 'fuction.dart';

class AddFormBorrow extends StatefulWidget {
  const AddFormBorrow({Key? key}) : super(key: key);

  @override
  _AddFormBorrowState createState() => _AddFormBorrowState();
}

class _AddFormBorrowState extends State<AddFormBorrow> {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  List dataGroupId = [];
  List dataSubGroupId = [];
  List dataCategories = [];
  AddFormBorrowModel _addFormBorrow = AddFormBorrowModel();
  final ImagePicker _picker = ImagePicker();
  GlobalKey<ScaffoldState> _keyScaffoldState = GlobalKey<ScaffoldState>();

  Future setDataGroupId() async {
    await MyFunction.getGroupId().then((value) {
      setState(() {
        dataGroupId = value;
      });
    });
  }

  Future sendAddFormBorrow() async {
    if (_keyForm.currentState!.validate()) {
      _addFormBorrow.image = [];
      await _addFormBorrow.setFile();
      print(_addFormBorrow.toJson());
      await ConnectAPI()
          .httpMultiFormHeaders(
        _addFormBorrow.toJson(),
        _addFormBorrow.image,
        'create-form-borrow',
      )
          .then((value) async {
            //print(value.stream);
        if (value.statusCode == 200) {
          Navigator.pop(context, true);
          //print(await value.stream.bytesToString());
        } else {
          print(await value.stream.bytesToString());
          MyWidget.showInSnackBar('เกิดข้อผิดพลาด', Colors.white,
              _keyScaffoldState, Colors.redAccent, 2, Icons.close);
        }
      } ).catchError((onError) {
        print(onError);
        MyWidget.showInSnackBar('เกิดข้อผิดพลาด', Colors.white,
            _keyScaffoldState, Colors.redAccent, 2, Icons.close);
      });
    }
  }

  Future setDataSubGroupId(int mainId) async {
    await MyFunction.getSubGroupId(mainId).then((value) {
      setState(() {
        dataSubGroupId = value;
      });
    });
  }

  Future setCategories(int subId) async {
    await MyFunction.getCategories(forGive: 'ยืม', subId: subId).then((value) {
      setState(() {
        dataCategories = value;
      });
    });
  }

  Future<XFile?> getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {});
      //print(image.path);
      // _image = image;
      //modelData.pwdPic!.text = image.path.split('/').last;
      return image;
    }
  }

  @override
  void initState() {
    this.setDataGroupId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyScaffoldState,
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _keyForm,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Mytitle(
                  text: 'แบบฟอร์มยืม',
                ),
                Mysutitle(
                  text:
                      'แบบคำขอยืมอุปกรณ์และเครื่องมือเทคโนโลยีสารสนเทศและการสื่อสาร',
                  vertical: 5,
                ),
                Mysutitle14(text: 'ข้อมูลขอยืมอุปกรณ์', vertical: 20),
                mytextfield(
                  labelText: 'แนบสำเนาบัตรประจำตัวคนพิการ',
                  hintText: 'แนบสำเนาบัตรประจำตัวคนพิการ',
                  controller: _addFormBorrow.nameFilesCopyCard,
                  validator: MyValidate.checkEmptyFile,
                  counter: buildText(),
                  suffixIcon: Icons.wysiwyg,
                  onTap: () => getImage().then((value) {
                    setState(() {
                      _addFormBorrow.fileCopyCard = value;
                      _addFormBorrow.nameFilesCopyCard.text = value!.name;
                    });
                  }),
                  readOnly: true,
                ),
                MyWidget.buildSizedBox('h', 18),
                mytextfield(
                  labelText: 'แนบสำเนาทะเบียนบ้านคนพิการ',
                  hintText: 'แนบสำเนาทะเบียนบ้านคนพิการ',
                  controller: _addFormBorrow.nameFilesHouseRes,
                  //controller: modelData.pwdPic,
                  suffixIcon: Icons.wysiwyg,
                  validator: MyValidate.checkEmptyFile,
                  counter: buildText(),
                  onTap: () => getImage().then((value) {
                    setState(() {
                      _addFormBorrow.fileHouseRes = value;
                      _addFormBorrow.nameFilesHouseRes.text = value!.name;
                    });
                  }),
                  //onTap: () => getImage(),
                  readOnly: true,
                ),
                MyWidget.buildSizedBox('h', 18),
                mytextfield(
                  labelText: 'สำเนาเอกสารรับรองการเข้ารับการฝึกอบรม',
                  hintText: 'สำเนาเอกสารรับรองการเข้ารับการฝึกอบรม',
                  controller: _addFormBorrow.nameFileCopyTrain,
                  //controller: modelData.pwdPic,
                  suffixIcon: Icons.wysiwyg,
                  validator: _addFormBorrow.type == 1
                      ? null
                      : MyValidate.checkEmptyFile,
                  counter: buildText(),
                  onTap: () => getImage().then((value) {
                    setState(() {
                      _addFormBorrow.fileCopyTrain = value;
                      _addFormBorrow.nameFileCopyTrain.text = value!.name;
                    });
                  }),
                  //onTap: () => getImage(),
                  readOnly: true,
                ),
                MyWidget.buildSizedBox('h', 18),
                mytextfield(
                  labelText:
                      'สำเนาบัตรประจำตัวประชาชน/สำเนาทะเบียนบ้านของ ผู้ยื่นคำขอแทน',
                  hintText:
                      'สำเนาบัตรประจำตัวประชาชน/สำเนาทะเบียนบ้านของ ผู้ยื่นคำขอแทน',
                  //controller: modelData.pwdPic,
                  suffixIcon: Icons.wysiwyg,
                  validator: _addFormBorrow.type == 1
                      ? null
                      : MyValidate.checkEmptyFile,
                  counter: buildText(),
                  controller: _addFormBorrow.nameFileSubCopyCitizenId,
                  onTap: () => getImage().then((value) {
                    setState(() {
                      _addFormBorrow.fileSubCopyCitizenId = value;
                      _addFormBorrow.nameFileSubCopyCitizenId.text =
                          value!.name;
                    });
                  }),
                  readOnly: true,
                ),
                MyWidget.buildSizedBox('h', 18),
                mytextfield(
                  labelText: 'หนังสือมอบอำนาจจากคนพิการ',
                  hintText: 'หนังสือมอบอำนาจจากคนพิการ',
                  //controller: modelData.pwdPic,
                  onTap: () => getImage().then((value) {
                    setState(() {
                      _addFormBorrow.filePowerAttorney = value;
                      _addFormBorrow.nameFilePowerAttorney.text = value!.name;
                    });
                  }),
                  suffixIcon: Icons.wysiwyg,
                  validator: _addFormBorrow.type == 1
                      ? null
                      : MyValidate.checkEmptyFile,
                  controller: _addFormBorrow.nameFilePowerAttorney,
                  counter: buildText(),
                  //onTap: () => getImage(),
                  readOnly: true,
                ),
                MyWidget.buildSizedBox('h', 18),
                RadioListTile(
                  value: 1,
                  groupValue: _addFormBorrow.type,
                  title: Text(
                    "คนพิการ",
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onChanged: (int? value) {
                    _addFormBorrow.type = value!;
                    setState(() {});
                  },
                ),
                RadioListTile(
                  value: 2,
                  groupValue: _addFormBorrow.type,
                  title: Text(
                    "ผู้ยื่นคำขอแทน",
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onChanged: (int? value) {
                    _addFormBorrow.type = value!;
                    setState(() {});
                  },
                ),
                MyWidget.buildSizedBox('h', 18),
                mytextfield(
                  labelText: 'วัตถุประสงค์ *',
                  validator: MyValidate.checkEmpty,
                  controller: _addFormBorrow.objective1,
                  hintText: 'วัตถุประสงค์ *',
                ),
                MyWidget.buildSizedBox('h', 18),
                mydropdown(
                  label: 'กลุ่มหลัก',
                  listdata: dataGroupId
                      .map(
                        (e) => DropdownMenuItem<int>(
                          value: e['id'],
                          child: Text(
                            e['name'],
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _addFormBorrow.mainGroupsId = value;
                      _addFormBorrow.subGroupsId = null;
                      _addFormBorrow.accessorieList = null;
                      setDataSubGroupId(value);
                    });
                  },
                  validator: MyValidate.checkEmptySelect,
                ),
                MyWidget.buildSizedBox('h', 18),
                mydropdown(
                  label: 'กลุ่มย่อย',
                  listdata: dataSubGroupId
                      .map(
                        (e) => DropdownMenuItem<int>(
                          value: e['id'],
                          child: Text(
                            e['name'],
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _addFormBorrow.subGroupsId = value;
                      _addFormBorrow.accessorieList = null;
                      setCategories(value);
                    });
                  },
                  validator: MyValidate.checkEmptySelect,
                ),
                MyWidget.buildSizedBox('h', 18),
                mydropdown(
                  label: 'ชื่ออุปกรณ์',
                  listdata: dataCategories
                      .map(
                        (e) => DropdownMenuItem<int>(
                          value: e['id'],
                          child: Text(
                            e['name'],
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    _addFormBorrow.accessorieList = value;
                  },
                  validator: MyValidate.checkEmptySelect,
                ),
                MyWidget.buildSizedBox('h', 18),
                mytextfield(
                  labelText: 'เลขที่อุปกรณ์',
                  //validator: MyValidate.checkEmpty,
                  hintText: 'เลขที่อุปกรณ์',
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Mybtn(
                  text: 'ส่งข้อมูล',
                  ontap: () => sendAddFormBorrow(),
                  color: Colors.green,
                ),
              ),
              MyWidget.buildSizedBox('w', 10),
              Expanded(
                child: Mybtn(
                  text: 'ย้อนกลับ',
                  ontap: () => Navigator.pop(context),
                  color: Color(0xffFA601B),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Text buildText() {
    return Text(
      "1 ฉบับ พร้อมรับรองสำเนาถูกต้อง",
      style: TextStyle(fontSize: 13),
    );
  }
}
