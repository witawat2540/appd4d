import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onde_app/model/form_add_receive_model.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/page/adddevice_02.dart';
import 'package:onde_app/service/mytextfild.dart';
import 'package:onde_app/service/myunitity.dart';
import 'package:onde_app/service/mywidget.dart';
import 'package:onde_app/service/validate.dart';

class AddFromReceive extends StatefulWidget {
  const AddFromReceive({Key? key}) : super(key: key);

  @override
  _AddFromReceiveState createState() => _AddFromReceiveState();
}

class _AddFromReceiveState extends State<AddFromReceive> {
  AddFormReceiveModel _addFromReceiveModel = AddFormReceiveModel();
  ImagePicker _picker = ImagePicker();
  GlobalKey<ScaffoldState> _keyScaffold = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

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

  Future sendAddFormReceive() async {
    if (_keyForm.currentState!.validate()) {
      //_addFromReceiveModel.accessorieList = [];
      _addFromReceiveModel.image = [];

      await _addFromReceiveModel.setFile();
      //print(_addFromReceiveModel.accessorieList);
      if(_addFromReceiveModel.accessorieList.isNotEmpty){
        await ConnectAPI()
            .httpMultiFormHeaders(
          _addFromReceiveModel.toJson(),
          _addFromReceiveModel.image,
          'create-form-receive',
        )
            .then((value) async {
          //print(value.stream);
          if (value.statusCode == 200) {
            Navigator.pop(context, true);
            //print(await value.stream.bytesToString());
          } else {
            //print(await value.stream.bytesToString());
            MyWidget.showInSnackBar('??????????????????????????????????????????', Colors.white,
                _keyScaffold, Colors.redAccent, 2, Icons.close);
          }
        } ).catchError((onError) {
          print(onError);
          MyWidget.showInSnackBar('??????????????????????????????????????????', Colors.white,
              _keyScaffold, Colors.redAccent, 2, Icons.close);
        });
      }else{
        MyWidget.showInSnackBar('???????????????????????????????????????????????????', Colors.white,
            _keyScaffold, Colors.redAccent, 2, Icons.close);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyScaffold,
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
                  text: '???????????????????????????????????????',
                ),
                Mysutitle(
                  text:
                      '????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????',
                  vertical: 5,
                ),
                Mysutitle14(text: '??????????????????????????????????????????????????????', vertical: 20),
                mytextfield(
                  labelText: '?????????????????????????????????????????????????????????????????????????????????',
                  hintText: '?????????????????????????????????????????????????????????????????????????????????',
                  controller: _addFromReceiveModel.nameFilesCopyCard,
                  validator: MyValidate.checkEmptyFile,
                  counter: buildText(),
                  suffixIcon: Icons.wysiwyg,
                  onTap: () => getImage().then((value) {
                    setState(() {
                      _addFromReceiveModel.fileCopyCard = value;
                      _addFromReceiveModel.nameFilesCopyCard.text = value!.name;
                    });
                  }),
                  readOnly: true,
                ),
                MyWidget.buildSizedBox('h', 18),
                mytextfield(
                  labelText: '??????????????????????????????????????????????????????????????????????????????',
                  hintText: '??????????????????????????????????????????????????????????????????????????????',
                  controller: _addFromReceiveModel.nameFilesHouseRes,
                  suffixIcon: Icons.wysiwyg,
                  validator: MyValidate.checkEmptyFile,
                  counter: buildText(),
                  onTap: () => getImage().then((value) {
                    setState(() {
                      _addFromReceiveModel.fileHouseRes = value;
                      _addFromReceiveModel.nameFilesHouseRes.text = value!.name;
                    });
                  }),
                  //onTap: () => getImage(),
                  readOnly: true,
                ),
                MyWidget.buildSizedBox('h', 18),
                mytextfield(
                  labelText: '???????????????????????????????????????????????????????????????????????????????????????????????????????????????',
                  hintText: '???????????????????????????????????????????????????????????????????????????????????????????????????????????????',
                  controller: _addFromReceiveModel.nameFileCopyTrain,
                  //controller: modelData.pwdPic,
                  suffixIcon: Icons.wysiwyg,
                  validator: _addFromReceiveModel.type == 1
                      ? null
                      : MyValidate.checkEmptyFile,
                  counter: buildText(),
                  onTap: () => getImage().then((value) {
                    setState(() {
                      _addFromReceiveModel.fileCopyTrain = value;
                      _addFromReceiveModel.nameFileCopyTrain.text = value!.name;
                    });
                  }),
                  //onTap: () => getImage(),
                  readOnly: true,
                ),
                MyWidget.buildSizedBox('h', 18),
                mytextfield(
                  labelText:
                      '????????????????????????????????????????????????????????????????????????/????????????????????????????????????????????????????????? ??????????????????????????????????????????',
                  hintText:
                      '????????????????????????????????????????????????????????????????????????/????????????????????????????????????????????????????????? ??????????????????????????????????????????',
                  //controller: modelData.pwdPic,
                  suffixIcon: Icons.wysiwyg,
                  validator: _addFromReceiveModel.type == 1
                      ? null
                      : MyValidate.checkEmptyFile,
                  counter: buildText(),
                  controller: _addFromReceiveModel.nameFileSubCopyCitizenId,
                  onTap: () => getImage().then((value) {
                    setState(() {
                      _addFromReceiveModel.fileSubCopyCitizenId = value;
                      _addFromReceiveModel.nameFileSubCopyCitizenId.text =
                          value!.name;
                    });
                  }),
                  readOnly: true,
                ),
                MyWidget.buildSizedBox('h', 18),
                mytextfield(
                  labelText: '???????????????????????????????????????????????????????????????????????????',
                  hintText: '???????????????????????????????????????????????????????????????????????????',
                  //controller: modelData.pwdPic,
                  onTap: () => getImage().then((value) {
                    setState(() {
                      _addFromReceiveModel.filePowerAttorney = value;
                      _addFromReceiveModel.nameFilePowerAttorney.text =
                          value!.name;
                    });
                  }),
                  suffixIcon: Icons.wysiwyg,
                  validator: _addFromReceiveModel.type == 1
                      ? null
                      : MyValidate.checkEmptyFile,
                  controller: _addFromReceiveModel.nameFilePowerAttorney,
                  counter: buildText(),
                  //onTap: () => getImage(),
                  readOnly: true,
                ),
                MyWidget.buildSizedBox('h', 18),
                RadioListTile(
                  value: 1,
                  groupValue: _addFromReceiveModel.type,
                  title: Text(
                    "?????????????????????",
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onChanged: (int? value) {
                    _addFromReceiveModel.type = value!;
                    setState(() {});
                  },
                ),
                RadioListTile(
                  value: 2,
                  groupValue: _addFromReceiveModel.type,
                  title: Text(
                    "??????????????????????????????????????????",
                    style: Theme.of(context).textTheme.body1,
                  ),
                  onChanged: (int? value) {
                    _addFromReceiveModel.type = value!;
                    setState(() {});
                  },
                ),
                MyWidget.buildSizedBox('h', 18),
                mytextfield(
                  labelText: '???????????????????????????????????? *',
                  validator: MyValidate.checkEmpty,
                  controller: _addFromReceiveModel.objective1,
                  hintText: '???????????????????????????????????? *',
                ),
                MyWidget.buildSizedBox('h', 18),
                Mybtn(
                  text: '????????????????????????????????????',
                  //ontap: () => sendAddFormBorrow(),
                  ontap: () => Navigator.push(
                    context,
                    Unitity.materialPageRoute(
                      AddDevice02(),
                    ),
                  ).then((value) {
                    if (value != null) {
                      if(_addFromReceiveModel.accessorieName.where((element) => element == value['name']).isEmpty){
                        _addFromReceiveModel.accessorieList.add(value['id']);
                        _addFromReceiveModel.accessorieName.add(value['name']);
                      }else{
                        MyWidget.showInSnackBar('????????????????????????????????????????????????', Colors.white,
                            _keyScaffold, Colors.redAccent, 2, Icons.close);
                      }
                      setState(() {

                      });
                    }
                  }),
                  color: Colors.green,
                ),
                MyWidget.buildSizedBox('h', 18),
                Column(
                  children: _addFromReceiveModel.accessorieName
                      .map(
                        (e) => Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          elevation: 4,
                          child: ListTile(
                            title: Text('$e'),
                            trailing: IconButton(
                              onPressed: (){
                                _addFromReceiveModel.accessorieName.removeWhere((element) => element == e);
                                setState(() {

                                });
                              },
                              icon: Icon(Icons.delete,color: Colors.redAccent,),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
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
                  text: '???????????????????????????',
                  ontap: () => sendAddFormReceive(),
                  //ontap: () {},
                  color: Colors.green,
                ),
              ),
              MyWidget.buildSizedBox('w', 10),
              Expanded(
                child: Mybtn(
                  text: '????????????????????????',
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
      "1 ???????????? ?????????????????????????????????????????????????????????????????????",
      style: TextStyle(fontSize: 13),
    );
  }
}
