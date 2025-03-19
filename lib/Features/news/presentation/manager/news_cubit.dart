import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_letter_app/Features/news/data/models/news.dart';

import '../../../../core/error/failures.dart';
import '../../domain/use_cases/getAllNews.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final GetAllNews getAllNews;
  NewsCubit({required this.getAllNews}) : super(NewsInitial());

static NewsCubit get(context) =>BlocProvider.of(context);
Future<void> getAllNewsOrRefresh({required String interest})
async {
    emit(LoadingNewsState());
    final News = await getAllNews.call(interest);
    emit(_mapFailureOrnewsToState(News));

}
  NewsState _mapFailureOrnewsToState(Either<Failure, List<NewsArticle>> either) {
    return either.fold(
          (failure) {

        return ErrorNewsState(message: _mapFailureToMessage(failure));
      },
          (news) {
          // ✅ Append without resetting list
        return LoadedNewsState(news:news );
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "Server faliure Try Again";
      case OfflineFailure:
        return "Your Internet is disconnected";"Repeated Email Address";
      default:
        return"Try Again";
    }
  }



}
