import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video01_portfolio_website/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:video01_portfolio_website/app_theme_controllar.dart';
import 'package:video01_portfolio_website/constants/app_menu_list.dart';
import 'package:video01_portfolio_website/extensions.dart';
import 'package:video01_portfolio_website/providers.dart';
import 'package:video01_portfolio_website/styles/app_size.dart';
import 'package:video01_portfolio_website/widgets/appbar/app_bar_drawar_icon.dart';
import 'package:video01_portfolio_website/widgets/appbar/drawer_menue.dart';

import '../../l10n/app_localizations.dart';
import 'language_switch.dart';
//
// class MyAppBar extends StatelessWidget {
//   const MyAppBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Container(
//         //color: Theme.of(context).appBarTheme.backgroundColor,
//         color: Colors.red,
//         padding:EdgeInsets.symmetric(horizontal: context.Insets.Padding) ,
//         height: context.Insets.AppbarHeight,
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             maxWidth: Insets.maxwidth,
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               AppLogo(),
//               Spacer(),
//               AppMenue(),
//               Spacer(),
//               LanguageToggle(),
//               ThemeToggle(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class MyAppBar extends StatefulWidget {
  final ValueNotifier<bool> drawerNotifier;
 
  MyAppBar({super.key, required this.drawerNotifier});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  //final ValueNotifier<bool> drawerNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
     return Container(
     padding: EdgeInsets.symmetric(horizontal: context.Insets.Padding),
     height: context.Insets.AppbarHeight,
     child: LayoutBuilder(
       builder: (context, constraints) {
         if (constraints.maxWidth < 600) {
           return AnimatedContainer(
             duration: const Duration(milliseconds: 200),
             curve: Curves.easeInOut,
             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
             child: Row(
               children: [
                 const AppLogo(),
                 const Spacer(),
                 Row(
                   children: [
                     const LanguageSwitch(),
                     const SizedBox(width: 16.0),
                     const ThemeToggle(),
                     const SizedBox(width: 16.0),
                     AppBarDrawarIcon(drawerNotifier: widget.drawerNotifier),
                   ],
                 ),
               ],
             ),
           );
         } else {
           return AnimatedContainer(
             duration: const Duration(milliseconds: 300),
             curve: Curves.easeInOut,
             child: SizedBox(
               height: 60,
               width: Insets.maxwidth,
               child: Row(
                 children: const [
                   AppLogo(),
                   Spacer(),
                   LargeMenue(),
                   Spacer(),
                   LanguageSwitch(),
                   ThemeToggle(),
                 ],
               ),
             ),
           );
         }
       },
     ),
     );

    // Scaffold(
    //   drawer: AppDrawerMenu(),
    //   // 👇 This triggers when the drawer opens or closes
    //   onDrawerChanged: (isOpen) {
    //     drawerNotifier.value = isOpen;
    //   },
    //   body: Container(
    //     //color: Colors.transparent,
    //     padding: EdgeInsets.symmetric(horizontal: context.Insets.Padding),
    //     height: context.Insets.AppbarHeight,
    //     child: LayoutBuilder(
    //       builder: (context, constraints) {
    //         // If screen < 600px, show a hamburger menu instead
    //         if (constraints.maxWidth<600) {
    //           return AnimatedContainer(
    //             duration: const Duration(milliseconds: 200),
    //             curve: Curves.easeInOut,
    //             //color: Colors.transparent, // background color
    //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    //             child: Row(
    //               children: [
    //                 const AppLogo(),
    //                 const Spacer(),
    //                 Row(
    //                   children: [
    //                     const LanguageSwitch(),
    //                     const SizedBox(width: 16.0),
    //                     const ThemeToggle(),
    //                     const SizedBox(width: 16.0),
    //                     AppBarDrawarIcon(drawerNotifier: drawerNotifier),// 👈 mobile-friendly
    //                   ],
    //
    //                 ),
    //
    //               ],
    //             ),
    //           );
    //         } else {
    //           return AnimatedContainer(
    //             duration: const Duration(milliseconds: 300),
    //             curve: Curves.easeInOut,
    //             //color: Colors.transparent,
    //             child: SizedBox(
    //               height: 60,
    //               width: Insets.maxwidth,
    //               child: Row(
    //                 children: const [
    //                   AppLogo(),
    //                   Spacer(),
    //                   LargeMenue(),
    //                   Spacer(),
    //                   LanguageSwitch(),
    //                   ThemeToggle(),
    //                 ],
    //               ),
    //             ),
    //           );
    //         }
    //       },
    //     ),
    //   ),
    // );
  }
}


class AppLogo extends StatelessWidget {
  const AppLogo({super.key});



  @override
  Widget build(BuildContext context) {
    // final width=MediaQuery.of(context).size.width;
    // print(width);
    return Text(
      "Teacher's guide",
       style: context.textStyle.titleSmBold.copyWith(fontFamily: 'NotoSansSinhala'));
  }
}
class LargeMenue extends StatelessWidget {
  const LargeMenue({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Row(
        children:AppMenuList.getiteam(context).map((e)=>LargeAppBarMenuItem(text:e.title , isSelected: true, OnTap: (){})).toList(),
      ),
    );
  }
}

class LargeAppBarMenuItem extends StatelessWidget {
  const LargeAppBarMenuItem({super.key, required this.text, required this.isSelected, required this.OnTap});

  final String text;
  final bool isSelected;
  final VoidCallback OnTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: OnTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
        child: Text(text, style: SmallTextStyles().bodyLgMedium,),
      ),
    );
  }
}


class ThemeToggle extends ConsumerWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final state=ref.watch(appThemeControllerProvider);
    return Switch(value: state.value==ThemeMode.dark, onChanged: (value){
      ref.read(appThemeControllerProvider.notifier).changeTheme(value?ThemeMode.dark:ThemeMode.light);
    });

  }
}





