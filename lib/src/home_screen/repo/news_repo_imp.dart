import 'package:dartz/dartz.dart';
import 'package:news_app/network/api_url.dart';
import 'package:news_app/network/network.dart';
import 'package:news_app/src/home_screen/repo/news_repo.dart';
import 'package:news_app/utils/type_def.dart';

import '../../../utils/service_locator.dart';

class NewsRepoImp extends NewsRepo {
  NewsRepoImp() {
    _apiClient = getIt.get<ApiClient>();
  }

  late final ApiClient _apiClient;

  @override
  ReturnDataFromApi getNews() async {
    try {
      final response = await _apiClient.get(endPoint: ApiUrl.getNews);
      return Left(response);
    } catch (e) {
      return const Right("Something went wrong");
    }
  }
}
