import 'package:flutter/material.dart';
import '../../../../core/styles/colors/app_colors.dart';
import '../../data/models/news.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.title, maxLines: 1, overflow: TextOverflow.ellipsis), backgroundColor: AppColors.mainBlue,),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: article.urlToImage,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(article.urlToImage, width: double.infinity, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              article.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Published: ${article.publishedAt.toLocal()}",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 16),
            Text(
              article.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
