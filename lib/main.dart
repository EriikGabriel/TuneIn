import 'package:flutter/material.dart';
import 'package:projeto_final/pages/login_page.dart';
import 'package:projeto_final/pages/main_page.dart';
import 'package:projeto_final/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (ctx) => const LoginPage(),
        '/main': (ctx) => const MainPage(),
      },
      theme: appThemeData,
    );
  }
}
