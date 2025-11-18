import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video01_portfolio_website/shared/app_shared_pref.dart';

class AppLocalController extends AsyncNotifier<String>{
  @override
  FutureOr<String> build() {

    return AppSharedPref.getAppLocal();
  }

  void changeLocal(String newLocal) async{
    await AppSharedPref.SetAppLocal(newLocal);
    update((state)=>newLocal);
  }


}