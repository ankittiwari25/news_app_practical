import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:news_app/src/home_screen/controller/home_controller.dart';
import 'package:news_app/src/home_screen/model/news_model.dart';
import 'package:news_app/src/setting_screen/setting_controller.dart';
import 'package:news_app/utils/app_color.dart';

import '../news_detail_screen/news_detail_screen.dart';

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
    SettingController themeController = Get.put(SettingController());

    return Scaffold(
      // backgroundColor: AppColor.light_gray,
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(height: 4),
          SizedBox(
            height: 200,
            child: PageView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: newsController.images.length,
              onPageChanged: (int pageIndex) {
                newsController.updateIndex(pageIndex);
              },
              itemBuilder: (context, pagePosition) {
                return Obx(() {
                  return Container(
                    height: 180,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        height: (newsController.selectedIndex.value != pagePosition) ? 150 : 180,
                        fit: BoxFit.fitHeight,
                        newsController.images[pagePosition],
                      ),
                    ),
                  );
                });
              },
              controller: newsController.appSwiperController,
            ),
          ),
          Container(
            height: 40,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buildPageIndicator(newsController.selectedIndex.value, newsController.images),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 24.0),
            child: Text(
              'Latest news',
              style: TextStyle(fontSize: 22),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Obx(() => newsController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      Articles artical = newsController.newsModel!.articles![index];
                      print("DATE -- ${DateTime.parse(artical.publishedAt!)}");
                      return GestureDetector(
                        onTap: () {
                          Get.to(NewsDetailScreen(artical: artical));
                        },
                        child: Container(
                          // color: AppColor.gray_1,
                          height: 130,
                          margin: const EdgeInsets.only(left: 24),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 110,
                                  decoration: const BoxDecoration(
                                    color: AppColor.light_gray,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                                  ),
                                  margin: const EdgeInsets.only(left: 20),
                                  padding: const EdgeInsets.only(left: 100, right: 10, top: 10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        artical.title ?? '',
                                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Text(
                                            Jiffy.parseFromDateTime(DateTime.parse(artical.publishedAt!))
                                                .fromNow(),
                                            // a few seconds ago,
                                            style: const TextStyle(fontSize: 10),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              newsController.setAsFavourite(index);
                                            },
                                            child: Obx(() {
                                              return Icon(
                                                artical.isFavourite.value
                                                    ? Icons.bookmark
                                                    : Icons.bookmark_border,
                                                color: AppColor.dark_orange,
                                                size: 20,
                                              );
                                            }),
                                          ),
                                          const SizedBox(width: 20)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    artical.urlToImage ?? '',
                                    height: 110,
                                    width: 110,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: newsController.newsModel?.articles?.length ?? 0,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 10);
                    },
                  )),
          ),
        ],
      ),
    );
  }

  List<Widget> buildPageIndicator(int currentPage, List<String> images) {
    List<Widget> list = [];
    for (int i = 0; i < images.length; i++) {
      list.add(i == currentPage
          ? indicator(true, i, currentPage, images.length - 1)
          : indicator(false, i, currentPage, images.length - 1));
    }
    return list;
  }

  Widget indicator(bool isActive, int i, int currentPage, int totalPages) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: getIndicatorSize(isActive, i, currentPage, totalPages),
      width: getIndicatorSize(isActive, i, currentPage, totalPages),
      decoration: BoxDecoration(
        color: getColor(isActive, i),
        border: Border.all(color: AppColor.dark_orange),
        shape: BoxShape.circle,
      ),
    );
  }

  Color getColor(bool isActive, int i) {
    if (isActive) {
      return /*Get.theme == ThemeMode.dark ? Colors.white :*/ Colors.transparent;
    } else {
      return AppColor.dark_orange;
    }
  }

  double getIndicatorSize(bool isActive, int i, int currentPage, int totalPages) {
    if (isActive) {
      return 8.0;
    } else if ((i == 0 || i == totalPages) && !isActive) {
      return 6.0;
    }
    return 6.0;
  }
}
