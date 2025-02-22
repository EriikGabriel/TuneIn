import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:projeto_final/pages/home_page.dart';
import 'package:projeto_final/pages/library_page.dart';
import 'package:projeto_final/pages/search_page.dart';
import 'package:projeto_final/theme/app_theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [HomePage(), SearchPage(), LibraryPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 15),
        child: BottomNavigationBar(
          backgroundColor: Theme.of(
            context,
          ).colorScheme.primaryBackground.withValues(alpha: 0.4),
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (int index) => setState(() => _currentIndex = index),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: translate("home")),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: translate("search")),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              label: translate("library"),
            ),
          ],
        ),
      ),
    );
  }
}
