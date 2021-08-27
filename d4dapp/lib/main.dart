import 'package:d4dapp/page/firstpage.dart';
import 'package:d4dapp/page/homepage.dart';
import 'package:d4dapp/service/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

Map<int, Color> color = {
  50: Color.fromRGBO(66, 29, 134, .1),
  100: Color.fromRGBO(66, 29, 134, .2),
  200: Color.fromRGBO(66, 29, 134, .3),
  300: Color.fromRGBO(66, 29, 134, .4),
  400: Color.fromRGBO(66, 29, 134, .5),
  500: Color.fromRGBO(66, 29, 134, .6),
  600: Color.fromRGBO(66, 29, 134, .7),
  700: Color.fromRGBO(66, 29, 134, .8),
  800: Color.fromRGBO(66, 29, 134, .9),
  900: Color.fromRGBO(66, 29, 134, 1),
};

class MyApp extends StatelessWidget {
  MaterialColor colorCustom = MaterialColor(0xFF421D86, color);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp(
        title: 'ศูนย์รวมแอพพลิเคชั่นของผู้พิการ',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), // English, no country code
          const Locale('th', ''), // Spanish, no country code
        ],
        locale: const Locale('th'),
        theme: ThemeData(
          primarySwatch: colorCustom,
          popupMenuTheme: PopupMenuThemeData(
            textStyle: GoogleFonts.prompt(fontSize: 16,color: Colors.black)
          ),

          iconTheme: IconThemeData(color: colorCustom),
          buttonTheme: ButtonThemeData(buttonColor: MyColors.colorApp),
          textTheme: TextTheme(
            //bodyText1: GoogleFonts.prompt(fontSize: 16),
            body1: GoogleFonts.prompt(
              fontSize: 16,
            ),
            button: GoogleFonts.prompt(
              fontSize: 18,
            ),
            caption:
                GoogleFonts.prompt(fontSize: 20, color: MyColors.colorText),
            subtitle:
            GoogleFonts.prompt(fontSize: 12, color: MyColors.colorText),
          ),
        ),
        home: FirstPage(),
      ),
    );
  }
}
