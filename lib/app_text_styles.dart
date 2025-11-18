import 'package:flutter/material.dart';

abstract class AppTextStyles{

    TextStyle get titleSmBold;
    TextStyle get bodyMdMedium;
    TextStyle get titleLgBold;
    TextStyle get titleMdMedium;
    TextStyle get bodyLgBold;
    TextStyle get bodyLgMedium;
}


class SmallTextStyles extends AppTextStyles{

  TextStyle get bodyLgBold => const TextStyle(fontSize: 14,fontWeight: FontWeight.bold);


  TextStyle get bodyLgMedium => const TextStyle(fontSize:14,fontWeight: FontWeight.w500 );


  TextStyle get bodyMdMedium => const TextStyle(fontSize: 12,fontWeight: FontWeight.w500);


  TextStyle get titleLgBold => const TextStyle(fontSize: 24,fontWeight: FontWeight.bold);


  TextStyle get titleMdMedium => const TextStyle(fontSize: 14,fontWeight: FontWeight.w500);


  TextStyle get titleSmBold => const TextStyle(fontSize: 16,fontWeight: FontWeight.bold);


}

class LargeTextStyles extends AppTextStyles{

  TextStyle get bodyLgBold => const TextStyle(fontSize: 16,fontWeight: FontWeight.bold);


  TextStyle get bodyLgMedium => const TextStyle(fontSize: 16,fontWeight: FontWeight.w500);


  TextStyle get bodyMdMedium => const TextStyle(fontSize:14,fontWeight: FontWeight.w500 );


  TextStyle get titleLgBold => const TextStyle(fontSize: 24,fontWeight: FontWeight.bold);


  TextStyle get titleMdMedium => const TextStyle(fontSize: 24,fontWeight: FontWeight.bold);


  TextStyle get titleSmBold => const TextStyle(fontSize: 24,fontWeight: FontWeight.bold);

}
