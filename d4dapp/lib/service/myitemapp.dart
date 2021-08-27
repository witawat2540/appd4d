import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'mywidget.dart';

class MyItemApp extends StatelessWidget {
  final String nameApp, iconApp;
  final int rateApp;
  final bool ios, android, windows;
  final VoidCallback? onTap;

  const MyItemApp({
    Key? key,
    required this.nameApp,
    //required this.nameDev,
    required this.iconApp,
    required this.rateApp,
    this.ios = false,
    this.android = false,
    this.windows = false, this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 180,
          padding: EdgeInsets.all(8),
          //width: double.infinity,
          //height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //color: Colors.amber,
                margin: EdgeInsets.all(10),
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54,
                        blurRadius: 8,
                        offset: Offset(0, 5))
                  ],
                  image: DecorationImage(
                      image: NetworkImage('$iconApp'), fit: BoxFit.fill),
                ),
              ),
              Container(
                //color: Colors.black45,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: 10),
                width: MediaQuery.of(context).size.width - 220,
                child: Text(
                  "$nameApp",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                //color: Colors.black45,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(vertical: 3),
                width: MediaQuery.of(context).size.width - 250,
                child: Text(
                  "Developer Team",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle,
                  maxLines: 1,
                ),
              ),
              MyWidget.buildSizedBox('h', 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [buildIcon()],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        if (android)
                          FaIcon(
                            FontAwesomeIcons.googlePlay,
                            size: 18,
                          ),
                        if (ios) MyWidget.buildSizedBox('w', 5),
                        if (ios)
                          FaIcon(
                            FontAwesomeIcons.appStoreIos,
                            size: 18,
                          ),
                        if (windows) MyWidget.buildSizedBox('w', 5),
                        if (windows)
                          FaIcon(
                            FontAwesomeIcons.windows,
                            size: 18,
                          ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  buildIcon() {
    return Row(
      children: [
        for (int i = 0; i < rateApp; i++)
          Icon(
            Icons.star,
            size: 18,
          ),
        for (int i = 0; i < (5 - rateApp); i++)
          Icon(
            Icons.star_border,
            size: 18,
          ),
      ],
    );
  }
}