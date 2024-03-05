import 'package:get/get.dart';
import 'package:news_app/src/home_screen/model/news_model.dart';
import 'package:news_app/src/home_screen/service/news_service.dart';
import 'package:news_app/utils/service_locator.dart';

class NewsController extends GetxController {
  var isLoading = false.obs;
  NewsModel? newsModel;
  late final NewsService newService;

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
}
