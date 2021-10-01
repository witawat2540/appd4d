import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class DialogVideo extends StatefulWidget {
  final String? tagIfreme;

  const DialogVideo({Key? key, this.tagIfreme}) : super(key: key);

  @override
  _DialogVideoState createState() => _DialogVideoState();
}

class _DialogVideoState extends State<DialogVideo> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      title: Text(
        "ศึกษาการใช้อุปกรณ์",
        style: TextStyle(fontSize: 16),
      ),
      content: Container(
        child: Html(
            data: widget.tagIfreme,
            onLinkTap: (url, _, __, ___) async {
              if (await canLaunch(url!)) {
                await launch(
                  url,
                );
              } else {
                throw 'Could not launch $url';
              }
            }),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Ok"),
            )
          ],
        )
      ],
    );
  }
}
