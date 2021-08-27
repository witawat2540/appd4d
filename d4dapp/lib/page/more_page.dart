import 'package:d4dapp/page/searchpage.dart';
import 'package:d4dapp/service/my_fuction.dart';
import 'package:d4dapp/service/myitemapp.dart';
import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  final List data;
  final String path, titel;

  const MorePage(
      {Key? key, required this.data, required this.path, required this.titel})
      : super(key: key);

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        //iconTheme: IconThemeData(color: Colors.black),
        title: Text('D4D Portal App'),
        centerTitle: true,
        actions: [
          IconButton(
            splashRadius: 20,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchPage(),
              ),
            ),
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.titel}',
                    // 'test',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
              ),
              widget.titel == 'แอพพลิเคชั่นมาใหม่'
                  ? Wrap(
                      runAlignment: WrapAlignment.start,
                      children: widget.data
                          .map(
                            (e) => MyItemApp(
                              onTap: () =>
                                  MyFuction().getdata(e['id'], context),
                              nameApp: e['app_name_th'],
                              iconApp: '${widget.path}/${e['icon']}',
                              rateApp: e['rating'],
                              android: e['link_android'] == null ? false : true,
                              windows: e['link_windows'] == null ? false : true,
                              ios: e['link_ios'] == null ? false : true,
                            ),
                          )
                          .toList(),
                    )
                  : Wrap(
                      runAlignment: WrapAlignment.start,
                      children: widget.data
                          .map(
                            (e) => MyItemApp(
                              onTap: () => MyFuction().getdata(
                                  e['application_groups']['id'], context),
                              nameApp: e['application_groups']['app_name_th'],
                              iconApp:
                                  '${widget.path}/${e['application_groups']['icon']}',
                              rateApp: e['application_groups']['rating'],
                              android: e['application_groups']
                                          ['link_android'] ==
                                      null
                                  ? false
                                  : true,
                              windows: e['application_groups']
                                          ['link_windows'] ==
                                      null
                                  ? false
                                  : true,
                              ios: e['application_groups']['link_ios'] == null
                                  ? false
                                  : true,
                            ),
                          )
                          .toList(),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
