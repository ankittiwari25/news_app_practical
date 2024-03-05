import 'package:get_it/get_it.dart';
import 'package:news_app/network/api_url.dart';

import '../network/network.dart';
import '../src/home_screen/service/news_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<ApiClient>(ApiClient(ApiUrl.baseUrl));
  getIt.registerSingleton<NewsService>(NewsService());
}
