import 'package:flutter/material.dart';
import 'package:video01_portfolio_website/extensions.dart';

import '../../../styles/app_colors.dart';
import '../../../widgets/appbar/seo_text.dart';
import 'home_course_list.dart';


class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const PrimaryButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.gray[100],
        ), // TextStyle
      ), // Text // ElevatedButton
    );
  }
}

class OutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const OutlineButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: SEOText(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: context.colorscheme.onBackground,
        ), // TextStyle
      ), // SEOText // OutlinedButton
    );
  }
}