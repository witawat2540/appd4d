import 'package:d4dapp/service/mycolors.dart';
import 'package:flutter/material.dart';

class SelectTypeApp extends StatelessWidget {
  final List data;

  const SelectTypeApp({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("หมวดหมู่แอพพลิเคชั่น"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: data
              .map(
                (e) => MyTitletypeapp(
                  name: '${e['group_name']}',
                  onTap: () {
                    Navigator.pop(
                      context,
                      {'id': e['id'], 'name': e['group_name']},
                    );
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class MyTitletypeapp extends StatelessWidget {
  final String name;
  final VoidCallback? onTap;

  const MyTitletypeapp({
    Key? key,
    required this.name,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("$name"),
      leading: Icon(
        Icons.circle,
        color: MyColors.colorApp,
      ),
      onTap: onTap,
    );
  }
}
