import 'package:dartz/dartz.dart';

import 'package:news_letter_app/Features/news/data/models/news.dart';

import 'package:news_letter_app/core/error/failures.dart';

import '../../../../core/error/exception.dart';
import '../../domain/repositories/News_repository.dart';
import '../data_sources/remote_data_source.dart';

class NewsRepositoryImpl implements NewsRepository
{
  final NewsRemoteDatasource newsRemoteDatasource;

  NewsRepositoryImpl({required this.newsRemoteDatasource});

  @override
  Future<Either<Failure, List<NewsArticle>>> gelAllNews(String interest) async {

    try {
      final RemoteNews = await newsRemoteDatasource.getAllNews(interest);
      return Right(RemoteNews);
    } on ServerException {
      return left(ServerFailure());
    }
  }

}