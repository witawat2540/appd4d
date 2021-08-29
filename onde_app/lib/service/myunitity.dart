import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Unitity {
  static bool isLoading = false;
  static var f = NumberFormat('#,###');
  static int? indexMenu;

  static MaterialPageRoute<dynamic> materialPageRoute(Widget _page) {
    return MaterialPageRoute(
      builder: (context) => _page,
    );
  }
}
