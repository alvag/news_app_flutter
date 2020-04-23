import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:news_app_flutter/src/constants/constants.dart' as Constants;
import 'package:news_app_flutter/src/models/category_model.dart';
import 'package:news_app_flutter/src/models/news_models.dart';

const _URL_NEWS = 'https://newsapi.org/v2';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  List<Article> get articlesBySelectedCategory =>
      this.categoryArticles[_selectedCategory];

  NewsService() {
    getTopHeadlines();

    categories.forEach((c) {
      this.categoryArticles[c.name] = new List();
    });
  }

  getTopHeadlines() async {
    final url =
        '$_URL_NEWS/top-headlines?country=mx&apiKey=${Constants.NEWS_API}';

    final res = await http.get(url);
    final newsResponse = newsResponseFromJson(res.body);

    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;
    getArticlesByCategory(_selectedCategory);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category].length > 0) {
      return categoryArticles[category];
    }

    final url =
        '$_URL_NEWS/top-headlines?country=mx&apiKey=${Constants.NEWS_API}&category=$category';

    final res = await http.get(url);
    final newsResponse = newsResponseFromJson(res.body);

    categoryArticles[category].addAll(newsResponse.articles);
    notifyListeners();
  }
}
