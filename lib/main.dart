import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/src/home_screen/home.dart';
import 'package:news_app/utils/app_color.dart';

import 'utils/service_locator.dart';

void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News App',
      theme: ThemeData.light().copyWith(
        // scaffoldBackgroundColor: AppColor.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 2,
          selectedItemColor: AppColor.dark_orange,
          unselectedItemColor: AppColor.black,
          backgroundColor: AppColor.gray_1,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: AppColor.black,
          unselectedLabelColor: AppColor.gray_1,
          indicatorColor: AppColor.dark_orange,
          dividerColor: Colors.transparent,
          tabAlignment: TabAlignment.start,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 4.0, color: AppColor.dark_orange),
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        // scaffoldBackgroundColor: AppColor.gray_1,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          elevation: 2,
          selectedItemColor: AppColor.dark_orange,
          unselectedItemColor: AppColor.white,
          backgroundColor: AppColor.gray_1,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: AppColor.white,
          unselectedLabelColor: AppColor.gray_1,
          indicatorColor: AppColor.dark_orange,
          dividerColor: Colors.transparent,
          tabAlignment: TabAlignment.start,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 4.0, color: AppColor.dark_orange),
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      home: HomeScreen(),
    );
  }
}
