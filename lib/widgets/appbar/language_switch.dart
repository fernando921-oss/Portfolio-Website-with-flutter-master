import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:video01_portfolio_website/app_local_controller.dart';
import 'package:video01_portfolio_website/extensions.dart';
import 'package:video01_portfolio_website/providers.dart';
import 'package:video01_portfolio_website/widgets/appbar/seo_text.dart';

import '../../constants/app_icon.dart';

class LanguageSwitch extends ConsumerWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final local=ref.watch(appLocalProvider);
    return PopupMenuButton(itemBuilder: (context){
      return [
        PopupMenuItem(
          value: 0,
            child: PopUpLanguageSwitch(
                language: "English",
                icon: AppIcon.us
            )),
        PopupMenuItem(
          value: 1,
            child: PopUpLanguageSwitch(
                language: "Sinhala",
                icon: AppIcon.lk)),

      ];
    },
      initialValue: local.value=='en'?0:1,
      onSelected: (value){
      if(value==0){
        ref.read(appLocalProvider.notifier).changeLocal('en');

      }else{
        ref.read(appLocalProvider.notifier).changeLocal('si');


      }

      },
      child: Row(
        children: [
          Icon(Icons.language,
            //color: context.colorscheme.onBackground,
          ),
          const Gap(4),
          SEOText(local.value=='en'?'En':'Si')

        ],
      ),
    );
  }
}

class PopUpLanguageSwitch extends StatelessWidget {
  final String language;
  final String icon;
  const PopUpLanguageSwitch({super.key, required this.language, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: SvgPicture.asset(
            icon,
          width :18,
          height:18,
            fit: BoxFit.cover,
          ),
        ),
        const Gap(8),
        SEOText(language),
      ],
    );
  }
}
