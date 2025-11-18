import 'package:flutter/material.dart';
import 'package:video01_portfolio_website/app_text_styles.dart';
import 'package:video01_portfolio_website/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:video01_portfolio_website/styles/app_size.dart';

enum FormFactorType{
  mobile,
  tablet,
  desktop,
}

extension styledContext on BuildContext{

    MediaQueryData get mq=>MediaQuery.of(this);
    double get width=>mq.size.width;
    double get height=>mq.size.height;
    ThemeData get theme=>Theme.of(this);

    FormFactorType get formFactor{
          if(width<600) return FormFactorType.mobile;
          else switch (width) {
            case <900:
             return FormFactorType.tablet;
            default:
             return FormFactorType.desktop;
          }


    }

    bool get isMobile=>formFactor==FormFactorType.mobile;
    bool get isDesktop=>formFactor==FormFactorType.desktop;
    bool get isTablet=>formFactor==FormFactorType.tablet;
    bool get isDesktopOrTablet=>isTablet||isDesktop;



    AppTextStyles get textStyle{
        switch(formFactor){
          case FormFactorType.mobile:
          case FormFactorType.tablet:
            return SmallTextStyles();
          case FormFactorType.desktop:
            return LargeTextStyles();
        }

    }
    AppLocalizations get texts=>AppLocalizations.of(this)??lookupAppLocalizations(Locale("en"));

    AppInsets get Insets{
      switch(formFactor){
        case FormFactorType.mobile:
          return SmallInsets();
        case FormFactorType.tablet:
        case FormFactorType.desktop:
          return LargeInsets();
      }

    }

    ColorScheme get colorscheme=>theme.colorScheme;


}

