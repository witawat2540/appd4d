import 'package:flutter/material.dart';
import 'package:onde_app/service/mycolors.dart';

class mydropdown extends StatelessWidget {
  final String label;
  final value;
  final bool line;
  final List<DropdownMenuItem<Object>>? listdata;
  final Function(dynamic)? onChanged;
  final String? Function(Object?)? validator;

  //final Function onChanged, validator;

  const mydropdown({
    Key? key,
    this.label = '',
    this.listdata,
    //this.onChanged,
    this.validator,
    this.value,
    this.line = false, this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: value,
      style: Theme.of(context).textTheme.bodyText2,
      isExpanded: true,
      //isDense: true,
      decoration: InputDecoration(
        labelText: '$label',
        //hintText: hintText,
        errorStyle: TextStyle(color: Colors.redAccent,fontSize: 13),
        labelStyle: Theme.of(context)
            .textTheme
            .body1!
            .apply(color: MyColors.colorText_label),
        contentPadding:
            new EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
        border: new OutlineInputBorder(
          //borderRadius: new BorderRadius.circular(25.0),
          borderSide: line ? BorderSide.none : BorderSide(),
        ),
      ),
      items: listdata,
      /*items: listdata
          .map(
            (item) => DropdownMenuItem(
              child: Text(item['provinceName']),
              value: item['provinceId'],
            ),
          )
          .toList(),*/
      onChanged: onChanged,
      validator: validator,
      /*validator: validator == null
          ? null
          : (value) {
              return validator(value);
            },*/
    );
  }
}
