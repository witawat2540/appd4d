import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onde_app/page/homepage.dart';
import 'package:onde_app/page/login.dart';
import 'package:onde_app/service/mycolors.dart';

void main() {
  runApp(MyApp());
}

Map<int, Color> color = {
  50: Color.fromRGBO(121, 86, 156, .1),
  100: Color.fromRGBO(121, 86, 156, .2),
  200: Color.fromRGBO(121, 86, 156, .3),
  300: Color.fromRGBO(121, 86, 156, .4),
  400: Color.fromRGBO(121, 86, 156, .5),
  500: Color.fromRGBO(121, 86, 156, .6),
  600: Color.fromRGBO(121, 86, 156, .7),
  700: Color.fromRGBO(121, 86, 156, .8),
  800: Color.fromRGBO(121, 86, 156, .9),
  900: Color.fromRGBO(121, 86, 156, 1),
};

class MyApp extends StatelessWidget {
  MaterialColor colorCustom = MaterialColor(0xFF79569C, color);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ONDE',
        theme: ThemeData(
          buttonColor: MyColors.colorText_bule,
          textTheme: TextTheme(
            body1: GoogleFonts.prompt(
              color: MyColors.colorText,
              fontSize: 16,
            ),
            button: GoogleFonts.prompt(
              color: Colors.white,
              fontSize: 14,
            ),
            subtitle: GoogleFonts.prompt(
              color: MyColors.colorText,
              fontSize: 14,
            ),
            title:GoogleFonts.prompt(
              color: MyColors.colorText,
              fontSize: 28,
            ),
            body2:  GoogleFonts.prompt(
              color: MyColors.colorText,
              fontSize: 18,
            ),
            caption: GoogleFonts.prompt(
              color: MyColors.colorText,
              fontSize: 20,
            ),
          ),
          primarySwatch: colorCustom,
        ),
        home: Login(),
      ),
    );
  }
}
