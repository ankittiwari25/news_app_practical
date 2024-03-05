import 'package:news_app/utils/type_def.dart';

abstract class NewsRepo {
  ReturnDataFromApi getNews();
}
