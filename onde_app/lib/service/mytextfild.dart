import 'package:flutter/material.dart';
import 'package:onde_app/service/mycolors.dart';

class mytextfield extends StatelessWidget {
  final String? hintText, labelText;
  final suffixIcon;
  final VoidCallback? onTap;
  final int? maxLength;
  final bool obscureText;
  final Function? validator, onChanged;
  final TextInputType? keyboardType;
  final Function(String?)? onSave;
  final int? maxLines;
  final TextEditingController? controller;
  final bool readOnly;

  //final int maxLines;

  const mytextfield({
    Key? key,
    this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.onSave,
    this.onTap,
    this.controller,
    this.readOnly = false,
    this.maxLength,
    this.onChanged,
    this.labelText, this.maxLines,
    // this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(),
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        onTap: onTap,
        //onChanged: onChanged,
        obscureText: obscureText,
        validator: validator as String? Function(String? value)?,
        onSaved: onSave,
        obscuringCharacter: '*',
        maxLines: maxLines,
        style: Theme.of(context).textTheme.bodyText2,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          errorStyle: TextStyle(color: Colors.redAccent,fontSize: 13),
          labelStyle: TextStyle(color: MyColors.colorText_label),
          //contentPadding: EdgeInsets.all(0),
          hintStyle: TextStyle(color: MyColors.colorTexthittext),
          contentPadding:
              new EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
          counterText: '',
          border: new OutlineInputBorder(
            //borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
          // border: InputBorder.none,
          suffixIcon: Icon(suffixIcon),
        ),
        //maxLines: maxLines,
        maxLength: maxLength,
      ),
    );
  }
}


class MyTextFieldPass extends StatelessWidget {
  final String? hintText, labelText;
  final suffixIcon;
  final VoidCallback? onTap;
  final int? maxLength;
  final bool obscureText;
  final Function? validator, onChanged;
  final TextInputType? keyboardType;
  final Function(String?)? onSave;
  final int? maxLines;
  final TextEditingController? controller;
  final bool readOnly;

  //final int maxLines;

  const MyTextFieldPass({
    Key? key,
    this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.onSave,
    this.onTap,
    this.controller,
    this.readOnly = false,
    this.maxLength,
    this.onChanged,
    this.labelText, this.maxLines,
    // this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(),
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        onTap: onTap,
        //onChanged: onChanged,
        obscureText: obscureText,
        validator: validator as String? Function(String? value)?,
        //validator: validator,
        onSaved: onSave,
        obscuringCharacter: '*',
        //maxLines: maxLines,
        style: Theme.of(context).textTheme.bodyText2,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          errorStyle: TextStyle(color: Colors.redAccent,fontSize: 13),
          labelStyle: TextStyle(color: MyColors.colorText_label),
          //contentPadding: EdgeInsets.all(0),
          hintStyle: TextStyle(color: MyColors.colorTexthittext),
          contentPadding:
          new EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
          border: new OutlineInputBorder(
            //borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
          // border: InputBorder.none,
          suffixIcon: Icon(suffixIcon),
        ),
        //maxLines: maxLines,
        maxLength: maxLength,
      ),
    );
  }
}

/*class mytextfield_maxline extends StatelessWidget {
  final String hintText;
  final suffixIcon;
  final Function onTap;
  final int maxLength;
  final bool obscureText;
  final Function validator;
  final TextInputType keyboardType;
  final Function onSave;
  final TextEditingController controller;
  final bool readOnly;
  final int maxLines;

  const mytextfield_maxline({
    Key key,
    this.hintText,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.onSave,
    this.onTap,
    this.controller,
    this.readOnly = false,
    this.maxLength,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(),
      child: TextFormField(
        readOnly: readOnly,
        controller: controller,
        onTap: onTap,
        obscureText: obscureText,
        validator: validator,
        onSaved: onSave,
        style: Theme.of(context).textTheme.bodyText2,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: hintText,
          //hintText: hintText,
          errorStyle: Theme.of(context).textTheme.display3.apply(
                color: Colors.redAccent,
              ),
          labelStyle:
              Theme.of(context).textTheme.body1.apply(color: Colors.black45),
          //contentPadding: EdgeInsets.all(0),
          contentPadding:
              new EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
          border: new OutlineInputBorder(
            //borderRadius: new BorderRadius.circular(25.0),
            borderSide: new BorderSide(),
          ),
          // border: InputBorder.none,
          suffixIcon: Icon(suffixIcon),
        ),
        maxLines: maxLines,
        maxLength: maxLength,
      ),
    );
  }
}*/
