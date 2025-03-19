import 'package:dio/dio.dart';
import 'package:news_letter_app/Features/news/data/models/news.dart';
import 'package:news_letter_app/core/networking/api_constants.dart';

abstract class NewsRemoteDatasource {
  Future<List<NewsArticle>> getAllNews(String interest);
}

class NewsRemoteImplWithDio implements NewsRemoteDatasource {
  final Dio dio = Dio();

  @override
  Future<List<NewsArticle>> getAllNews(String interest) async {
    String baseUrl;

    switch (interest) {
      case "Apple":
        baseUrl = ApiConstants.baseUrlForApple;
        break;
      case "Business":
        baseUrl = ApiConstants.baseUrlForBusiness;
        break;
      case "Tesla":
        baseUrl = ApiConstants.baseUrlForTesla;
        break;
      default:
        baseUrl = ApiConstants.baseUrlForWallStreetJournal;
    }

    try {
      final response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        return parseNewsArticles(response.data);
      } else {
        throw Exception("Failed to load news");
      }
    } catch (e) {
      throw Exception("Error fetching news: $e");
    }
  }
}