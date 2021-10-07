import 'package:flutter/material.dart';
import 'package:onde_app/service/mydropdown.dart';
import 'package:onde_app/service/mytextfild.dart';
import 'package:onde_app/service/mywidget.dart';
import 'package:onde_app/service/validate.dart';

import 'fuction.dart';

class AddDevice02 extends StatefulWidget {
  const AddDevice02({Key? key}) : super(key: key);

  @override
  _AddDevice02State createState() => _AddDevice02State();
}

class _AddDevice02State extends State<AddDevice02> {
  List dataGroupId = [];
  List dataSubGroupId = [];
  List dataCategories = [];
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  int accessorieList = 0;
  String accessorieName = '';

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

  Future setDataGroupId() async {
    await MyFunction.getGroupId().then((value) {
      setState(() {
        dataGroupId = value;
      });
    });
  }

  @override
  void initState() {
    this.setDataGroupId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: _keyForm,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Mytitle(
                  text: 'เพิ่มอุปกรณ์',
                ),
                Mysutitle(
                  text:
                      'แบบคำขอยืมอุปกรณ์และเครื่องมือเทคโนโลยีสารสนเทศและการสื่อสาร',
                  vertical: 5,
                ),
                Mysutitle14(text: 'เลือกอุปกรณ์', vertical: 20),
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
                      //_addFormBorrow.mainGroupsId = value;
                      //_addFormBorrow.subGroupsId = null;
                      //_addFormBorrow.accessorieList = null;
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
                      //_addFormBorrow.subGroupsId = value;
                      //_addFormBorrow.accessorieList = null;
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
                    accessorieList = value;

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
                  text: 'บันทึก',
                  //ontap: () => sendAddFormBorrow(),
                  ontap: () {
                    if(_keyForm.currentState!.validate()){
                      setState(() {

                      });
                      accessorieName = dataCategories.where((element) => element['id'] == accessorieList).toList()[0]['name'];
                      //print();
                      var data = {
                        'id':accessorieList,
                        'name':accessorieName
                      };
                      Navigator.pop(context,data);
                    }
                  },
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
}
