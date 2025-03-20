import 'package:dartz/dartz.dart';
import 'package:news_letter_app/Features/news/data/models/news.dart';
import 'package:news_letter_app/core/error/failures.dart';

abstract class NewsRepository
{
Future<Either<Failure,List<NewsArticle>>> gelAllNews(List<String> interests);

}