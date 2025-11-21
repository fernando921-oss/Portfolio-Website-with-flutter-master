import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seo_renderer/helpers/robot_detector_vm.dart';
import 'package:video01_portfolio_website/features/home/presentation/home_page.dart';
import 'package:video01_portfolio_website/providers.dart';
import 'package:video01_portfolio_website/styles/app_theem.dart';

import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(  ProviderScope(child: RobotDetector(
      debug: true,
      child: ProviderScope(
          child: MyApp()
      ))));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context,ref) {
    final local=ref.watch(appLocalProvider);
    final theme=ref.watch(appThemeControllerProvider);
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('si'), // Sinhala (example)
      ],
     locale: Locale(local.value??'en'),
     home: HomePage(),
      darkTheme: AppTheme(fontFamily: (local.value??'en')=='en'?'Poppins':'NotoSansSinhala').dark,
      theme: AppTheme(fontFamily: (local.value??'en')=='en'?'Poppins':'NotoSansSinhala').light,
      themeMode: theme.value,
    );
  }
}

