import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    required this.text,required this.vertical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 100,
          margin: EdgeInsets.symmetric(vertical: vertical),
          //color: Colors.black45,
          child: Text("$text", style: Theme.of(context).textTheme.subtitle),
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
