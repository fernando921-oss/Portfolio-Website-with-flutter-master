

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video01_portfolio_website/shared/app_shared_pref.dart';

class AppThemeController extends AsyncNotifier<ThemeMode>{
  @override
  FutureOr<ThemeMode> build() {
    return AppSharedPref.getAppTheme();
  }

  void changeTheme(ThemeMode newTheme) async{
    await AppSharedPref.SetAppTheme(newTheme==ThemeMode.dark?"dark":"light");
    update((state)=>newTheme);
  }




}