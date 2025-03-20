import 'dart:math';
import 'package:dio/dio.dart';
import 'package:news_letter_app/Features/news/data/models/news.dart';
import 'package:news_letter_app/core/networking/api_constants.dart';

abstract class NewsRemoteDatasource {
  Future<List<NewsArticle>> getAllNews(List<String> interests);
}

class NewsRemoteImplWithDio implements NewsRemoteDatasource {
  final Dio dio = Dio();
  final Random _random = Random();

  String _getBaseUrl(String interest) {
    switch (interest) {
      case "Apple":
        return ApiConstants.baseUrlForApple;
      case "Business":
        return ApiConstants.baseUrlForBusiness;
      default:
        return ApiConstants.baseUrlForWallStreetJournal;
    }
  }

  @override
  Future<List<NewsArticle>> getAllNews(List<String> interests) async {
    if (interests.isEmpty) {
      return [];
    }

    try {
      final List<Future<List<NewsArticle>>> fetchTasks = interests.map((interest) async {
        final String baseUrl = _getBaseUrl(interest);
        final response = await dio.get(baseUrl);
        if (response.statusCode == 200) {
          return parseNewsArticles(response.data);
        } else {
          throw Exception("Failed to load news for $interest");
        }
      }).toList();

      final List<List<NewsArticle>> allResults = await Future.wait(fetchTasks);


      List<NewsArticle> mixedNews = allResults.expand((newsList) => newsList).toList();


      mixedNews.shuffle(_random);

      return mixedNews;
    } catch (e) {
      throw Exception("Error fetching news: $e");
    }
  }
}
