import 'package:flutter/material.dart';
import '../../data/models/news.dart';
 import 'NewsDetails.dart';

class NewsListWidget extends StatelessWidget {
  final List<NewsArticle> news;

  const NewsListWidget({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        final article = news[index];

        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: Hero(
              tag: article.urlToImage, // Unique tag for smooth transition
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(article.urlToImage, width: 80, height: 80, fit: BoxFit.cover),
              ),
            ),
            title: Text(
              article.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(article.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(
                  "Published: ${article.publishedAt.toLocal()}",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(article: article),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
