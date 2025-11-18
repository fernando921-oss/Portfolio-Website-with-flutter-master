import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video01_portfolio_website/app_local_controller.dart';

import 'app_theme_controllar.dart';

final appLocalProvider=AsyncNotifierProvider<AppLocalController,String>(AppLocalController.new);
final appThemeControllerProvider =
AsyncNotifierProvider<AppThemeController, ThemeMode>(AppThemeController.new);
