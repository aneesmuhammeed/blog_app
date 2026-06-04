import 'package:flutter/material.dart';
import 'package:newflu/core/theme/theme.dart';
import 'package:newflu/feature/auth/presentation/pages/login_page.dart';
import 'package:newflu/feature/auth/presentation/pages/sigup_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
