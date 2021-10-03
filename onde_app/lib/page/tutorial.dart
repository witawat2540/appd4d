import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:onde_app/model/tutorialmodel.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/page/fuction.dart';
import 'package:onde_app/service/dialogvideo.dart';
import 'package:onde_app/service/getDataAddress.dart';
import 'package:onde_app/service/mycolors.dart';
import 'package:onde_app/service/myunitity.dart';
import 'package:onde_app/service/mywidget.dart';
import 'package:url_launcher/url_launcher.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({Key? key}) : super(key: key);

  @override
  _TutorialState createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  GetTutorialModel _getTutorialModel = GetTutorialModel();
  List<Map<String, dynamic>> _dataTutorial = [];
  List groupId = [];

  Future _getDataTutorial() async {
    await MyFunction.getGroupId().then((value) {
      groupId = value;
    });
    await ConnectAPI().get('tutorial').then((value) {
      if (value.statusCode == 200 || jsonDecode(value.body)['status'] == true) {
        Map<String, dynamic> data =
            Map<String, dynamic>.from(jsonDecode(value.body)['data']);
        setState(() {
          int count = 1;
          List<Map<String, dynamic>> newData = [];
          data.keys.forEach((element) {
            if (element == count.toString()) {
              count++;
              var dataNameTitle =
                  Map<String, dynamic>.from(data['total'][element]);
              var image = Map<String, dynamic>.from(data['image'][element]);
              var doc = Map<String, dynamic>.from(data['doc'][element]);
              var url = Map<String, dynamic>.from(data['url'][element]);
              var id = Map<String, dynamic>.from(data['assetId'][element]);
              var dataDevice = Map<String, dynamic>.from(data[element]);
              var nameGroup = groupId
                  .where((valueGroup) => valueGroup['id'] == int.parse(element))
                  .toList()[0]['name'];
              var total = Map<String, dynamic>.from(data['total'][element])
                  .values
                  .toList()
                  .reduce((value, element) => value + element);
              var detail = _getTutorialModel.setDetail(
                  data: dataNameTitle,
                  image: image,
                  dataDevice: dataDevice,
                  doc: doc,
                  assetId: id,
                  url: url);
              newData.add({
                'id': element,
                'nameGroup': nameGroup,
                'total': total,
                'detail': detail
              });
            }
          });
          //print(newData);
          setState(() {
            _dataTutorial = newData;
          });
          _getTutorialModel = getTutorialModelFromJson(value.body);
          //print(_dataPractice[0].name);
        });
      }
      //this.setDataAddress();
    });
  }

  Future sendBooking(int id) async {
    await ConnectAPI()
        .postHeaders(jsonEncode({'assetCategoryId': id}), 'booking')
        .then((value) async {
      if (value.statusCode == 200 && jsonDecode(value.body)['status'] == true) {
        // Navigator.pop(context, true);
        this._getDataTutorial();
        MyWidget.showInSnackBarContext('ทำรายการสำเร็จ', Colors.white, context,
            MyColors.colorText_bule, 3, Icons.check_circle);
      } else {
        MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white, context,
            Colors.redAccent, 2, Icons.close);
      }
    }).catchError((onError) {
      MyWidget.showInSnackBarContext('เกิดข้อผิดพลาด', Colors.white, context,
          Colors.redAccent, 2, Icons.close);
    });
    /*MyWidget.showInSnackBar('เกิดข้อผิดพลาด', Colors.white,
        _keyScaffoldState, Colors.redAccent, 2, Icons.close);*/
  }

  /*List setNameDetail(Map<String, dynamic> data, Map<String, dynamic> dataDevice,
      Map<String, dynamic> image) {
    var newData = [];
    //print(image);
    data.forEach((key, value) {
      var newData2 = [];
      Map<String, dynamic>.from(dataDevice[key]).forEach((key2, value2) {
        //print(image[key2]);
        newData2.add({'name': key2, 'count': value2, 'image': image[key2]});
      });

      newData.add(
          {'nameDevice': key, 'totalDevice': value, 'detailDevice': newData2});
    });
    return newData;
  }*/

  /*List getdetail(List<dynamic> detail) {
    var newDataDetail = [];
    print(detail);
    */ /*detail.forEach((element) {
      print(element.keys.toList());

      newDataDetail = element.keys.toList();
    });*/ /*

    return newDataDetail;
  }*/

  @override
  void initState() {
    this._getDataTutorial();
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
              /*ElevatedButton(
                child: Text(""),
                onPressed: () => _getDataTutorial(),
              ),*/
              Mytitle(
                text: 'รายละเอียดอุปกรณ์',
              ),
              Mysutitle(
                text: 'ข้อมูลผู้ยื่นคำขอแทนคนพิการ',
                vertical: 5,
              ),
              Mysutitle(
                  text:
                      'อุปกรณ์และเครื่องมือคงเหลือทั้งหมด ${Unitity.f.format(_getTutorialModel.data?.sum ?? 0)} รายการ',
                  vertical: 20),
              /*Mysutitle(
                text:
                    'เทคโนโลยีสารสนเทศและการสื่อสาร 0 รายการ',
                vertical: 20,
              ),*/
              Column(
                children: _dataTutorial.map(
                  (e) {
                    return Column(
                      children: [
                        Mysutitle(
                          text:
                              '${e['nameGroup']} ${Unitity.f.format(e['total'])} รายการ',
                          vertical: 20,
                        ),
                        Column(
                          children: List.from(e['detail']).map((detail) {
                            int index = e['detail'].indexOf(detail) + 1;
                            return Column(
                              children: [
                                buildtitel(
                                    context,
                                    '$index. ${detail['nameDevice']}',
                                    '${Unitity.f.format(detail['totalDevice'])}'),
                                Column(
                                  children: List.from(detail['detailDevice'])
                                      .map((detailDevice) {
                                    int no = detail['detailDevice']
                                            .indexOf(detailDevice) +
                                        1;
                                    return MyCardDevice(
                                      title: '$no. ${detailDevice['name']}',
                                      bytes: Uri.parse(detailDevice['image'])
                                          .data!
                                          .contentAsBytes(),
                                      doc: detailDevice['doc'] == null
                                          ? detailDevice['doc']
                                          : ConnectAPI.urlDoc +
                                              detailDevice['doc'],
                                      onTapBookmark: _getTutorialModel.hasbooking == null ? (){
                                        sendBooking(detailDevice['id']);
                                      }:null,
                                      url: detailDevice['url'],
                                      num:
                                          '${Unitity.f.format(detailDevice['count'])}',
                                    );
                                  }).toList(),
                                ),
                                MyWidget.buildSizedBox('h', 25)
                              ],
                            );
                          }).toList(),
                        )
                        /*buildtitel(
                            context,
                            '$index.${e[index.toString()]['name']}',
                            '${Unitity.f.format(e[index.toString()]['total'])}'),

                        MyWidget.buildSizedBox('h', 25),*/
                      ],
                    );
                  },
                ).toList(),
              ),
              /*buildtitel(context, '1.เครื่องคอมพิวเตอร์', '415'),
              MyCardDevice(
                          title: '1.เครื่องคอมพิวเตอร์แบบตั้งโต๊ะ',
                          num: '105',
                          onTapBookmark: () {
                            _getDataTutorial();
                          },
                        ),
              MyCardDevice(
                title: '2.เครื่องคอมพิวเตอร์แบบพกพา',
                num: '305',
              ),
              MyCardDevice(
                title: '3.เครื่องแท็บเล็ตSamsung Galaxy Tab 4 10.1”',
                num: '5',
              ),
              MyWidget.buildSizedBox('h', 25),
              buildtitel(
                  context, '2.อุปกรณ์สื่อสาร (โทรศัพท์เคลื่อนที่)', '1,504'),
              MyCardDevice(
                title: '1. Samsung Galaxy Grand 2',
                num: '1,504',
              ),
              Mysutitle(
                text: 'เทคโนโลยีสิ่งอำรวยความสะดวกเพื่อการสื่อสาร 672 รายการ',
                vertical: 40,
              ),
              buildtitel(context, '1.เครื่องคอมพิวเตอร์', '415'),
              MyCardDevice(
                title: '1.เครื่องคอมพิวเตอร์แบบตั้งโต๊ะ',
                num: '105',
              ),
              MyCardDevice(
                title: '2.เครื่องคอมพิวเตอร์แบบพกพา',
                num: '305',
              ),
              MyCardDevice(
                title: '3.เครื่องแท็บเล็ตSamsung Galaxy Tab 4 10.1”',
                num: '5',
              ),
              MyWidget.buildSizedBox('h', 25),
              buildtitel(
                  context, '2.อุปกรณ์สื่อสาร (โทรศัพท์เคลื่อนที่)', '1,504'),
              MyCardDevice(
                title: '1. Samsung Galaxy Grand 2',
                num: '1,504',
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  Row buildtitel(BuildContext context, String text, String count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(
            '$text',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          //color: Colors.black12,
          width: MediaQuery.of(context).size.width - 150,
        ),
        Text('$count'),
      ],
    );
  }
}

class MyCardDevice extends StatelessWidget {
  final String title, num;
  final Uint8List bytes;

  final VoidCallback? onTapBookmark;
  final String? doc;
  final String? url;

  const MyCardDevice({
    Key? key,
    required this.title,
    required this.num,
    this.onTapBookmark,
    required this.bytes,
    this.doc,
    this.url,
  }) : super(key: key);

  Future<void> _gotoWeb(String url) async {
    //print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(top: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 44,
                      width: 60,
                      decoration: BoxDecoration(
                        color: MyColors.colorText_bule,
                        image: DecorationImage(
                            image: MemoryImage(bytes), fit: BoxFit.fill),
                      ),
                    ),
                    Container(
                      child: Text(
                        '$title',
                      ),
                      //color: Colors.black12,
                      width: MediaQuery.of(context).size.width - 200,
                    )
                  ],
                ),
                Text('$num')
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //mainAxisSize: MainAxisSize.min,
            ),
            MyWidget.buildSizedBox('h', 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: onTapBookmark == null
                      ? Colors.grey
                      : MyColors.colorText_bule,
                  child: IconButton(
                    onPressed: onTapBookmark,
                    splashRadius: 20,
                    icon: Icon(
                      Icons.bookmark,
                      color: Colors.white,
                    ),
                  ),
                ),
                MyWidget.buildSizedBox('w', 10),
                CircleAvatar(
                  backgroundColor:
                      doc == null ? Colors.grey : MyColors.colorText_bule,
                  child: IconButton(
                    onPressed: doc == null ? null : () => _gotoWeb(doc!),
                    splashRadius: 20,
                    icon: Icon(
                      Icons.monitor,
                      color: Colors.white,
                    ),
                  ),
                ),
                MyWidget.buildSizedBox('w', 10),
                CircleAvatar(
                  backgroundColor:
                      url == null ? Colors.grey : MyColors.colorText_bule,
                  child: IconButton(
                    onPressed: url == null
                        ? null
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) => DialogVideo(
                                tagIfreme: url,
                              ),
                            );
                          },
                    splashRadius: 20,
                    icon: Icon(
                      Icons.play_circle_fill,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
