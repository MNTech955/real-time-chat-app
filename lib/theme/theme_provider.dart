

import 'package:chat_app/theme/dark_mode.dart';
import 'package:chat_app/theme/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData=lightMode;
  ThemeData get themeData=>_themeData;
  bool get isDarkMode =>_themeData==darkMode;
//Updates _themeData with the new theme (lightMode or darkMode).
//Calls notifyListeners() to inform the app about the change so that widgets can rebuild with the updated theme
  set themeData(ThemeData themeData){
    _themeData=themeData;
    notifyListeners();
  }
  void toggleTheme(){
    if(_themeData==lightMode){
      themeData=darkMode; //call the  setter,_themeData is updated with the new value (darkMode).
    }else{
      themeData=lightMode;
    }
  }
}

