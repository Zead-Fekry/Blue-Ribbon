part of 'news_cubit.dart';

@immutable
sealed class NewsState extends Equatable
{
  @override
  List<Object?> get props => [];
}

final class NewsInitial extends NewsState
{

}

class LoadingNewsState extends NewsState{}

class LoadedNewsState extends NewsState
{
final List<NewsArticle> news;

LoadedNewsState({ required this.news});
@override

List<Object?> get props => [news];
}

class ErrorNewsState extends NewsState
{
final String message ;

ErrorNewsState({required this.message});
List<Object?> get props => [message];
}
