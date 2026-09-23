import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'screens/auth/login_screen.dart';

class TravelMateApp extends StatelessWidget {
  const TravelMateApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: '여행메이트',
    theme: AppTheme.light,
    home: const LoginScreen(),
  );
}
