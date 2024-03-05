import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  RxBool isDarkMode = false.obs;

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
}
