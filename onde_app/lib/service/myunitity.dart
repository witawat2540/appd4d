import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Unitity {
  static bool isLoading = false;
  static var f = NumberFormat('#,###');
  static int? indexMenu;
  static bool statusEdit = true;

  static MaterialPageRoute<dynamic> materialPageRoute(Widget _page) {
    return MaterialPageRoute(
      builder: (context) => _page,
    );
  }

  static Future<DateTime?> selectDate(BuildContext context,DateTime date) async {
    //print(date);
    DateTime? _select = await showDatePicker(
      context: context,
      firstDate: DateTime(1990),
      initialDate: DateTime.now(),
      currentDate: date,
      lastDate: DateTime.now(),
    );
    return _select;
  }
}
