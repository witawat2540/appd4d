import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mycolors.dart';

class MyWidget {
  static SizedBox buildSizedBox(String type, double size) {
    if (type == "h") {
      return SizedBox(
        height: size,
      );
    } else {
      return SizedBox(
        width: size,
      );
    }
  }

  static AppBar buildAppBar() {
    return AppBar(
      title: Text('ONDE'),
      centerTitle: true,
    );
  }

  static void showInSnackBar(
      String value,
      Color stColor,
      GlobalKey<ScaffoldState> _scaffoldKey,
      Color bgColor,
      int seconds,
      IconData icon) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 10,
      content: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          buildSizedBox('w', 20),
          Text(
            value,
            style: GoogleFonts.prompt(color: stColor, fontSize: 17),
          ),
        ],
      ),
      backgroundColor: bgColor,
      duration: Duration(seconds: seconds),
    ));
  }

  static EdgeInsets buildEdgeInsets() =>
      EdgeInsets.symmetric(horizontal: 10, vertical: 7);
}

class myh extends StatelessWidget {
  final String text;

  const myh({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Text(
        "$text",
        style: Theme.of(context)
            .textTheme
            .title!
            .apply(color: MyColors.colorText_bule, fontWeightDelta: 20),
      ),
    );
  }
}

class Mysutitle extends StatelessWidget {
  final String text;
  final double vertical;

  const Mysutitle({
    Key? key,
    required this.text,
    required this.vertical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 80,
          margin: EdgeInsets.symmetric(vertical: vertical),
          //color: Colors.black45,
          child: Text(
            "$text",
          ),
        ),
      ],
    );
  }
}

class Mysutitle14 extends StatelessWidget {
  final String text;
  final double vertical;

  const Mysutitle14({
    Key? key,
    required this.text,
    required this.vertical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 100,
          margin: EdgeInsets.symmetric(vertical: vertical),
          //color: Colors.black45,
          child: Text(
            "$text",
            style: Theme.of(context).textTheme.subtitle,
          ),
        ),
      ],
    );
  }
}

class Mytitle extends StatelessWidget {
  final String text;

  const Mytitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 100,
          //margin: EdgeInsets.symmetric(vertical: 10),
          //color: Colors.black45,
          child: Text(
            "$text",
            style: Theme.of(context).textTheme.caption!.apply(
                  color: MyColors.colorText_label,
                  fontWeightDelta: 10,
                ),
          ),
        ),
      ],
    );
  }
}

class Mytexth extends StatelessWidget {
  final String text;

  const Mytexth({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$text',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class Mytexth2 extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final bool onbtn;

  const Mytexth2({
    Key? key,
    this.onTap,
    required this.text,
    this.onbtn = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$text',
          style: Theme.of(context).textTheme.body2!.apply(fontWeightDelta: 10),
        ),
        if (!onbtn)
          IconButton(
            splashRadius: 20,
            onPressed: onTap,
            icon: Icon(Icons.edit_outlined),
          )
      ],
    );
  }
}

class Mybtn extends StatelessWidget {
  final Color? color;
  final String text;
  final VoidCallback? ontap;

  const Mybtn({
    Key? key,
    this.color,
    required this.text,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 49,
      child: ElevatedButton(
        style: color == null ? null : ElevatedButton.styleFrom(primary: color),
        child: Text('$text'),
        onPressed: ontap,
      ),
    );
  }
}
