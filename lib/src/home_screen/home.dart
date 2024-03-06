import 'package:flutter/material.dart';
import 'package:news_app/src/home_screen/main_page.dart';

import '../setting_screen/setting_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  ValueNotifier<int> bottomNavigatorSelectionNotifier = ValueNotifier(0);

  Widget mainPage = const MainPage();
  Widget settingsPage = SettingsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: bottomNavigatorSelectionNotifier,
          builder: (BuildContext context, int selectedIndex, Widget? child) {
            return BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (int index) {
                bottomNavigatorSelectionNotifier.value = index;
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark),
                  label: 'BookMark',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            );
          }),
      body: ValueListenableBuilder<int>(
          valueListenable: bottomNavigatorSelectionNotifier,
          builder: (BuildContext context, int selectedIndex, Widget? child) {
            switch (selectedIndex) {
              case 0:
                return mainPage;
              case 1:
                return const SizedBox();
              case 2:
                return const SizedBox();
              case 3:
                return settingsPage;
              default:
                return const SizedBox();
            }
          }),
    );
  }
}
