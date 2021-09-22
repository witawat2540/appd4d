import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onde_app/model/documentmodel.dart';
import 'package:onde_app/network/connect.dart';
import 'package:onde_app/service/mywidget.dart';

class DocumentPage extends StatefulWidget {
  const DocumentPage({Key? key}) : super(key: key);

  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  List<GetDocumentModel> _dataAllDocument = [];

  Future _getDocument() async {
    await ConnectAPI().get('get-all-document').then((value) {
      if (value.statusCode == 200 && jsonDecode(value.body)['status'] == true) {
        setState(() {
          String data = jsonEncode(jsonDecode(value.body)['data']);
          _dataAllDocument = getDocumentModelFromJson(data);
        });
      }
      //this.setDataAddress();
    });
  }

  @override
  void initState() {
    this._getDocument();
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
                text: 'เอกสารที่เกี่ยวข้อง',
              ),
              MyWidget.buildSizedBox('h', 20),
              Mytexth2(
                text: 'เอกสารหลักฐานที่เกี่ยวข้อง',
                onTap: () {},
                onbtn: true,
              ),
              MyWidget.buildSizedBox('h', 20),
              Column(
                children: _dataAllDocument.map((e) {
                  int index = _dataAllDocument.indexOf(e) + 1;
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //color: Colors.black12,
                            width: MediaQuery.of(context).size.width - 90,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$index. ${e.title}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
