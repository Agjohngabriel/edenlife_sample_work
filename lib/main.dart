import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:one_context/one_context.dart';

import 'app/locator.dart';
import 'helpers/constants/app_theme.dart';
import 'helpers/constants/colors.dart';

void main() {
  runApp(TrackingApp());
}

class TrackingApp extends StatelessWidget {
  TrackingApp({super.key});
  final _router = locator<GoRouter>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Eden Life Tracker",
      routerConfig: _router,
      theme: AppThemes.main(primaryColor: AppColors.primaryColorOptions[0]),
      debugShowCheckedModeBanner: false,
      builder: OneContext().builder,
    );
  }
}
