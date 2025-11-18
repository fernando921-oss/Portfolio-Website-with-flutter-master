import 'package:flutter/cupertino.dart';

class Insets{
  static const double maxwidth=1180;
  static double get xxxl=>80;
  static double get xs=>4;
  static double get md=>12;
  static double get xl=>24;
}

abstract class AppInsets {
  double get Padding;
  double get AppbarHeight;
}

class LargeInsets extends AppInsets{
  @override
  // TODO: implement Padding
  double get Padding => 80;
  double get AppbarHeight=>64;

}

class SmallInsets extends AppInsets{
  @override
  // TODO: implement Padding
  double get Padding => 60;
  double get AppbarHeight=>56;


}