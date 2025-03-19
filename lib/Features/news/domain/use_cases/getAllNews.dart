import 'package:dartz/dartz.dart';
import 'package:news_letter_app/Features/news/data/models/news.dart';
import 'package:news_letter_app/Features/news/domain/repositories/News_repository.dart';

import '../../../../core/error/failures.dart';

class GetAllNews
{
  final NewsRepository repository;


  GetAllNews({required this.repository});

  Future<Either<Failure, List<NewsArticle>>> call(String interest) async
  {
    return await repository.gelAllNews(interest);
  }

}