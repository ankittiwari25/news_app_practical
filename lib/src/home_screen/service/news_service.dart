import 'package:dartz/dartz.dart';
import 'package:news_app/src/home_screen/repo/news_repo_imp.dart';
import 'package:news_app/utils/type_def.dart';

class NewsService {
  NewsService() {
    newsRepoImp = NewsRepoImp();
  }

  late final NewsRepoImp newsRepoImp;

  ReturnDataFromApi getNews() async {
    try {
      return newsRepoImp.getNews();
    } catch (e) {
      return const Right("Something went wrong");
    }
  }
}
