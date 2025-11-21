import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:video01_portfolio_website/extensions.dart';
import 'package:video01_portfolio_website/features/home/presentation/home_page.dart';
import 'package:video01_portfolio_website/features/home/presentation/styled_button.dart';

class LargeHeroButtons extends StatelessWidget {
  const LargeHeroButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PrimaryButton(title: context.texts.courses,
        onPressed: (){
          final home = context.findAncestorStateOfType<HomePageState>();
          home?.scrollToCourses();
        },


        ),
        SizedBox(width: 16.0),
        OutlineButton(title: context.texts.contact),
      ],
    );
  }
}

class SmallHeroButtons extends StatelessWidget {
  const SmallHeroButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: PrimaryButton(title: context.texts.courses,
            onPressed: (){
              final home = context.findAncestorStateOfType<HomePageState>();
              home?.scrollToCourses();
            },
          ),
        ), // SizedBox
        SizedBox(width: 16.0),
        SizedBox(
          width: double.infinity,
          child: OutlineButton(title: context.texts.contact),
        ), // SizedBox
      ],
    ); // Column
  }
}