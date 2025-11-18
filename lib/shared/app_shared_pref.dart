import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref{

    static const localKey='app_local';
    static const themeKey='app_theme';

    static Future<void> SetAppLocal(String local) async{

        final  sharedPrefs =await SharedPreferences.getInstance();
        sharedPrefs.setString(localKey,local);

    }

    static Future<String>getAppLocal() async{
        final  sharedPrefs =await SharedPreferences.getInstance();
        return sharedPrefs.getString(localKey)??'en';

    }

    static Future<void> SetAppTheme(String theme) async{

        final  sharedPrefs =await SharedPreferences.getInstance();
        sharedPrefs.setString(themeKey,theme);

    }

    static Future<ThemeMode>getAppTheme() async{
        final  sharedPrefs =await SharedPreferences.getInstance();
        return sharedPrefs.getString(themeKey)=="light"?ThemeMode.light:ThemeMode.dark;

    }






}