import 'package:d4dapp/service/mywidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailText extends StatefulWidget {
  final String nameapp, path, detail;

  const DetailText({
    Key? key,
    required this.nameapp,
    required this.path,
    required this.detail,
  }) : super(key: key);

  @override
  _DetailTextState createState() => _DetailTextState();
}

class _DetailTextState extends State<DetailText> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 8,
                      offset: Offset(0, 5))
                ],
                image: DecorationImage(
                  image: NetworkImage(widget.path),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            MyWidget.buildSizedBox('w', 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    widget.nameapp,
                    style: GoogleFonts.prompt(fontSize: 15),
                  ),
                  width: MediaQuery.of(context).size.width - 150,
                ),
                Text(
                  'รายละเอียด',
                  style: GoogleFonts.prompt(fontSize: 12),
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text(widget.detail),
            ),
          ],
        ),
      ),
    );
  }
}
