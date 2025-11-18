import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:video01_portfolio_website/features/home/presentation/styled_button.dart';

class LargeHeroButtons extends StatelessWidget {
  const LargeHeroButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PrimaryButton(title: "Courses"),
        SizedBox(width: 16.0),
        OutlineButton(title: "HI"),
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
          child: PrimaryButton(title: "Subjects"),
        ), // SizedBox
        SizedBox(width: 16.0),
        SizedBox(
          width: double.infinity,
          child: OutlineButton(title: "hi"),
        ), // SizedBox
      ],
    ); // Column
  }
}