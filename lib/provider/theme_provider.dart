import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

const Color greenClr = Color(0xff0F9D58);
const Color orangeClr = Color(0xffF4B400);
const Color bgClr = Color.fromRGBO(235, 248, 235, 1.0);
const primaryClr = greenClr;
const Color darkGreyClr = Color(0xFF1A1A1A);
const Color darkHeaderClr = Color(0xFF2C2C2C);
//const Color darkHeaderClr = Color(0xFF424242);

// Light & dark Theme
class Themes {
  // Light mode
  static final light = ThemeData.from(
    colorScheme: const ColorScheme.light(
      primary: primaryClr,
      secondary: orangeClr,
      background: bgClr,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
  );
  // Dark mode
  static final dark = ThemeData.from(
    colorScheme: const ColorScheme.dark(
      primary: darkGreyClr,
      secondary: orangeClr,
      background: darkHeaderClr,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}


class ThemeProvider with ChangeNotifier {

  ThemeMode tm = ThemeMode.system;
  String themeText = 'system';

  _getThemeText(ThemeMode tm){
    if(tm == ThemeMode.system){
      themeText = 'system';
    } else if(tm == ThemeMode.dark){
      themeText = 'dark';
    } else if (tm == ThemeMode.light) {
      themeText = 'light';
    }
    notifyListeners();
  }

  // on change
  void changeTheme(newTheme) async {
    tm = newTheme;
    _getThemeText(tm);
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('themeText', themeText);

  }

  getThemeMode () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    themeText = prefs.getString('themeText') ?? 'system';
    if(themeText == 'system'){
      tm = ThemeMode.system;
    } else if(themeText == 'light'){
      tm = ThemeMode.light;
    } else if (themeText == 'dark') {
      tm = ThemeMode.dark;
    }
    notifyListeners();
  }


  /// TextStyle Getter
  TextStyle get displayLarge {
    return GoogleFonts.cairo(
        textStyle: const TextStyle(
          fontSize: 30,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ));
  }

  // appbar title
  TextStyle get titleLarge {
    return GoogleFonts.cairo(
        textStyle: const TextStyle(
          fontSize: 24,
          //color: (tm == ThemeMode.dark)? Colors.white70: Colors.black87,
          fontWeight: FontWeight.bold,
        ));
  }
// drawer & title & filter
  TextStyle get titleMedium {
    return GoogleFonts.cairo(
        textStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: (tm == ThemeMode.dark)? Colors.white70: Colors.black87,
          //color: Colors.red
        ));
  }
// cat & header
  TextStyle get titleSmall {
    return  GoogleFonts.cairo(
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white.withOpacity(0.9),
        ));
  }
// subHeader
  TextStyle get subHeader {
    return  GoogleFonts.cairo(
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: (tm == ThemeMode.dark)? Colors.white70 : Colors.black87
        ));
  }
// body && subtitle
  TextStyle get bodySmall {
    return GoogleFonts.cairo(
        textStyle: TextStyle(
            fontSize: 15,
            //fontWeight: FontWeight.bold,
            color: (tm == ThemeMode.dark)? Colors.grey[300] : Colors.grey[800]
        ));
  }

  TextStyle get bodyMedium {
    return GoogleFonts.cairo(
        textStyle: const TextStyle(
          fontSize: 15,
          //fontWeight: FontWeight.bold,
          color: Colors.black
        ));
  }



} // End Theme Provider