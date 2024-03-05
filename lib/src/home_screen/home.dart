import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/src/home_screen/controller/home_controller.dart';
import 'package:news_app/src/setting_screen/setting_controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  ValueNotifier<int> bottomNavigatorSelectionNotifier = ValueNotifier(0);
  late final tabController = TabController(length: 6, vsync: this);

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
      body: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TabBar(
              isScrollable: true,
              indicatorWeight: 8.0,
              indicatorSize: TabBarIndicatorSize.label,
              controller: tabController,
              padding: EdgeInsets.zero,
              tabs: [
                ...newsController.tabs.map((e) => Text(
                      e.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
          ),
          Obx(() => newsController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Text('${newsController.newsModel!.articles!.length}'),
                )),
        ],
      ),
    );
  }
}
