import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/src/home_screen/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController newsController = Get.put(NewsController());
    return Scaffold(
      appBar: AppBar(title: const Text('OXU.az')),
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
