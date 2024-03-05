import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/src/home_screen/controller/home_controller.dart';
import 'package:news_app/src/setting_screen/setting_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController newsController = Get.put(NewsController());
    final themeController = Get.put(SettingController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('OXU.az'),
        actions: [
          Obx(
            () => IconButton(
                onPressed: () {},
                icon: Switch(
                    value: themeController.isDarkMode.value,
                    onChanged: (value) {
                      themeController.toggleTheme(value);
                    })),
          )
        ],
      ),
      body: Obx(() => newsController.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Text('${newsController.newsModel!.articles!.length}'),
            )),
    );
  }
}
