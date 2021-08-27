import 'package:flutter/material.dart';

import 'mycolors.dart';

class mytextfield extends StatelessWidget {
  final String? hintText, labelText;
  final suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final int? maxLength;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final Function(String?)? onChanged;
  final TextInputType? keyboardType;
  final Function? onSave;
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
    //this.onChanged,
    this.labelText,
    this.maxLines, this.prefixIcon, this.onChanged,
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
        onChanged: onChanged,
        obscureText: obscureText,
        validator: validator,
        //onSaved: onSave,
        //obscuringCharacter: '*',
        //maxLines: maxLines,
        style: Theme.of(context).textTheme.bodyText2,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          errorStyle: TextStyle(color: Colors.redAccent,fontSize: 13),
          labelStyle: TextStyle(color: MyColors.colorTexthittext),
          //contentPadding: EdgeInsets.all(0),
          hintStyle: TextStyle(color: MyColors.colorTexthittext),
          filled: true,
          fillColor: MyColors.colorText_bule,
          contentPadding:
              new EdgeInsets.symmetric(vertical: 9.0, horizontal: 16.0),
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: BorderSide.none,
          ),
          // border: InputBorder.none,
          suffixIcon: Icon(suffixIcon),
          prefixIcon: prefixIcon,
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
