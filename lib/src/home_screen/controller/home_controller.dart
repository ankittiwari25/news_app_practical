import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/src/home_screen/model/news_model.dart';
import 'package:news_app/src/home_screen/service/news_service.dart';
import 'package:news_app/utils/service_locator.dart';

class NewsController extends GetxController {
  var isLoading = false.obs;
  NewsModel? newsModel;
  late final NewsService newService;

  List<String> tabs = ["All News", "Politics", "Tech", "Science", "Cricket", "Economics"];

  List<String> images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
    "https://wallpaperaccess.com/full/2637581.jpg",
    "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
  ];

  var selectedIndex = 0.obs;

  final PageController appSwiperController = PageController(viewportFraction: 0.8);

  AnimationController? translateSidewaysController;

  @override
  Future<void> onInit() async {
    super.onInit();
    newService = getIt.get<NewsService>();
    getNewsData();
  }

  /// fetching news data
  void getNewsData() async {
    isLoading(true);
    final data = await newService.getNews();
    data.fold((l) {
      newsModel = NewsModel.fromJson(l);
      isLoading(false);
    }, (r) {
      isLoading(false);
    });
  }

  void updateIndex(int newIndex) {
    selectedIndex(newIndex);
  }

  void setAsFavourite(int newIndex) {
    newsModel!.articles![newIndex].isFavourite.value =
        !(newsModel!.articles![newIndex].isFavourite.value ?? false);
  }

  void setAsFavouriteByItem(Articles item) {
    item.isFavourite.value = !item.isFavourite.value;
  }
}
