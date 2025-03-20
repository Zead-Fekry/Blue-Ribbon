import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_letter_app/Features/news/presentation/manager/news_cubit.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../Widgets/profile.dart';
import '/injection_container.dart' as di;
import '../Widgets/NewsListWidget.dart';

class NewsScreen extends StatefulWidget {
  final List<String> interests;
  final String? UserId;

  const NewsScreen({super.key, required this.interests, required this.UserId});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    NewsCubit.get(context).getAllNewsOrRefresh(interests: widget.interests);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = NewsCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.loginScreen,
                  (route) => false,
                ),
            icon: Icon(Icons.logout)),
        title: Row(
          children: [
            Text("Latest News"),
            IconButton(
                onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile(
                                  Userid: widget.UserId,
                                )),
                      )
                    },
                icon: Icon(Icons.person))
          ],
        ),
        backgroundColor: AppColors.mainBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is LoadingNewsState) {
              return _buildShimmerList();
            } else if (state is LoadedNewsState) {
              return RefreshIndicator(
                onRefresh: () => _onRefresh(context, cubit, widget.interests),
                child: NewsListWidget(news: state.news),
              );
            } else if (state is ErrorNewsState) {
              return RefreshIndicator(
                onRefresh: () => _onRefresh(context, cubit, widget.interests),
                child: Center(
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    );
  }

  Future<void> _onRefresh(
      BuildContext context, NewsCubit cubit, List<String> interests) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        cubit.getAllNewsOrRefresh(interests: interests);
      }
    });
  }
}
