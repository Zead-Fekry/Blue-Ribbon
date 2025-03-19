import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_letter_app/Features/news/presentation/manager/news_cubit.dart';
import 'package:shimmer/shimmer.dart';
import '/injection_container.dart' as di;
import '../Widgets/NewsListWidget.dart';

class NewsScreen extends StatefulWidget {
  final String interest;
  const NewsScreen({super.key, required this.interest});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    NewsCubit.get(context).getAllNewsOrRefresh(interest: widget.interest);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = NewsCubit.get(context);
    return Scaffold(
      appBar: AppBar(title: Text("Latest News")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is LoadingNewsState) {
              return _buildShimmerList();
            } else if (state is LoadedNewsState) {
              return RefreshIndicator(
                onRefresh: () => _onRefresh(context, cubit, widget.interest),
                child: NewsListWidget(news: state.news),
              );
            } else if (state is ErrorNewsState) {
              return RefreshIndicator(
                onRefresh: () => _onRefresh(context, cubit, widget.interest),
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

  Future<void> _onRefresh(BuildContext context, NewsCubit cubit, String interest) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        cubit.getAllNewsOrRefresh(interest: interest);
      }
    });
  }
}
Future<void> main()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp2(interest: "Teszxczxla",));
}

class MyApp2 extends StatefulWidget {
  final String interest;
  const MyApp2({super.key, required this.interest});

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MultiBlocProvider(providers: [ BlocProvider(create: (_) => di.sl<NewsCubit>()),], child:NewsScreen(interest:widget.interest,) ));
  }
}
