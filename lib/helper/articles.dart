import 'dart:convert';
import 'package:pocket_news/model/articleModel.dart';
import 'package:http/http.dart' as http;

class Articles {
  List<ArticleModel> articles = [];

  Future<void> getArticles() async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=in&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=1f479fb1cecf4d20b3289e8f40036010";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel article = ArticleModel(
            title: element['title'],
            description: element['description'],
            author: element['author'],
            content: element['content'],
            urlImage: element['urlToImage'],
            url: element['url'],
          );

          articles.add(article);
        }
      });
    }
  }
}

class CategoryArticles {
  List<ArticleModel> articles = [];

  Future<void> getArticles(String category) async {
    String url =
        "http://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=1f479fb1cecf4d20b3289e8f40036010";

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel article = ArticleModel(
            title: element['title'],
            description: element['description'],
            author: element['author'],
            content: element['content'],
            urlImage: element['urlToImage'],
            url: element['url'],
          );

          articles.add(article);
        }
      });
    }
  }
}
