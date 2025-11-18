import 'package:flutter/cupertino.dart';
import 'package:video01_portfolio_website/extensions.dart';
import "package:video01_portfolio_website/routes/app_route.dart";

class AppMenuList{

  static List<AppMenu> getiteam(BuildContext context){


    return[
      AppMenu(title: context.texts.home, path: Routes.home),
      AppMenu(title: context.texts.courses, path: Routes.courses),
      AppMenu(title: context.texts.blog, path: Routes.blog),
      AppMenu(title: context.texts.aboutMe, path: Routes.aboutMe),



    ];

  }

}

class AppMenu {
  final String title;
  final String path;

  AppMenu({required this.title, required this.path});


}